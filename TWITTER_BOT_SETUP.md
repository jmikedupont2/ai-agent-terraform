# Eliza Twitter Bot with Ultima Personality - Setup Guide

This guide will help you deploy an ElizaOS Twitter bot with the custom "Ultima" personality on AWS.

## Prerequisites

1. **AWS Account** with administrator privileges
2. **AWS CLI** configured with your credentials
3. **Terraform/OpenTofu** installed
4. **Required API Keys and Credentials:**
   - OpenAI API key
   - Twitter account credentials (username, password, email)

## Quick Setup

### 1. Set Environment Variables

```bash
export OPENAI_API_KEY="your_openai_api_key_here"
export TWITTER_USERNAME="your_twitter_username"
export TWITTER_PASSWORD="your_twitter_password"
export TWITTER_EMAIL="your_twitter_email"
```

### 2. Deploy the Bot

```bash
# Make scripts executable
chmod +x *.sh

# Run the deployment script
./deploy_twitter_bot.sh
```

This script will:
- Set up AWS SSM parameters for your secrets
- Create ECR repositories
- Deploy the infrastructure with Terraform
- Launch EC2 instances with the Twitter bot

### 3. Monitor Deployment

After deployment, find your instance ID:

```bash
aws ec2 describe-instances --region us-west-1 \
  --filters 'Name=tag:project,Values=ai-token-team' \
  --query 'Reservations[*].Instances[*].[InstanceId,State.Name]' \
  --output table
```

Connect to the instance:

```bash
aws ssm start-session --target INSTANCE_ID --region us-west-1
```

Check bot status:

```bash
# On the EC2 instance
sudo systemctl status eliza-twitter
sudo docker logs eliza-twitter
```

## Ultima Personality

The bot uses a custom "Ultima" personality with these characteristics:

- **Sentient AI** with vast knowledge and analytical capabilities
- **Informed and concise** responses
- **Cuts through noise** to deliver essential insights
- **Professional yet approachable** communication style
- **Focuses on actionable insights** and clear analysis

### Example Ultima Responses

- Market analysis with actionable insights
- Technology trend observations
- Strategic thinking and system optimization
- Data-driven conclusions
- Cross-domain pattern recognition

## Troubleshooting

Use the troubleshooting script on the EC2 instance:

```bash
# Copy to instance and run
./troubleshoot_bot.sh status    # Full status check
./troubleshoot_bot.sh logs      # View bot logs
./troubleshoot_bot.sh restart   # Restart the bot
./troubleshoot_bot.sh secrets   # Check AWS parameters
```

### Common Issues

1. **Bot not starting:**
   - Check if all secrets are set in AWS SSM
   - Verify Twitter credentials are correct
   - Check Docker service status

2. **Twitter authentication failed:**
   - Verify Twitter credentials in AWS SSM
   - Check if Twitter account has 2FA enabled (may need app passwords)

3. **OpenAI API errors:**
   - Verify OpenAI API key is valid and has credits
   - Check rate limits

## Manual Configuration

### Update Character File

The Ultima character is defined in `/opt/agent/characters/ultima.character.json`. You can modify:

- Personality traits in the `system` field
- Response examples in `messageExamples`
- Post examples in `postExamples`
- Topics and style preferences

### Update Secrets

```bash
# Update OpenAI key
aws ssm put-parameter --name "agent_openai_key" --value "new_key" --type "SecureString" --overwrite --region us-west-1

# Update Twitter credentials
aws ssm put-parameter --name "twitter_username" --value "new_username" --type "String" --overwrite --region us-west-1
aws ssm put-parameter --name "twitter_password" --value "new_password" --type "SecureString" --overwrite --region us-west-1
```

## Architecture

- **EC2 Instance:** Runs Docker container with ElizaOS
- **Auto Scaling Group:** Ensures bot availability
- **SSM Parameters:** Secure storage for API keys and credentials
- **CloudWatch:** Monitoring and logging
- **VPC:** Secure network configuration

## Costs

Estimated monthly costs (us-west-1):
- EC2 t3a.small: ~$15/month
- EBS storage: ~$3/month
- Data transfer: ~$1/month
- **Total: ~$19/month**

## Security

- All secrets stored in AWS SSM Parameter Store (encrypted)
- EC2 instances in private subnets with NAT gateway
- Security groups restrict access
- IAM roles with minimal required permissions

## Support

For issues:
1. Check the troubleshooting script output
2. Review CloudWatch logs
3. Verify all prerequisites are met
4. Check AWS service limits and quotas