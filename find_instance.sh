#!/bin/bash
echo "Finding running instances..."
aws ec2 describe-instances --region us-east-1 \
  --filters 'Name=tag:project,Values=ai-token-team' 'Name=instance-state-name,Values=running' \
  --query 'Reservations[*].Instances[*].[InstanceId,State.Name,Tags[?Key==`Name`].Value|[0]]' \
  --output table

echo ""
echo "To connect to an instance, use:"
echo "aws ssm start-session --target ACTUAL_INSTANCE_ID --region us-east-1"