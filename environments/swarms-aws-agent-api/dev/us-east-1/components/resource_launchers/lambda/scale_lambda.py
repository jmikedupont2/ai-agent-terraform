#You'll need to create a file named `scale_lambda.py` in the `lambda/` directory with content like the following:

#```python
import boto3
import os

def handler(event, context):
    asg_name = os.environ['AUTO_SCALING_GROUP_NAME']
    client = boto3.client('autoscaling')

    response = client.describe_auto_scaling_groups(AutoScalingGroupNames=[asg_name])
    desired_capacity = response['AutoScalingGroups'][0]['DesiredCapacity']
    
    # Example scaling logic
    client.set_desired_capacity(
        AutoScalingGroupName=asg_name,
        DesiredCapacity=desired_capacity + 1,  # Increment desired instances
        HonorCooldown=True
    )
