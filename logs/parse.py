from datamodel_code_generator import (    DataModelType,
    InputFileType,
    generate)
SEP="|"
#from itertools import combinations
# # in python
# open up logs/*.log and read out json

# {
#     "Events": [
#         {
#             "EventId": "3ea90966-2bc7-4d82-a208-91c4b8446f23",
#             "EventName": "GetLogEvents",
#             "ReadOnly": "true",
#             "AccessKeyId": "ASIA5K4H36GT4C65HRZX",
#             "EventTime": 1734818869.0,
#             "EventSource": "logs.amazonaws.com",
#             "Username": "dupont",
#             "Resources": [],
#             "CloudTrailEvent": "{\"eventVersion\":\"1.11\",\"userIdentity\":{\"type\":\"IAMUser\",\"principalId\":\"AIDA5K4H36GT5MJLQHPRT\",\"arn\":\"arn:aws:iam::916723593639:user/dupont\",\"accountId\":\"916723593639\",\"accessKeyId\"

#             CloudTrailEvent is a nested json

# To read JSON data from log files in a directory using Python, you can use the following code snippet:
import json
import glob
log_files = glob.glob('logs/*.log')
all_events = []
seen = {}

from pydantic import BaseModel, Field, create_model,ConfigDict
from datetime import datetime
from typing import List, Optional

# from https://github.com/aws-samples/amazon-dynamodb-pitr-table-sync/blob/43b0f85f1a6bb07b17fe7f20437eb9834601661e/src/model/aws/dynamodb/dynamodb_pitr_notification.py#L111

class SessionIssuer (BaseModel):
    _type:str
    principal_id: str = Field(None, alias="principalId")
    arn: str = Field(None)
    account_id: str = Field(None, alias="accountId")
    user_name: str = Field(None, alias="userName")


class SessionContext    (BaseModel):
    model_config = ConfigDict(extra="forbid")
    # userIdentity|sessionContext|attributes
    # userIdentity|sessionContext|attributes|creationDate
    # userIdentity|sessionContext|attributes|mfaAuthenticated
    # userIdentity|sessionContext|ec2RoleDelivery
    # userIdentity|sessionContext|sessionIssuer
    # userIdentity|sessionContext|sessionIssuer|accountId
    # userIdentity|sessionContext|sessionIssuer|arn
    # userIdentity|sessionContext|sessionIssuer|principalId
    # userIdentity|sessionContext|sessionIssuer|type
    # userIdentity|sessionContext|sessionIssuer|userName
    # userIdentity|sessionContext|webIdFederationData
    # userIdentity|sessionContext|webIdFederationData|federatedProvider
    #     "SessionContext",
    #     attributes=(
    #         create_model(
    #             "SessionContextAttributes",
    #             creation_date=(datetime, Field(None, alias="creationDate")),
    #             mfa_authenticated=(bool, Field(None, alias="mfaAuthenticated")),
    #         )
    #     ),
    session_issuer : Optional[SessionIssuer]
class UserIdentity(BaseModel):
    model_config = ConfigDict(extra="forbid")
    theType: str = Field(None, alias="type")
    principal_id: str = Field(None, alias="principalId")
    arn: str = Field(None)
    account_id: str = Field(None, alias="accountId")
    access_key_id: str = Field(None, alias="accessKeyId")
    userName :Optional[str] = None
    invokedBy  :Optional[str] = None
    identityProvider :Optional[str] = None
    principalId :Optional[str] = None
    sessionContext : Optional[SessionContext]=None
    theType: Optional[str] = Field(None, alias="type")


