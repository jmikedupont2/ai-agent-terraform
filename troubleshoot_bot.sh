#!/bin/bash

# Troubleshooting script for Eliza Twitter Bot

echo "=== Eliza Twitter Bot Troubleshooting ==="
echo ""

# Function to check if we're on the EC2 instance
check_instance() {
    if [ ! -f /opt/aws/bin/cfn-signal ]; then
        echo "This script should be run on the EC2 instance."
        echo "Connect to your instance first with:"
        echo "aws ssm start-session --target i-1234567890abcdef0 --region us-west-1"
        exit 1
    fi
}

# Function to check Docker status
check_docker() {
    echo "=== Docker Status ==="
    systemctl status docker --no-pager
    echo ""
    
    echo "=== Docker Containers ==="
    docker ps -a
    echo ""
}

# Function to check bot service
check_bot_service() {
    echo "=== Eliza Twitter Bot Service Status ==="
    systemctl status eliza-twitter --no-pager
    echo ""
}

# Function to check bot logs
check_bot_logs() {
    echo "=== Eliza Twitter Bot Logs (last 50 lines) ==="
    docker logs --tail 50 eliza-twitter 2>/dev/null || echo "Container not running or doesn't exist"
    echo ""
}

# Function to check secrets
check_secrets() {
    echo "=== Checking AWS SSM Parameters ==="
    
    echo "OpenAI API Key:"
    aws ssm get-parameter --name "agent_openai_key" --region us-west-1 --query 'Parameter.Name' --output text 2>/dev/null || echo "NOT FOUND"
    
    echo "Twitter Username:"
    aws ssm get-parameter --name "twitter_username" --region us-west-1 --query 'Parameter.Value' --output text 2>/dev/null || echo "NOT FOUND"
    
    echo "Twitter Password:"
    aws ssm get-parameter --name "twitter_password" --region us-west-1 --query 'Parameter.Name' --output text 2>/dev/null || echo "NOT FOUND"
    
    echo "Twitter Email:"
    aws ssm get-parameter --name "twitter_email" --region us-west-1 --query 'Parameter.Name' --output text 2>/dev/null || echo "NOT FOUND"
    echo ""
}

# Function to check character file
check_character_file() {
    echo "=== Character File Status ==="
    if [ -f "/opt/agent/characters/ultima.character.json" ]; then
        echo "✓ Ultima character file exists"
        echo "File size: $(stat -c%s /opt/agent/characters/ultima.character.json) bytes"
    else
        echo "✗ Ultima character file missing"
        echo "Expected location: /opt/agent/characters/ultima.character.json"
    fi
    echo ""
}

# Function to restart the bot
restart_bot() {
    echo "=== Restarting Eliza Twitter Bot ==="
    systemctl stop eliza-twitter
    docker stop eliza-twitter 2>/dev/null || true
    docker rm eliza-twitter 2>/dev/null || true
    systemctl start eliza-twitter
    echo "Bot restarted. Check status with: systemctl status eliza-twitter"
    echo ""
}

# Function to show help
show_help() {
    echo "Usage: $0 [option]"
    echo ""
    echo "Options:"
    echo "  status    - Show all status information"
    echo "  logs      - Show bot logs"
    echo "  restart   - Restart the bot service"
    echo "  secrets   - Check AWS SSM parameters"
    echo "  help      - Show this help message"
    echo ""
    echo "If no option is provided, 'status' is used by default."
}

# Main execution
case "${1:-status}" in
    "status")
        check_instance
        check_docker
        check_bot_service
        check_bot_logs
        check_secrets
        check_character_file
        ;;
    "logs")
        check_instance
        check_bot_logs
        ;;
    "restart")
        check_instance
        restart_bot
        ;;
    "secrets")
        check_secrets
        ;;
    "help")
        show_help
        ;;
    *)
        echo "Unknown option: $1"
        show_help
        exit 1
        ;;
esac