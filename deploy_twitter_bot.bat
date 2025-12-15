@echo off
echo === Eliza Twitter Bot Deployment Script ===
echo.

REM Check if we're in the right directory
if not exist "accounts\AI_Token_Team\main.tf" (
    echo Error: Please run this script from the ai-agent-terraform root directory
    pause
    exit /b 1
)

REM Check AWS CLI configuration
echo Checking AWS configuration...
aws sts get-caller-identity >nul 2>&1
if errorlevel 1 (
    echo Error: AWS CLI not configured. Please run 'aws configure' first.
    pause
    exit /b 1
)

echo AWS configuration OK
echo.

REM Check required environment variables
echo Checking required environment variables...
set MISSING_VARS=

if "%GROQ_API_KEY%"=="" (
    set MISSING_VARS=GROQ_API_KEY
)

if "%TWITTER_USERNAME%"=="" (
    set MISSING_VARS=%MISSING_VARS% TWITTER_USERNAME
)

if "%TWITTER_PASSWORD%"=="" (
    set MISSING_VARS=%MISSING_VARS% TWITTER_PASSWORD
)

if "%TWITTER_EMAIL%"=="" (
    set MISSING_VARS=%MISSING_VARS% TWITTER_EMAIL
)

if not "%MISSING_VARS%"=="" (
    echo Error: Missing required environment variables: %MISSING_VARS%
    echo.
    echo Please set them with:
    echo set GROQ_API_KEY=your_groq_key
    echo set TWITTER_USERNAME=your_twitter_username
    echo set TWITTER_PASSWORD=your_twitter_password
    echo set TWITTER_EMAIL=your_twitter_email
    pause
    exit /b 1
)

echo Environment variables OK
echo.

REM Set up secrets in AWS SSM
echo Setting up secrets in AWS SSM Parameter Store...
aws ssm put-parameter --name "agent_groq_key" --value "%GROQ_API_KEY%" --type "SecureString" --overwrite --region us-east-1
aws ssm put-parameter --name "twitter_username" --value "%TWITTER_USERNAME%" --type "String" --overwrite --region us-east-1
aws ssm put-parameter --name "twitter_password" --value "%TWITTER_PASSWORD%" --type "SecureString" --overwrite --region us-east-1
aws ssm put-parameter --name "twitter_email" --value "%TWITTER_EMAIL%" --type "SecureString" --overwrite --region us-east-1

REM Create ECR repositories
echo Creating ECR repositories...
aws ecr create-repository --repository-name agent/eliza --region us-east-1 2>nul || echo Repository agent/eliza already exists

REM Deploy infrastructure
echo Deploying infrastructure...
cd accounts\AI_Token_Team

REM Initialize Terraform
echo Initializing Terraform...
terraform init

REM Apply SSM parameters first
echo Applying SSM configuration...
terraform apply -target=module.ssm_observer.aws_ssm_parameter.cw_agent_config -target=module.ssm_observer.aws_ssm_parameter.cw_agent_config_details -auto-approve

REM Apply full infrastructure
echo Applying full infrastructure...
terraform apply -auto-approve

echo.
echo === Deployment Complete ===
echo.
echo Your Eliza Twitter bot with Ultima personality is being deployed!
echo.
echo To check the status:
echo 1. Find your instance ID:
echo    aws ec2 describe-instances --region us-east-1 --filters "Name=tag:project,Values=ai-token-team" --query "Reservations[*].Instances[*].[InstanceId,State.Name]" --output table
echo.
echo 2. Connect to the instance:
echo    aws ssm start-session --target i-1234567890abcdef0 --region us-east-1
echo.
echo 3. Check the bot status:
echo    sudo systemctl status eliza-twitter
echo    sudo docker logs eliza-twitter
echo.
echo The bot will automatically start posting as Ultima on Twitter!
pause