class RequestParameters(BaseModel):
    model_config = ConfigDict(extra="forbid")
    startTime:Optional[str] =None
    nextToken:Optional[str]= None
    
    # requestParameters
    # accelerate
    # accountId
    # accountIdentifiers|array[0]
    # accountIds|array[0]
    # acl
    # actionPrefix
    # actionsEnabled
    # activeOnly
    # agentName
    # agentStatus
    # agentVersion
    # alarmActions|array[0]
    # alarmDescription
    # alarmName
    # alarmNames|array[0]
    # alarmTypes|array[0]
    # alarmTypes|array[1]
    # allAvailabilityZones
    # allowedPattern
    # allowInvalidContent
    # allRegions
    # anomalyDetectorTypes|array[0]
    # anomalyDetectorTypes|array[1]
    # anomalyVisibilityTime
    # associationId
    # attribute
    # autoScalingGroupName
    # autoScalingGroupNames|array[0]
    # availabilityZone
    # availabilityZoneId
    # awsAccountId
    # baselineId
    # bucketName
    # byShared
    # certificateArn
    # clientId
    # clientInstanceId
    # clientName
    # clientToken
    # cloudWatchOutputConfig
    # cloudWatchOutputConfig|cloudWatchLogGroupName
    # cloudWatchOutputConfig|cloudWatchOutputEnabled
    # commandId
    # comment
    # comparisonOperator
    # complianceType
    # computerName
    # constraints
    # constraints|encryptionContextSubset
    # constraints|encryptionContextSubset|aws:ebs:id
    # content
    # cors
    # CreateLaunchTemplateRequest
    # CreateLaunchTemplateRequest|ClientToken
    # CreateLaunchTemplateRequest|LaunchTemplateData
    # CreateLaunchTemplateRequest|LaunchTemplateData|BlockDeviceMapping
    # CreateLaunchTemplateRequest|LaunchTemplateData|BlockDeviceMapping|DeviceName
    # CreateLaunchTemplateRequest|LaunchTemplateData|BlockDeviceMapping|Ebs
    # CreateLaunchTemplateRequest|LaunchTemplateData|BlockDeviceMapping|Ebs|Encrypted
    # CreateLaunchTemplateRequest|LaunchTemplateData|BlockDeviceMapping|Ebs|VolumeSize
    # CreateLaunchTemplateRequest|LaunchTemplateData|BlockDeviceMapping|Ebs|VolumeType
    # CreateLaunchTemplateRequest|LaunchTemplateData|BlockDeviceMapping|tag
    # CreateLaunchTemplateRequest|LaunchTemplateData|IamInstanceProfile
    # CreateLaunchTemplateRequest|LaunchTemplateData|IamInstanceProfile|Name
    # CreateLaunchTemplateRequest|LaunchTemplateData|ImageId
    # CreateLaunchTemplateRequest|LaunchTemplateData|InstanceType
    # CreateLaunchTemplateRequest|LaunchTemplateData|KeyName
    # CreateLaunchTemplateRequest|LaunchTemplateData|NetworkInterface
    # CreateLaunchTemplateRequest|LaunchTemplateData|NetworkInterface|AssociatePublicIpAddress
    # CreateLaunchTemplateRequest|LaunchTemplateData|NetworkInterface|DeleteOnTermination
    # CreateLaunchTemplateRequest|LaunchTemplateData|NetworkInterface|DeviceIndex
    # CreateLaunchTemplateRequest|LaunchTemplateData|NetworkInterface|NetworkCardIndex
    # CreateLaunchTemplateRequest|LaunchTemplateData|NetworkInterface|SecurityGroupId
    # CreateLaunchTemplateRequest|LaunchTemplateData|NetworkInterface|SecurityGroupId|content
    # CreateLaunchTemplateRequest|LaunchTemplateData|NetworkInterface|SecurityGroupId|tag
    # CreateLaunchTemplateRequest|LaunchTemplateData|NetworkInterface|tag
    # CreateLaunchTemplateRequest|LaunchTemplateData|UserData
    # CreateLaunchTemplateRequest|LaunchTemplateName
    # CreateLaunchTemplateRequest|TagSpecification
    # CreateLaunchTemplateRequest|TagSpecification|ResourceType
    # CreateLaunchTemplateRequest|TagSpecification|tag
    # CreateLaunchTemplateRequest|TagSpecification|Tag
    # CreateLaunchTemplateRequest|TagSpecification|Tag|Key
    # CreateLaunchTemplateRequest|TagSpecification|Tag|tag
    # CreateLaunchTemplateRequest|TagSpecification|Tag|Value
    # CreateLaunchTemplateVersionRequest
    # CreateLaunchTemplateVersionRequest|ClientToken
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|BlockDeviceMapping
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|BlockDeviceMapping|DeviceName
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|BlockDeviceMapping|Ebs
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|BlockDeviceMapping|Ebs|Encrypted
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|BlockDeviceMapping|Ebs|VolumeSize
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|BlockDeviceMapping|Ebs|VolumeType
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|BlockDeviceMapping|tag
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|IamInstanceProfile
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|IamInstanceProfile|Name
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|ImageId
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|InstanceType
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|KeyName
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|NetworkInterface
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|NetworkInterface|AssociatePublicIpAddress
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|NetworkInterface|DeleteOnTermination
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|NetworkInterface|DeviceIndex
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|NetworkInterface|NetworkCardIndex
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|NetworkInterface|SecurityGroupId
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|NetworkInterface|SecurityGroupId|content
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|NetworkInterface|SecurityGroupId|tag
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|NetworkInterface|tag
    # CreateLaunchTemplateVersionRequest|LaunchTemplateData|UserData
    # CreateLaunchTemplateVersionRequest|LaunchTemplateId
    # dashboardBody
    # dashboardName
    # DeleteLaunchTemplateRequest
    # DeleteLaunchTemplateRequest|LaunchTemplateId
    # descending
    # DescribeAddressesAttributeRequest
    # DescribeAddressesAttributeRequest|Attribute
    # DescribeAddressesAttributeRequest|MaxResults
    # DescribeAddressTransfersRequest
    # DescribeAddressTransfersRequest|MaxResults
    # DescribeCapacityReservationFleetsRequest
    # DescribeCapacityReservationFleetsRequest|MaxResults
    # DescribeCapacityReservationsRequest
    # DescribeCapacityReservationsRequest|MaxResults
    # DescribeFleetsRequest
    # DescribeFleetsRequest|MaxResults
    # DescribeFlowLogsRequest
    # DescribeHostsRequest
    # DescribeHostsRequest|MaxResults
    # DescribeInstanceConnectEndpointsRequest
    # DescribeInstanceConnectEndpointsRequest|MaxResults
    # DescribeInstanceCreditSpecificationsRequest
    # DescribeInstanceCreditSpecificationsRequest|InstanceId
    # DescribeInstanceCreditSpecificationsRequest|InstanceId|content
    # DescribeInstanceCreditSpecificationsRequest|InstanceId|tag
    # DescribeInstanceImageMetadataRequest
    # DescribeInstanceImageMetadataRequest|InstanceId
    # DescribeInstanceImageMetadataRequest|InstanceId|content
    # DescribeInstanceImageMetadataRequest|InstanceId|tag
    # DescribeInstanceTypeOfferingsRequest
    # DescribeInstanceTypeOfferingsRequest|LocationType
    # DescribeInstanceTypeOfferingsRequest|NextToken
    # DescribeInstanceTypesRequest
    # DescribeInstanceTypesRequest|InstanceType
    # DescribeInstanceTypesRequest|InstanceType|array[0]
    # DescribeInstanceTypesRequest|InstanceType|array[0]|content
    # DescribeInstanceTypesRequest|InstanceType|array[0]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[1]
    # DescribeInstanceTypesRequest|InstanceType|array[10]
    # DescribeInstanceTypesRequest|InstanceType|array[10]|content
    # DescribeInstanceTypesRequest|InstanceType|array[10]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[11]
    # DescribeInstanceTypesRequest|InstanceType|array[11]|content
    # DescribeInstanceTypesRequest|InstanceType|array[11]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[12]
    # DescribeInstanceTypesRequest|InstanceType|array[12]|content
    # DescribeInstanceTypesRequest|InstanceType|array[12]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[13]
    # DescribeInstanceTypesRequest|InstanceType|array[13]|content
    # DescribeInstanceTypesRequest|InstanceType|array[13]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[14]
    # DescribeInstanceTypesRequest|InstanceType|array[14]|content
    # DescribeInstanceTypesRequest|InstanceType|array[14]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[15]
    # DescribeInstanceTypesRequest|InstanceType|array[15]|content
    # DescribeInstanceTypesRequest|InstanceType|array[15]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[16]
    # DescribeInstanceTypesRequest|InstanceType|array[16]|content
    # DescribeInstanceTypesRequest|InstanceType|array[16]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[17]
    # DescribeInstanceTypesRequest|InstanceType|array[17]|content
    # DescribeInstanceTypesRequest|InstanceType|array[17]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[18]
    # DescribeInstanceTypesRequest|InstanceType|array[18]|content
    # DescribeInstanceTypesRequest|InstanceType|array[18]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[19]
    # DescribeInstanceTypesRequest|InstanceType|array[19]|content
    # DescribeInstanceTypesRequest|InstanceType|array[19]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[1]|content
    # DescribeInstanceTypesRequest|InstanceType|array[1]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[2]
    # DescribeInstanceTypesRequest|InstanceType|array[20]
    # DescribeInstanceTypesRequest|InstanceType|array[20]|content
    # DescribeInstanceTypesRequest|InstanceType|array[20]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[2]|content
    # DescribeInstanceTypesRequest|InstanceType|array[2]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[3]
    # DescribeInstanceTypesRequest|InstanceType|array[3]|content
    # DescribeInstanceTypesRequest|InstanceType|array[3]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[4]
    # DescribeInstanceTypesRequest|InstanceType|array[4]|content
    # DescribeInstanceTypesRequest|InstanceType|array[4]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[5]
    # DescribeInstanceTypesRequest|InstanceType|array[5]|content
    # DescribeInstanceTypesRequest|InstanceType|array[5]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[6]
    # DescribeInstanceTypesRequest|InstanceType|array[6]|content
    # DescribeInstanceTypesRequest|InstanceType|array[6]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[7]
    # DescribeInstanceTypesRequest|InstanceType|array[7]|content
    # DescribeInstanceTypesRequest|InstanceType|array[7]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[8]
    # DescribeInstanceTypesRequest|InstanceType|array[8]|content
    # DescribeInstanceTypesRequest|InstanceType|array[8]|tag
    # DescribeInstanceTypesRequest|InstanceType|array[9]
    # DescribeInstanceTypesRequest|InstanceType|array[9]|content
    # DescribeInstanceTypesRequest|InstanceType|array[9]|tag
    # DescribeInstanceTypesRequest|InstanceType|content
    # DescribeInstanceTypesRequest|InstanceType|tag
    # DescribeInstanceTypesRequest|MaxResults
    # DescribeInstanceTypesRequest|NextToken
    # DescribeLaunchTemplatesRequest
    # DescribeLaunchTemplatesRequest|LaunchTemplateId
    # DescribeLaunchTemplatesRequest|LaunchTemplateId|content
    # DescribeLaunchTemplatesRequest|LaunchTemplateId|tag
    # DescribeLaunchTemplatesRequest|LaunchTemplateName
    # DescribeLaunchTemplatesRequest|LaunchTemplateName|content
    # DescribeLaunchTemplatesRequest|LaunchTemplateName|tag
    # DescribeLaunchTemplatesRequest|MaxResults
    # DescribeLaunchTemplateVersionsRequest
    # DescribeLaunchTemplateVersionsRequest|LaunchTemplateId
    # DescribeLaunchTemplateVersionsRequest|LaunchTemplateVersion
    # DescribeLaunchTemplateVersionsRequest|LaunchTemplateVersion|array[0]
    # DescribeLaunchTemplateVersionsRequest|LaunchTemplateVersion|array[0]|content
    # DescribeLaunchTemplateVersionsRequest|LaunchTemplateVersion|array[0]|tag
    # DescribeLaunchTemplateVersionsRequest|LaunchTemplateVersion|array[1]
    # DescribeLaunchTemplateVersionsRequest|LaunchTemplateVersion|array[1]|content
    # DescribeLaunchTemplateVersionsRequest|LaunchTemplateVersion|array[1]|tag
    # DescribeLaunchTemplateVersionsRequest|LaunchTemplateVersion|content
    # DescribeLaunchTemplateVersionsRequest|LaunchTemplateVersion|tag
    # DescribeLaunchTemplateVersionsRequest|MaxResults
    # DescribeNatGatewaysRequest
    # DescribeNatGatewaysRequest|MaxResults
    # DescribeNetworkInsightsAccessScopesRequest
    # DescribeNetworkInsightsAccessScopesRequest|MaxResults
    # DescribeReplaceRootVolumeTasksRequest
    # DescribeReplaceRootVolumeTasksRequest|Filter
    # DescribeReplaceRootVolumeTasksRequest|Filter|Name
    # DescribeReplaceRootVolumeTasksRequest|Filter|tag
    # DescribeReplaceRootVolumeTasksRequest|Filter|Value
    # DescribeReplaceRootVolumeTasksRequest|Filter|Value|content
    # DescribeReplaceRootVolumeTasksRequest|Filter|Value|tag
    # DescribeReplaceRootVolumeTasksRequest|MaxResults
    # DescribeSecurityGroupRulesRequest
    # DescribeSecurityGroupRulesRequest|Filter
    # DescribeSecurityGroupRulesRequest|Filter|Name
    # DescribeSecurityGroupRulesRequest|Filter|tag
    # DescribeSecurityGroupRulesRequest|Filter|Value
    # DescribeSecurityGroupRulesRequest|Filter|Value|content
    # DescribeSecurityGroupRulesRequest|Filter|Value|tag
    # DescribeSecurityGroupRulesRequest|MaxResults
    # DescribeSpotFleetRequestsRequest
    # DescribeSpotFleetRequestsRequest|MaxResults
    # DescribeSpotFleetRequestsRequest|NextToken
    # DescribeTrafficMirrorFiltersRequest
    # DescribeTrafficMirrorFiltersRequest|MaxResults
    # DescribeTransitGatewayAttachmentsRequest
    # DescribeTransitGatewayAttachmentsRequest|Filter
    # DescribeTransitGatewayAttachmentsRequest|Filter|Name
    # DescribeTransitGatewayAttachmentsRequest|Filter|tag
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[0]
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[0]|content
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[0]|tag
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[1]
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[10]
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[10]|content
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[10]|tag
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[1]|content
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[1]|tag
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[2]
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[2]|content
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[2]|tag
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[3]
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[3]|content
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[3]|tag
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[4]
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[4]|content
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[4]|tag
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[5]
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[5]|content
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[5]|tag
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[6]
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[6]|content
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[6]|tag
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[7]
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[7]|content
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[7]|tag
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[8]
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[8]|content
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[8]|tag
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[9]
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[9]|content
    # DescribeTransitGatewayAttachmentsRequest|Filter|Value|array[9]|tag
    # DescribeTransitGatewayAttachmentsRequest|MaxResults
    # DescribeTransitGatewayConnectPeersRequest
    # DescribeTransitGatewayConnectPeersRequest|MaxResults
    # DescribeTransitGatewayPolicyTablesRequest
    # DescribeTransitGatewayPolicyTablesRequest|MaxResults
    # DescribeVpcEndpointsRequest
    # DescribeVpcEndpointsRequest|MaxResults
    # details
    # detectorName
    # dimensions|array[0]
    # dimensions|array[0]|name
    # dimensions|array[0]|value
    # dimensions|array[1]
    # dimensions|array[1]|name
    # dimensions|array[1]|value
    # dimensions|array[2]
    # dimensions|array[2]|name
    # dimensions|array[2]|value
    # dimensions|array[3]
    # dimensions|array[3]|name
    # dimensions|array[3]|value
    # disableApiStop
    # disableApiTermination
    # documentFormat
    # documentName
    # documentVersion
    # dryRun
    durationSeconds :Optional[str]=None
    # encryption
    # encryptionAlgorithm
    # encryptionContext
    # encryptionContext|aws:ebs:id
    # encryptionContext|aws:logs:arn
    # encryptionContext|aws:s3:arn
    # encryptionContext|aws:ssm:SessionId
    # encryptionContext|aws:ssm:TargetId
    # encryptionContext|PARAMETER_ARN
    # endTime
    # evaluationFrequency
    # evaluationPeriods
    # eventBusName
    # excludeAutoscalingAlarms
    # excludeManagedAlarms
    # executionResult
    # executionResult|errorCode
    # executionResult|executionDate
    # executionResult|executionSummary
    # executionResult|status
    # executionSummary
    # executionSummary|executionId
    # executionSummary|executionTime
    # executionSummary|executionType
    # expression
    # filterExpiredLogStreams
    # filterPattern
    # filters|array[0]
    # Filters|array[0]
    # filters|array[0]|key
    # Filters|array[0]|Key
    # filters|array[0]|name
    # filters|array[0]|value
    # filters|array[0]|values|array[0]
    # Filters|array[0]|Values|array[0]
    # filters|array[1]
    # filters|array[1]|key
    # filters|array[1]|value
    # filterSet
    # filterSet|items|array[0]
    # filterSet|items|array[0]|name
    # filterSet|items|array[0]|valueSet
    # filterSet|items|array[1]
    # filterSet|items|array[1]|name
    # filterSet|items|array[1]|valueSet
    # filterSet|items|array[1]|valueSet|items|array[0]
    # filterSet|items|array[1]|valueSet|items|array[0]|value
    # filtersWithOperator|array[0]
    # filtersWithOperator|array[0]|key
    # filtersWithOperator|array[0]|operator
    # filtersWithOperator|array[0]|values|array[0]
    # fingerprint
    # force
    # GetAllowedImagesSettingsRequest
    # GetInstanceTypesFromInstanceRequirementsRequest
    # GetInstanceTypesFromInstanceRequirementsRequest|ArchitectureType
    # GetInstanceTypesFromInstanceRequirementsRequest|ArchitectureType|content
    # GetInstanceTypesFromInstanceRequirementsRequest|ArchitectureType|tag
    # GetInstanceTypesFromInstanceRequirementsRequest|InstanceRequirements
    # GetInstanceTypesFromInstanceRequirementsRequest|InstanceRequirements|MemoryMiB
    # GetInstanceTypesFromInstanceRequirementsRequest|InstanceRequirements|MemoryMiB|Min
    # GetInstanceTypesFromInstanceRequirementsRequest|InstanceRequirements|VCpuCount
    # GetInstanceTypesFromInstanceRequirementsRequest|InstanceRequirements|VCpuCount|Min
    # GetInstanceTypesFromInstanceRequirementsRequest|VirtualizationType
    # GetInstanceTypesFromInstanceRequirementsRequest|VirtualizationType|content
    # GetInstanceTypesFromInstanceRequirementsRequest|VirtualizationType|tag
    # GetSecurityGroupsForVpcRequest
    # GetSecurityGroupsForVpcRequest|Filter
    # GetSecurityGroupsForVpcRequest|Filter|Name
    # GetSecurityGroupsForVpcRequest|Filter|tag
    # GetSecurityGroupsForVpcRequest|Filter|Value
    # GetSecurityGroupsForVpcRequest|Filter|Value|content
    # GetSecurityGroupsForVpcRequest|Filter|Value|tag
    # GetSecurityGroupsForVpcRequest|MaxResults
    # GetSecurityGroupsForVpcRequest|VpcId
    # granteePrincipal
    # Host
    # imagesSet
    # imagesSet|items|array[0]
    # imagesSet|items|array[0]|imageId
    # includeAllInstances
    # include|array[0]
    # includePublic
    # includePublicKey
    # includes
    # includeShadowTrails
    # includeShared
    # includes|hasDnsFqdn
    # includes|keyTypes|array[0]
    # includes|keyTypes|array[1]
    # includes|keyTypes|array[2]
    # includes|keyTypes|array[3]
    # includes|keyTypes|array[4]
    # includes|keyTypes|array[5]
    # includes|keyTypes|array[6]
    # instanceArns|array[0]
    # instanceId
    # instanceIds|array[0]
    # instancesSet
    # instancesSet|items|array[0]
    # instancesSet|items|array[0]|instanceId
    # instancesSet|items|array[0]|maxCount
    # instancesSet|items|array[0]|minCount
    # instancesSet|items|array[1]
    # instancesSet|items|array[1]|instanceId
    # instancesSet|items|array[2]
    # instancesSet|items|array[2]|instanceId
    # instancesSet|items|array[3]
    # instancesSet|items|array[3]|instanceId
    # instanceType
    # intelligent-tiering
    # interactive
    # internetGatewayIdSet
    # internetGatewayIdSet|items|array[0]
    # internetGatewayIdSet|items|array[0]|internetGatewayId
    # iPAddress
    # itemContentHash
    # items|array[0]
    # items|array[0]|captureTime
    # items|array[0]|contentHash
    # items|array[0]|details
    # items|array[0]|details|DocumentName
    # items|array[0]|details|DocumentVersion
    # items|array[0]|id
    # items|array[0]|schemaVersion
    # items|array[0]|severity
    # items|array[0]|status
    # items|array[0]|title
    # items|array[0]|typeName
    # items|array[1]
    # items|array[1]|captureTime
    # items|array[1]|contentHash
    # items|array[1]|schemaVersion
    # items|array[1]|typeName
    # items|array[2]
    # items|array[2]|captureTime
    # items|array[2]|contentHash
    # items|array[2]|schemaVersion
    # items|array[2]|typeName
    # items|array[3]
    # items|array[3]|captureTime
    # items|array[3]|contentHash
    # items|array[3]|schemaVersion
    # items|array[3]|typeName
    # items|array[4]
    # items|array[4]|captureTime
    # items|array[4]|contentHash
    # items|array[4]|schemaVersion
    # items|array[4]|typeName
    # keyId
    # keySet
    # keySet|items|array[0]
    # keySet|items|array[0]|keyName
    # keySpec
    # kmsKeyId
    # launchTemplate
    # launchTemplate|launchTemplateId
    # launchTemplate|version
    # lifecycle
    # limit
    # listenerArn
    # listenerArns|array[0]
    # loadBalancerArn
    # loadBalancerArns|array[0]
    # location
    # logging
    # logGroupArnList|array[0]
    # logGroupClass
    # logGroupIdentifier
    # logGroupIdentifiers|array[0]
    # logGroupIdentifiers|array[1]
    # logGroupIdentifiers|array[2]
    # logGroupIdentifiers|array[3]
    # logGroupIdentifiers|array[4]
    # logGroupIdentifiers|array[5]
    # logGroupIdentifiers|array[6]
    # logGroupName
    # logGroupNamePrefix
    # logGroupNames|array[0]
    # logStreamName
    # logStreamNamePrefix
    # lookupAttributes|array[0]
    # lookupAttributes|array[0]|attributeKey
    # lookupAttributes|array[0]|attributeValue
    # marker
    # maxConcurrency
    # maxErrors
    # MaxItems
    # maxRecords
    # maxResults
    # MaxResults
    # messageSchemaVersion
    # metricName
    # monitoring
    # monitoring|enabled
    # name
    # namespace
    # networkAclIdSet
    # networkAclIdSet|items|array[0]
    # networkAclIdSet|items|array[0]|networkAclId
    # networkInterfaceIdSet
    # networkInterfaceIdSet|items|array[0]
    # networkInterfaceIdSet|items|array[0]|networkInterfaceId
    # networkInterfaceSet
    # networkInterfaceSet|items|array[0]
    # networkInterfaceSet|items|array[0]|deviceIndex
    # networkInterfaceSet|items|array[0]|networkCardIndex
    # networkInterfaceSet|items|array[0]|subnetId
    # newInstancesProtectedFromScaleIn
    # nextToken
    # notification
    # numberOfBytes
    # object-lock
    # operations|array[0]
    # orderBy
    # outputS3BucketName
    # overwrite
    # ownershipControls
    # ownersSet
    # ownersSet|items|array[0]
    # ownersSet|items|array[0]|owner
    # pageSize
    # paginationToken
    # parameterFilters|array[0]
    # parameterFilters|array[0]|key
    # parameterFilters|array[0]|option
    # parameterFilters|array[0]|values|array[0]
    # parameters
    # period
    # permissionType
    # platformName
    # platformType
    # platformVersion
    # pluginName
    # policy
    # policyName
    # policyNames|array[0]
    # policyType
    # policyTypes|array[0]
    # policyTypes|array[1]
    # policyTypes|array[2]
    # preferences
    # preferences|autoRollback
    # preferences|maxHealthyPercentage
    # preferences|minHealthyPercentage
    # preferences|scaleInProtectedInstances
    # preferences|skipMatching
    # preferences|standbyInstances
    # publicAccessBlock
    # publicKey
    # publicKeyType
    # queryId
    # queryLanguage
    # queryString


    # queryString|fields @timestamp, @message, @logStream, @log
    # replication
    # requestId
    # requestPayment
    # requireAcknowledgement
    # resourceArn
    # resourceARN
    # resourceArns|array[0]
    # resourceId
    # resourcesPerPage
    # resourcesSet
    # resourcesSet|items|array[0]
    # resourcesSet|items|array[0]|resourceId
    # resourceType
    # resourceTypeFilters|array[0]
    # resultAttributes|array[0]
    # resultAttributes|array[0]|typeName
    # retentionInDays
    # retiringPrincipal
    roleArn:Optional[str]=None
    roleSessionName:Optional[str]=None
    # routeTableIdSet
    # routeTableIdSet|items|array[0]
    # routeTableIdSet|items|array[0]|routeTableId
    # rule
    # ruleArns|array[0]
    # securityGroupIdSet
    # securityGroupIdSet|items|array[0]
    # securityGroupIdSet|items|array[0]|groupId
    # ServerSideEncryptionConfiguration
    # ServerSideEncryptionConfiguration|Rule
    # ServerSideEncryptionConfiguration|Rule|ApplyServerSideEncryptionByDefault
    # ServerSideEncryptionConfiguration|Rule|ApplyServerSideEncryptionByDefault|KMSMasterKeyID
    # ServerSideEncryptionConfiguration|Rule|ApplyServerSideEncryptionByDefault|SSEAlgorithm
    # ServerSideEncryptionConfiguration|Rule|BucketKeyEnabled
    # ServerSideEncryptionConfiguration|xmlns
    # serviceNamespace
    # sessionId
    # showSubscriptionDestinations
    # snapshotType
    # sSMConnectionChannel
    # stackStatusFilter|array[0]
    # stackStatusFilter|array[1]
    # stackStatusFilter|array[10]
    # stackStatusFilter|array[11]
    # stackStatusFilter|array[12]
    # stackStatusFilter|array[13]
    # stackStatusFilter|array[14]
    # stackStatusFilter|array[15]
    # stackStatusFilter|array[16]
    # stackStatusFilter|array[17]
    # stackStatusFilter|array[18]
    # stackStatusFilter|array[19]
    # stackStatusFilter|array[2]
    # stackStatusFilter|array[3]
    # stackStatusFilter|array[4]
    # stackStatusFilter|array[5]
    # stackStatusFilter|array[6]
    # stackStatusFilter|array[7]
    # stackStatusFilter|array[8]
    # stackStatusFilter|array[9]
    # startFromHead
    # startTime
    # state
    # stateValue
    # statistic
    # status
    # subnetSet
    # subnetSet|items|array[0]
    # subnetSet|items|array[0]|subnetId
    # tagFilters|array[0]
    # tagFilters|array[0]|key
    # tagging
    # Tagging
    # Tagging|TagSet
    # Tagging|TagSet|Tag
    # Tagging|TagSet|Tag|Key
    # Tagging|TagSet|Tag|Value
    # Tagging|xmlns
    # tags
    # tags|array[0]
    # tags|array[0]|key
    # tags|array[0]|tagKey
    # tags|array[0]|tagValue
    # tags|array[0]|value
    # tagSet
    # tagSet|items|array[0]
    # tagSet|items|array[0]|key
    # tagSet|items|array[0]|value
    # tagSpecificationSet
    # tagSpecificationSet|items|array[0]
    # tagSpecificationSet|items|array[0]|resourceType
    # tagSpecificationSet|items|array[0]|tags|array[0]
    # tagSpecificationSet|items|array[0]|tags|array[0]|key
    # tagSpecificationSet|items|array[0]|tags|array[0]|value
    # tagSpecificationSet|items|array[0]|tags|array[1]
    # tagSpecificationSet|items|array[0]|tags|array[1]|key
    # tagSpecificationSet|items|array[0]|tags|array[1]|value
    # tags|project
    # target
    # targetGroupArn
    # targetGroupArns|array[0]
    # targets|array[0]
    # targets|array[0]|id
    # targets|array[0]|key
    # targets|array[0]|values|array[0]
    # template
    # threshold
    # tier
    # timeoutSeconds
    # topicArn
    # trafficSourceType
    # type
    # Type
    # unmask
    # value
    # versioning
    # visibility
    # volumeSet
    # volumeSet|items|array[0]
    # volumeSet|items|array[0]|volumeId
    # vpcId
    # vpcSet
    # vpcSet|items|array[0]
    # vpcSet|items|array[0]|vpcId
    # website
    # windowId
    # windowTaskId
    # withDecryption

