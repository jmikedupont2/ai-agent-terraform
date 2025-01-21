  KMSKey00fe2fb040de7a48f1b54dc99cbb00ed66008yFV0:
    UpdateReplacePolicy: "Retain"
    Type: "AWS::KMS::Key"
    DeletionPolicy: "Retain"
    Properties:
      Origin: "AWS_KMS"
      MultiRegion: false
      Description: "SSM Key"
      KeyPolicy:
        Version: "2012-10-17"
        Statement:
        - Resource: "*"
          Action: "kms:*"
          Effect: "Allow"
          Principal:
            AWS: "arn:aws:iam::767503528736:root"
          Sid: "KMS Key Default"
        - Resource: "*"
          Action:
          - "kms:ReEncrypt*"
          - "kms:GenerateDataKey*"
          - "kms:Encrypt*"
          - "kms:Describe*"
          - "kms:Decrypt*"
          Effect: "Allow"
          Principal:
            Service: "logs.us-east-2.amazonaws.com"
          Sid: "CloudWatchLogsEncryption"
      KeySpec: "SYMMETRIC_DEFAULT"
      Enabled: true
      EnableKeyRotation: true
      KeyUsage: "ENCRYPT_DECRYPT"
      Tags:
      - Value: "tine"
        Key: "project"
