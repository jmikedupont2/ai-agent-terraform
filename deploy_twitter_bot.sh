#!/bin/bash

# Deployment script for Eliza Twitter Bot with Ultima personality

set -e

echo "=== Eliza Twitter Bot Deployment Script ==="
echo ""

# Check if we're in the right directory
if [ ! -f "accounts/AI_Token_Team/main.tf" ]; then
    echo "Error: Please run this script from the ai-agent-terraform root directory"
    exit 1
fi

# Check AWS CLI configuration
echo "Checking AWS configuration..."
if ! aws sts get-caller-identity > /dev/null 2>&1; then
    echo "Error: AWS CLI not configured. Please run 'aws configure' first."
    exit 1
fi

echo "AWS configuration OK"
echo ""

# Check required environment variables for secrets
echo "Checking required environment variables..."
MISSING_VARS=()

if [ -z "$GROQ_API_KEY" ]; then
    MISSING_VARS+=("GROQ_API_KEY")
fi

if [ -z "$TWITTER_USERNAME" ]; then
    MISSING_VARS+=("TWITTER_USERNAME")
fi

if [ -z "$TWITTER_PASSWORD" ]; then
    MISSING_VARS+=("TWITTER_PASSWORD")
fi

if [ -z "$TWITTER_EMAIL" ]; then
    MISSING_VARS+=("TWITTER_EMAIL")
fi

if [ ${#MISSING_VARS[@]} -gt 0 ]; then
    echo "Error: Missing required environment variables:"
    for var in "${MISSING_VARS[@]}"; do
        echo "  - $var"
    done
    echo ""
    echo "Please set them with:"
    echo "export GROQ_API_KEY=your_groq_key"
    echo "export TWITTER_USERNAME=your_twitter_username"
    echo "export TWITTER_PASSWORD=your_twitter_password"
    echo "export TWITTER_EMAIL=your_twitter_email"
    exit 1
fi

echo "Environment variables OK"
echo ""

# Set up secrets in AWS SSM
echo "Setting up secrets in AWS SSM Parameter Store..."
bash set_secrets.sh

# Create ECR repositories if they don't exist
echo "Creating ECR repositories..."
aws ecr create-repository --repository-name agent/eliza --region us-west-1 2>/dev/null || echo "Repository agent/eliza already exists"

# Deploy infrastructure
echo "Deploying infrastructure..."
cd accounts/AI_Token_Team

# Initialize Terraform
echo "Initializing Terraform..."
terraform init

# Apply SSM parameters first
echo "Applying SSM configuration..."
terraform apply -target=module.ssm_observer.aws_ssm_parameter.cw_agent_config -target=module.ssm_observer.aws_ssm_parameter.cw_agent_config_details -auto-approve

# Apply full infrastructure
echo "Applying full infrastructure..."
terraform apply -auto-approve

echo ""
echo "=== Deployment Complete ==="
echo ""
echo "Your Eliza Twitter bot with Ultima personality is being deployed!"
echo ""
echo "To check the status:"
echo "1. Find your instance ID:"
echo "   aws ec2 describe-instances --region us-west-1 --filters 'Name=tag:project,Values=ai-token-team' --query 'Reservations[*].Instances[*].[InstanceId,State.Name]' --output table"
echo ""
echo "2. Connect to the instance:"
echo "   aws ssm start-session --target i-1234567890abcdef0 --region us-west-1"
echo ""
echo "3. Check the bot status:"
echo "   sudo systemctl status eliza-twitter"
echo "   sudo docker logs eliza-twitter"
echo ""
echo "The bot will automatically start posting as Ultima on Twitter!"