class Credentials(BaseModel):
    model_config = ConfigDict(extra="forbid")

class ResponseElements(BaseModel):
    model_config = ConfigDict(extra="forbid")
    nextToken : Optional[str] = None
    credentials : Optional[Credentials]=None
class TLSDetails(BaseModel):
    model_config = ConfigDict(extra="forbid")
    tlsVersion: str
    cipherSuite: str
    clientProvidedHostHeader: str
class Resource(BaseModel):
    model_config = ConfigDict(extra="forbid")
    account_id: str #, Field(None, alias="account_id")),
    type: str 
    arn: str #, Field(None, alias="ARN")),

    
class EventDetail(BaseModel):
    model_config = ConfigDict(extra="forbid")
    event_version: Optional[str] = Field(None, alias="eventVersion")
    user_identity: UserIdentity = Field(None, alias="userIdentity")
    event_time: datetime = Field(None, alias="eventTime")
    event_source: str = Field(None, alias="eventSource")
    event_name: str = Field(None, alias="eventName")
    aws_region: str = Field(None, alias="awsRegion")
    source_ip_address: str = Field(None, alias="sourceIPAddress")
    user_agent: str = Field(None, alias="userAgent")
    request_parameters: Optional[RequestParameters] = Field(
        None, alias="requestParameters"
    )
    response_elements: Optional[ ResponseElements]  = Field(None, alias="responseElements")
    request_id: str = Field(None, alias="requestID")
    event_id: str = Field(None, alias="eventID")
    read_only: bool = Field(None, alias="readOnly")
    tlsDetails: Optional[TLSDetails]
    resources: Optional[List[Resource]] = None
    event_type: str = Field(None, alias="eventType")
    api_version: str = Field(None, alias="apiVersion")
    management_event: bool = Field(None, alias="managementEvent")
    recipient_account_id: str = Field(None, alias="recipientAccountId")
    event_category: str = Field(None, alias="eventCategory")
    session_credential_from_console: bool = Field(
        None, alias="sessionCredentialFromConsole"
    )

    errorCode: Optional[str] = None
    errorMessage: Optional[str] = None
    
