#!/bin/bash
set -e

# Docker run script for Eliza Twitter bot
echo "Starting Eliza Twitter bot with Ultima character..."

# Set environment variables
export GROQ_API_KEY=$(aws ssm get-parameter --name "agent_groq_key" --with-decryption --query 'Parameter.Value' --output text --region us-west-1)
export TWITTER_USERNAME=${TWITTER_USERNAME:-"UltimaAI"}
export TWITTER_PASSWORD=$(aws ssm get-parameter --name "twitter_password" --with-decryption --query 'Parameter.Value' --output text --region us-west-1 2>/dev/null || echo "")
export TWITTER_EMAIL=$(aws ssm get-parameter --name "twitter_email" --with-decryption --query 'Parameter.Value' --output text --region us-west-1 2>/dev/null || echo "")

# Pull latest Eliza image
docker pull elizaos/eliza:latest

# Stop existing container if running
docker stop eliza-twitter || true
docker rm eliza-twitter || true

# Create systemd service for the bot
cat > /etc/systemd/system/eliza-twitter.service << EOF
[Unit]
Description=Eliza Twitter Bot
After=docker.service
Requires=docker.service

[Service]
Type=simple
Restart=always
RestartSec=10
ExecStart=/usr/bin/docker run --name eliza-twitter \\
  -e GROQ_API_KEY=${GROQ_API_KEY} \\
  -e TWITTER_USERNAME=${TWITTER_USERNAME} \\
  -e TWITTER_PASSWORD=${TWITTER_PASSWORD} \\
  -e TWITTER_EMAIL=${TWITTER_EMAIL} \\
  -v /opt/agent/characters:/app/characters \\
  elizaos/eliza:latest --characters=/app/characters/ultima.character.json
ExecStop=/usr/bin/docker stop eliza-twitter
ExecStopPost=/usr/bin/docker rm eliza-twitter

[Install]
WantedBy=multi-user.target
EOF

# Enable and start the service
systemctl daemon-reload
systemctl enable eliza-twitter
systemctl start eliza-twitter

echo "Eliza Twitter bot started successfully!"
echo "Check status with: systemctl status eliza-twitter"
echo "View logs with: docker logs eliza-twitter"