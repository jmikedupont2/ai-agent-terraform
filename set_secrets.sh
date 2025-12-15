#!/bin/bash

# Script to set up required secrets for Eliza Twitter bot

echo "Setting up secrets for Eliza Twitter bot..."

# Check if required environment variables are set
if [ -z "$GROQ_API_KEY" ]; then
    echo "Error: GROQ_API_KEY environment variable is not set"
    echo "Please set it with: export GROQ_API_KEY=your_key_here"
    exit 1
fi

if [ -z "$TWITTER_USERNAME" ]; then
    echo "Error: TWITTER_USERNAME environment variable is not set"
    echo "Please set it with: export TWITTER_USERNAME=your_username"
    exit 1
fi

if [ -z "$TWITTER_PASSWORD" ]; then
    echo "Error: TWITTER_PASSWORD environment variable is not set"
    echo "Please set it with: export TWITTER_PASSWORD=your_password"
    exit 1
fi

if [ -z "$TWITTER_EMAIL" ]; then
    echo "Error: TWITTER_EMAIL environment variable is not set"
    echo "Please set it with: export TWITTER_EMAIL=your_email"
    exit 1
fi

# Set Groq API key
echo "Setting Groq API key..."
aws ssm put-parameter \
    --name "agent_groq_key" \
    --value "${GROQ_API_KEY}" \
    --type "SecureString" \
    --overwrite \
    --region us-west-1

# Set Twitter credentials
echo "Setting Twitter username..."
aws ssm put-parameter \
    --name "twitter_username" \
    --value "${TWITTER_USERNAME}" \
    --type "String" \
    --overwrite \
    --region us-west-1

echo "Setting Twitter password..."
aws ssm put-parameter \
    --name "twitter_password" \
    --value "${TWITTER_PASSWORD}" \
    --type "SecureString" \
    --overwrite \
    --region us-west-1

echo "Setting Twitter email..."
aws ssm put-parameter \
    --name "twitter_email" \
    --value "${TWITTER_EMAIL}" \
    --type "SecureString" \
    --overwrite \
    --region us-west-1

echo "All secrets have been set successfully!"
echo ""
echo "To verify, you can check the parameters:"
echo "aws ssm get-parameter --name agent_groq_key --region us-west-1"
echo "aws ssm get-parameter --name twitter_username --region us-west-1"