def process1(v,path):
    skip =0
    #print(path,len(path))
    lpth = len(path)

    # eventType
    # eventName
    # eventVersion
    # eventSource
    # eventTime


    # apiVersion
    # awsRegion
    # errorCode
    # errorMessage
    # eventCategory
    # eventID
    # managementEvent
    # readOnly
    # recipientAccountId
    # requestID
    # sessionCredentialFromConsole
    # sharedEventID
    # sourceIPAddress
    
    # tlsDetails
    # tlsDetails|cipherSuite
    # tlsDetails|clientProvidedHostHeader
    # tlsDetails|tlsVersion

    # userAgent

    
    # additionalEventData
    # additionalEventData|AuthenticationMethod
    # additionalEventData|bytesTransferredIn
    # additionalEventData|bytesTransferredOut
    # additionalEventData|CipherSuite
    # additionalEventData|grantId
    # additionalEventData|identityProviderConnectionVerificationMethod
    # additionalEventData|LoginTo
    # additionalEventData|MFAUsed
    # additionalEventData|MobileVersion
    # additionalEventData|service
    # additionalEventData|SignatureVersion
    # additionalEventData|x-amz-id-2

    # resources|array[0]
    # resources|array[0]|accountId
    # resources|array[0]|ARN
    # resources|array[0]|type
    # resources|array[1]
    # resources|array[10]
    # resources|array[10]|accountId
    # resources|array[10]|ARN
    # resources|array[10]|type
    # resources|array[11]
    # resources|array[11]|accountId
    # resources|array[11]|ARN
    # resources|array[11]|type
    # resources|array[1]|accountId
    # resources|array[1]|ARN
    # resources|array[1]|type
    # resources|array[2]
    # resources|array[2]|accountId
    # resources|array[2]|ARN
    # resources|array[2]|type
    # resources|array[3]
    # resources|array[3]|accountId
    # resources|array[3]|ARN
    # resources|array[3]|type
    # resources|array[4]
    # resources|array[4]|accountId
    # resources|array[4]|ARN
    # resources|array[4]|type
    # resources|array[5]
    # resources|array[5]|accountId
    # resources|array[5]|ARN
    # resources|array[5]|type
    # resources|array[6]
    # resources|array[6]|accountId
    # resources|array[6]|ARN
    # resources|array[6]|type
    # resources|array[7]
    # resources|array[7]|accountId
    # resources|array[7]|ARN
    # resources|array[7]|type
    # resources|array[8]
    # resources|array[8]|accountId
    # resources|array[8]|ARN
    # resources|array[8]|type
    # resources|array[9]
    # resources|array[9]|accountId
    # resources|array[9]|ARN
    # resources|array[9]|type


    # responseElements
    # responseElements|anomalyDetectorArn
    # responseElements|assumedRoleUser
    # responseElements|assumedRoleUser|arn
    # responseElements|assumedRoleUser|assumedRoleId
    # responseElements|audience
    # responseElements|command
    # responseElements|command|alarmConfiguration
    # responseElements|command|alarmConfiguration|ignorePollAlarmFailure
    # responseElements|command|clientName
    # responseElements|command|clientSourceId
    # responseElements|command|cloudWatchOutputConfig
    # responseElements|command|cloudWatchOutputConfig|cloudWatchLogGroupName
    # responseElements|command|cloudWatchOutputConfig|cloudWatchOutputEnabled
    # responseElements|command|commandId
    # responseElementso|command|comment
    # responseElements|command|completedCount
    # responseElements|command|deliveryTimedOutCount
    # responseElements|command|documentName
    # responseElements|command|documentVersion
    # responseElements|command|errorCount
    # responseElements|command|expiresAfter
    # responseElements|command|hasCancelCommandSignature
    # responseElements|command|hasSendCommandSignature
    # responseElements|command|instanceIds|array[0]
    # responseElements|command|interactive
    # responseElements|command|maxConcurrency
    # responseElements|command|maxErrors
    # responseElements|command|notificationConfig
    # responseElements|command|notificationConfig|notificationArn
    # responseElements|command|notificationConfig|notificationType
    # responseElements|command|outputS3BucketName
    # responseElements|command|outputS3KeyPrefix
    # responseElements|command|outputS3Region
    # responseElements|command|parameters
    # responseElements|command|requestedDateTime
    # responseElements|command|serviceRole
    # responseElements|command|status
    # responseElements|command|statusDetails
    # responseElements|command|targetCount
    # responseElements|command|targets|array[0]
    # responseElements|command|targets|array[0]|key
    # responseElements|command|targets|array[0]|values|array[0]
    # responseElements|command|timeoutSeconds
    # responseElements|ConsoleLogin
    # responseElements|CreateLaunchTemplateResponse
    # responseElements|CreateLaunchTemplateResponse|launchTemplate
    # responseElements|CreateLaunchTemplateResponse|launchTemplate|createdBy
    # responseElements|CreateLaunchTemplateResponse|launchTemplate|createTime
    # responseElements|CreateLaunchTemplateResponse|launchTemplate|defaultVersionNumber
    # responseElements|CreateLaunchTemplateResponse|launchTemplate|latestVersionNumber
    # responseElements|CreateLaunchTemplateResponse|launchTemplate|launchTemplateId
    # responseElements|CreateLaunchTemplateResponse|launchTemplate|launchTemplateName
    # responseElements|CreateLaunchTemplateResponse|launchTemplate|operator
    # responseElements|CreateLaunchTemplateResponse|launchTemplate|operator|managed
    # responseElements|CreateLaunchTemplateResponse|launchTemplate|tagSet
    # responseElements|CreateLaunchTemplateResponse|launchTemplate|tagSet|item
    # responseElements|CreateLaunchTemplateResponse|launchTemplate|tagSet|item|key
    # responseElements|CreateLaunchTemplateResponse|launchTemplate|tagSet|item|value
    # responseElements|CreateLaunchTemplateResponse|requestId
    # responseElements|CreateLaunchTemplateResponse|xmlns
    # responseElements|CreateLaunchTemplateVersionResponse
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|createdBy
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|createTime
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|defaultVersion
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|blockDeviceMappingSet
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|blockDeviceMappingSet|item
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|blockDeviceMappingSet|item|deviceName
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|blockDeviceMappingSet|item|ebs
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|blockDeviceMappingSet|item|ebs|encrypted
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|blockDeviceMappingSet|item|ebs|volumeSize
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|blockDeviceMappingSet|item|ebs|volumeType
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|iamInstanceProfile
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|iamInstanceProfile|name
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|imageId
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|instanceType
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|keyName
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|networkInterfaceSet
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|networkInterfaceSet|item
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|networkInterfaceSet|item|associatePublicIpAddress
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|networkInterfaceSet|item|deleteOnTermination
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|networkInterfaceSet|item|deviceIndex
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|networkInterfaceSet|item|groupSet
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|networkInterfaceSet|item|groupSet|groupId
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|networkInterfaceSet|item|networkCardIndex
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateData|userData
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateId
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|launchTemplateName
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|operator
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|operator|managed
    # responseElements|CreateLaunchTemplateVersionResponse|launchTemplateVersion|versionNumber
    # responseElements|CreateLaunchTemplateVersionResponse|requestId
    # responseElements|CreateLaunchTemplateVersionResponse|xmlns
    # responseElements|credentials
    # responseElements|credentials|accessKeyId
    # responseElements|credentials|expiration
    # responseElements|credentials|sessionToken
    # responseElements|DeleteLaunchTemplateResponse
    # responseElements|DeleteLaunchTemplateResponse|launchTemplate
    # responseElements|DeleteLaunchTemplateResponse|launchTemplate|createdBy
    # responseElements|DeleteLaunchTemplateResponse|launchTemplate|createTime
    # responseElements|DeleteLaunchTemplateResponse|launchTemplate|defaultVersionNumber
    # responseElements|DeleteLaunchTemplateResponse|launchTemplate|latestVersionNumber
    # responseElements|DeleteLaunchTemplateResponse|launchTemplate|launchTemplateId
    # responseElements|DeleteLaunchTemplateResponse|launchTemplate|launchTemplateName
    # responseElements|DeleteLaunchTemplateResponse|launchTemplate|operator
    # responseElements|DeleteLaunchTemplateResponse|launchTemplate|operator|managed
    # responseElements|DeleteLaunchTemplateResponse|requestId
    # responseElements|DeleteLaunchTemplateResponse|xmlns
    # responseElements|description
    # responseElements|description|defaultVersion
    # responseElements|description|name
    # responseElements|documentDescription
    # responseElements|documentDescription|createdDate
    # responseElements|documentDescription|defaultVersion
    # responseElements|documentDescription|documentFormat
    # responseElements|documentDescription|documentId
    # responseElements|documentDescription|documentType
    # responseElements|documentDescription|documentVersion
    # responseElements|documentDescription|hash
    # responseElements|documentDescription|hashType
    # responseElements|documentDescription|latestVersion
    # responseElements|documentDescription|name
    # responseElements|documentDescription|owner
    # responseElements|documentDescription|platformTypes|array[0]
    # responseElements|documentDescription|platformTypes|array[1]
    # responseElements|documentDescription|platformTypes|array[2]
    # responseElements|documentDescription|schemaVersion
    # responseElements|documentDescription|status
    # responseElements|documentDescription|tags|array[0]
    # responseElements|documentDescription|tags|array[0]|key
    # responseElements|documentDescription|tags|array[0]|value
    # responseElements|grantId
    # responseElements|instanceId
    # responseElements|instanceRefreshId
    # responseElements|instancesSet
    # responseElements|instancesSet|items|array[0]
    # responseElements|instancesSet|items|array[0]|amiLaunchIndex
    # responseElements|instancesSet|items|array[0]|architecture
    # responseElements|instancesSet|items|array[0]|bootMode
    # responseElements|instancesSet|items|array[0]|capacityReservationSpecification
    # responseElements|instancesSet|items|array[0]|capacityReservationSpecification|capacityReservationPreference
    # responseElements|instancesSet|items|array[0]|clientToken
    # responseElements|instancesSet|items|array[0]|cpuOptions
    # responseElements|instancesSet|items|array[0]|cpuOptions|coreCount
    # responseElements|instancesSet|items|array[0]|cpuOptions|threadsPerCore
    # responseElements|instancesSet|items|array[0]|currentInstanceBootMode
    # responseElements|instancesSet|items|array[0]|currentState
    # responseElements|instancesSet|items|array[0]|currentState|code
    # responseElements|instancesSet|items|array[0]|currentState|name
    # responseElements|instancesSet|items|array[0]|ebsOptimized
    # responseElements|instancesSet|items|array[0]|enaSupport
    # responseElements|instancesSet|items|array[0]|enclaveOptions
    # responseElements|instancesSet|items|array[0]|enclaveOptions|enabled
    # responseElements|instancesSet|items|array[0]|groupSet
    # responseElements|instancesSet|items|array[0]|groupSet|items|array[0]
    # responseElements|instancesSet|items|array[0]|groupSet|items|array[0]|groupId
    # responseElements|instancesSet|items|array[0]|groupSet|items|array[0]|groupName
    # responseElements|instancesSet|items|array[0]|hypervisor
    # responseElements|instancesSet|items|array[0]|iamInstanceProfile
    # responseElements|instancesSet|items|array[0]|iamInstanceProfile|arn
    # responseElements|instancesSet|items|array[0]|iamInstanceProfile|id
    # responseElements|instancesSet|items|array[0]|imageId
    # responseElements|instancesSet|items|array[0]|instanceId
    # responseElements|instancesSet|items|array[0]|instanceState
    # responseElements|instancesSet|items|array[0]|instanceState|code
    # responseElements|instancesSet|items|array[0]|instanceState|name
    # responseElements|instancesSet|items|array[0]|instanceType
    # responseElements|instancesSet|items|array[0]|keyName
    # responseElements|instancesSet|items|array[0]|launchTime
    # responseElements|instancesSet|items|array[0]|maintenanceOptions
    # responseElements|instancesSet|items|array[0]|maintenanceOptions|autoRecovery
    # responseElements|instancesSet|items|array[0]|metadataOptions
    # responseElements|instancesSet|items|array[0]|metadataOptions|httpEndpoint
    # responseElements|instancesSet|items|array[0]|metadataOptions|httpProtocolIpv4
    # responseElements|instancesSet|items|array[0]|metadataOptions|httpProtocolIpv6
    # responseElements|instancesSet|items|array[0]|metadataOptions|httpPutResponseHopLimit
    # responseElements|instancesSet|items|array[0]|metadataOptions|httpTokens
    # responseElements|instancesSet|items|array[0]|metadataOptions|instanceMetadataTags
    # responseElements|instancesSet|items|array[0]|metadataOptions|state
    # responseElements|instancesSet|items|array[0]|monitoring
    # responseElements|instancesSet|items|array[0]|monitoring|state
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|attachment
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|attachment|attachmentId
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|attachment|attachTime
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|attachment|deleteOnTermination
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|attachment|deviceIndex
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|attachment|networkCardIndex
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|attachment|status
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|groupSet
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|groupSet|items|array[0]
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|groupSet|items|array[0]|groupId
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|groupSet|items|array[0]|groupName
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|interfaceType
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|macAddress
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|networkInterfaceId
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|operator
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|operator|managed
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|ownerId
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|privateDnsName
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|privateIpAddress
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|privateIpAddressesSet
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|privateIpAddressesSet|item|array[0]
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|privateIpAddressesSet|item|array[0]|primary
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|privateIpAddressesSet|item|array[0]|privateDnsName
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|privateIpAddressesSet|item|array[0]|privateIpAddress
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|sourceDestCheck
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|status
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|subnetId
    # responseElements|instancesSet|items|array[0]|networkInterfaceSet|items|array[0]|vpcId
    # responseElements|instancesSet|items|array[0]|operator
    # responseElements|instancesSet|items|array[0]|operator|managed
    # responseElements|instancesSet|items|array[0]|placement
    # responseElements|instancesSet|items|array[0]|placement|availabilityZone
    # responseElements|instancesSet|items|array[0]|placement|tenancy
    # responseElements|instancesSet|items|array[0]|previousState
    # responseElements|instancesSet|items|array[0]|previousState|code
    # responseElements|instancesSet|items|array[0]|previousState|name
    # responseElements|instancesSet|items|array[0]|privateDnsName
    # responseElements|instancesSet|items|array[0]|privateDnsNameOptions
    # responseElements|instancesSet|items|array[0]|privateDnsNameOptions|enableResourceNameDnsAAAARecord
    # responseElements|instancesSet|items|array[0]|privateDnsNameOptions|enableResourceNameDnsARecord
    # responseElements|instancesSet|items|array[0]|privateDnsNameOptions|hostnameType
    # responseElements|instancesSet|items|array[0]|privateIpAddress
    # responseElements|instancesSet|items|array[0]|rootDeviceName
    # responseElements|instancesSet|items|array[0]|rootDeviceType
    # responseElements|instancesSet|items|array[0]|sourceDestCheck
    # responseElements|instancesSet|items|array[0]|stateReason
    # responseElements|instancesSet|items|array[0]|stateReason|code
    # responseElements|instancesSet|items|array[0]|stateReason|message
    # responseElements|instancesSet|items|array[0]|subnetId
    # responseElements|instancesSet|items|array[0]|tagSet
    # responseElements|instancesSet|items|array[0]|tagSet|items|array[0]
    # responseElements|instancesSet|items|array[0]|tagSet|items|array[0]|key
    # responseElements|instancesSet|items|array[0]|tagSet|items|array[0]|value
    # responseElements|instancesSet|items|array[0]|tagSet|items|array[1]
    # responseElements|instancesSet|items|array[0]|tagSet|items|array[1]|key
    # responseElements|instancesSet|items|array[0]|tagSet|items|array[1]|value
    # responseElements|instancesSet|items|array[0]|tagSet|items|array[2]
    # responseElements|instancesSet|items|array[0]|tagSet|items|array[2]|key
    # responseElements|instancesSet|items|array[0]|tagSet|items|array[2]|value
    # responseElements|instancesSet|items|array[0]|tagSet|items|array[3]
    # responseElements|instancesSet|items|array[0]|tagSet|items|array[3]|key
    # responseElements|instancesSet|items|array[0]|tagSet|items|array[3]|value
    # responseElements|instancesSet|items|array[0]|virtualizationType
    # responseElements|instancesSet|items|array[0]|vpcId
    # responseElements|keyId
    # responseElements|messageSchemaVersion
    # responseElements|ownerId
    # responseElements|packedPolicySize
    # responseElements|provider
    # responseElements|queryId
    # responseElements|requesterId
    # responseElements|requestId
    # responseElements|reservationId
    # responseElements|_return
    # responseElements|sessionId
    # responseElements|streamUrl
    # responseElements|subjectFromWebIdentityToken
    # responseElements|tier
    # responseElements|tokenValue
    # responseElements|version

    # serviceEventDetails
    # serviceEventDetails|DocumentName
    # serviceEventDetails|IdleSessionTimeout
    # serviceEventDetails|IsCloudWatchEncryptionEnabled
    # serviceEventDetails|IsKmsEncryptionEnabled
    # serviceEventDetails|IsS3EncryptionEnabled
    # serviceEventDetails|MaxSessionDuration


    # userIdentity
    
    # vpcEndpointAccountId
    # vpcEndpointId

    if (lpth == 6)  and (path[0] in ["CloudTrailEvent"]) and (path[1] in ["userIdentity"]) and (path[2] in ["sessionContext"]) and (path[3] in ["sessionIssuer"]) and (path[4] in ["userName"]) :
        if path[5] in ["aws:ec2-infrastructure",
                        "aws:ec2-instance",
                        "AWSServiceRoleForAmazonSSM"
                        "AWSServiceRoleForAutoScaling",
                        "AWSServiceRoleForCloudWatchApplicationSignals",
                        "AWSServiceRoleForConfig",
                        "AWSServiceRoleForResourceExplorer",
                        "github",
                        "ssm-swarms-role"]:
            interesting =1
        elif (path[4] in ["accountId","arn","principalId","type","userName"]):
              pass
        
#if (lpth == 6)  and (path[0] in ["CloudTrailEvent"]) and (path[1] in ["userIdentity"]) and (path[2] in ["sessionContext"]) and (path[3] in ["webIdFederationData"]) and (path[4] in ["federatedProvider"]) and (path[5] in ["arn:aws:iam::916723593639:oidc-provider/token.actions.githubusercontent.com"]):
    
    # if (lpth>2):
    #     if path[1] in ["userIdentity"]:
    #         if path[2] in ["accessKeyId"]:
    #             skip =1
    #     if path[1] in [    "requestParameters"]:
            
    #         if path[2] in [ "startTime", "nextToken"]:
    #             skip =1
   
    #elif (lpth>1):
    #        if path[1] in ["eventID","requestID","eventTime"]:
    #            skip = 1
    if skip:
        return
    if isinstance(v,list):
        for i,j in enumerate(v):
            path2= path.copy()
            path2.extend(["array" + "["+str(i)+"]"])
            #v2 = v[i]
            process1(j,path2)
               
    elif isinstance(v,dict):
        # we are in the next level of substructrue 
        for k2 in v:
            v2= v[k2]
            path2= path.copy()
            path2.extend([k2])
            qk2 = SEP.join(path2)
            vt2 = type(v2)
            if qk2 not in seen:

                seen[qk2] =1
            else:
                seen[qk2] = seen[qk2] + 1               
                # some of these we can add directly
                #print("DEBUG2",qk2,vt2)
            process1(v2,path2)
    else:
        path2= path.copy()
        path2.extend([str(v)])
        qk2 = SEP.join(path2)
        if qk2 not in seen:                
            seen[qk2] =1
        else:
            seen[qk2] =  seen[qk2] + 1
            # some of these we can add directly
        #print("DEBUG3",qk2,v,seen[qk2])
            #process1("1",path2)

report = {}
results = {}
items = []
for log_file in log_files:
    with open(log_file, 'r') as f:
        try:
            event_data = json.load(f)
        except Exception as e:
            print(log_file,e)
        e1 = event_data.get("Events", [])
        for e in e1:
            #print(e1)
            target = "CloudTrailEvent"
            if target in e:
                e2 = json.loads(e[target]) # eval again
                #print("DEBUG1",e2)
                #ct = EventDetail(**e2)
                items.append(e2)
                
result = generate(items,
                  disable_timestamp=True,
                  enable_version_header = False,
                  input_file_type=InputFileType.Dict,
                  input_filename=None,
                  #output=output_file,
                  output_model_type=DataModelType.PydanticV2BaseModel,
                  snake_case_field=True
                  )
#print("DEBUG1",e2, result)
if result not in results:
    results[result] =1
    print(result)
    for k in e2:
        v= e2[k]
        qualified_path = [target,k]
        qk = SEP.join(qualified_path)
        vt = type(v)
        if qk not in seen:                
            seen[qk] =1
        else:
            seen[qk] = seen[qk] +1
        process1(v,qualified_path)
            
        # now report on the event
        facts = sorted(seen.keys())
        seen = {}
        #for x in facts:
        #    v = seen[x]
        #    if (v>0):
    #facts.append("\t".join([str(v),x]))
    #    seen[x] =0 # reset
    #for p in combinations(facts,3):
    #print(facts)
    for f in facts:
        #k = ".".join(p)
        if f not in report:
            report[f] = 1                    
    else:
        report[f] =  report[f] + 1

for k in report:
    parts = k.split("|")
    parts.pop() # remove the last one
    #lpth = len(parts)
    #parts2 = f"if (lpth == {lpth}) "
    #for e,i in enumerate(parts):
    #    parts2 = parts2 + f" and (path[{e}] in [\"{i}\"])"
    #print(parts2 + ":")
    #print("""|".join(parts[1:]))
    #print(k,report[k])
#print(all_events)  # or process the events as needed

# ### Explanation:
# 1. **glob** is used to match all log files in the `logs` directory.
# 2. The code reads each log file line by line and attempts to decode each line as JSON.
# 3. Any parsed events are collected in the `all_events` list.
# 4. Handle JSON decoding errors gracefully.



#                 import boto3, argparse, json
# from datetime import datetime, timedelta

# # Parse command line arguments
# parser = argparse.ArgumentParser(description='Generate an IAM policy based on CloudTrail events.')
# parser.add_argument('--service', dest='service_name', required=True,
#                     help='The name of the AWS service to generate a policy for (e.g., "ec2", "s3", "lambda", etc.)')
# parser.add_argument('--region', dest='region_name', required=True,
#                     help='The AWS region to search for CloudTrail events in')
# parser.add_argument('--hours', dest='hours_ago', type=int, default=2,
#                     help='The number of hours to look back in the CloudTrail events (default is 2)')
# args = parser.parse_args()

# # Initialize CloudTrail client
# client = boto3.client('cloudtrail', region_name=args.region_name)

# # Calculate start time for CloudTrail lookup
# start_time = datetime.utcnow() - timedelta(hours=args.hours_ago)

# # Dictionary to store permissions by service
# permissions_by_service = {}

# # Paginate through CloudTrail events
# for response in client.get_paginator('lookup_events').paginate(
#         StartTime=start_time,
#         EndTime=datetime.utcnow(),
#         LookupAttributes=[
#             {
#                 'AttributeKey': 'EventSource',
#                 'AttributeValue': f'{args.service_name}.amazonaws.com'
#             }
#         ]
# ):
#     # Iterate through events and extract permissions
#     for event in response['Events']:
#         permission = event['EventName']
#         if ":" in permission:
#             service, action = permission.split(':')
#         else:
#             service = args.service_name
#             action = permission
#         permissions_by_service.setdefault(service, set()).add(action)

# # Create policy statement
# policy = {
#     "Version": "2012-10-17",
#     "Statement": []
# }

# # Iterate through permissions by service and add to policy statement
# for service, actions in permissions_by_service.items():
#     statement = {
#         "Sid": "VisualEditor0",
#         "Effect": "Allow",
#         "Action": [f"{service}:{action}" for action in actions],
#         "Resource": "*"
#     }
#     policy["Statement"].append(statement)

# # Print policy in JSON format
# print(f"last: {args.hours_ago}h")
# print(f"service name filter: {args.service_name}")
# print(json.dumps(policy, indent=4))

ideas = """
1. some fields have unique values, count of one, all of them.
CloudTrailEvent.requestID
CloudTrailEvent.eventID

2. some timestamps overlap, we can round up the time into chunks.
"""
