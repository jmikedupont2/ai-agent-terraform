variable "google_oauth_client_secret" {}
variable "google_oauth_client_id" {} 
variable aws_region {} # us-east-1
variable aws_account {}
variable myemail {}
variable mydomain {}
variable mydomain_suffix {}
locals {
  mydomain=var.mydomain
  mydomain_suffix = var.mydomain_suffix
  mydomain_dot_com = "${local.mydomain}.${local.mydomain_suffix}"
  myemail=var.myemail
  myaccount=var.aws_account
}

module "aws_cognito_user_pool_complete_example" {

  source = "lgallard/cognito-user-pool/aws"

  user_pool_name             = "mypool_complete"
  alias_attributes           = ["email", "phone_number"]
  auto_verified_attributes   = ["email"]
  sms_authentication_message = "Your username is {username} and temporary password is {####}."
  sms_verification_message   = "This is the verification message {####}."

  deletion_protection = "ACTIVE"

  mfa_configuration = "OPTIONAL"
  software_token_mfa_configuration = {
    enabled = true
  }

  admin_create_user_config = {
    email_message = "Dear {username}, your verification code is {####}."
    email_subject = "Here, your verification code baby"
    sms_message   = "Your username is {username} and temporary password is {####}."
  }

  device_configuration = {
    challenge_required_on_new_device      = true
    device_only_remembered_on_user_prompt = true
  }

  email_configuration = {
    email_sending_account  = "DEVELOPER"
    reply_to_email_address = "email@${local.mydomain_dot_com}"
    source_arn             = "arn:aws:ses:${var.aws_region}:${var.aws_account}:identity/${local.myemail}@${local.mydomain_dot_com}"
  }

  lambda_config = {
    create_auth_challenge          = "arn:aws:lambda:${var.aws_region}:${var.aws_account}:function:create_auth_challenge"
    custom_message                 = "arn:aws:lambda:${var.aws_region}:${var.aws_account}:function:custom_message"
    define_auth_challenge          = "arn:aws:lambda:${var.aws_region}:${var.aws_account}:function:define_auth_challenge"
    post_authentication            = "arn:aws:lambda:${var.aws_region}:${var.aws_account}:function:post_authentication"
    post_confirmation              = "arn:aws:lambda:${var.aws_region}:${var.aws_account}:function:post_confirmation"
    pre_authentication             = "arn:aws:lambda:${var.aws_region}:${var.aws_account}:function:pre_authentication"
    pre_sign_up                    = "arn:aws:lambda:${var.aws_region}:${var.aws_account}:function:pre_sign_up"
#    pre_token_generation           = "arn:aws:lambda:${var.aws_region}:${var.aws_account}:function:pre_token_generation"
    user_migration                 = "arn:aws:lambda:${var.aws_region}:${var.aws_account}:function:user_migration"
    verify_auth_challenge_response = "arn:aws:lambda:${var.aws_region}:${var.aws_account}:function:verify_auth_challenge_response"
    #kms_key_id                     = aws_kms_key.lambda-custom-sender.arn
    pre_token_generation_config = {
      lambda_arn     = "arn:aws:lambda:${var.aws_region}:${var.aws_account}:function:pre_token_generation_config"
      lambda_version = "V1_0"
    }
    #custom_email_sender = {
    #  lambda_arn     = "arn:aws:lambda:${var.aws_region}:${var.aws_account}:function:custom_email_sender"
    #  lambda_version = "V1_0"
    #}
    #custom_sms_sender = {
    #  lambda_arn     = "arn:aws:lambda:${var.aws_region}:${var.aws_account}:function:custom_sms_sender"
    #  lambda_version = "V1_0"
    #}
  }

  password_policy = {
    minimum_length                   = 10
    require_lowercase                = false
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 120

  }

  user_pool_add_ons = {
    advanced_security_mode = "ENFORCED"
  }

  verification_message_template = {
    default_email_option = "CONFIRM_WITH_CODE"
  }

  schemas = [
    {
      attribute_data_type      = "Boolean"
      developer_only_attribute = false
      mutable                  = true
      name                     = "available"
      required                 = false
    },
    {
      attribute_data_type      = "Boolean"
      developer_only_attribute = true
      mutable                  = true
      name                     = "registered"
      required                 = false
    }
  ]

  string_schemas = [
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = false
      name                     = "email"
      required                 = true

      string_attribute_constraints = {
        min_length = 7
        max_length = 15
      }
    },
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = false
      name                     = "gender"
      required                 = true

      string_attribute_constraints = {
        min_length = 7
        max_length = 15
      }
    },
  ]

  number_schemas = [
    {
      attribute_data_type      = "Number"
      developer_only_attribute = true
      mutable                  = true
      name                     = "mynumber1"
      required                 = false

      number_attribute_constraints = {
        min_value = 2
        max_value = 6
      }
    },
    {
      attribute_data_type      = "Number"
      developer_only_attribute = true
      mutable                  = true
      name                     = "mynumber2"
      required                 = false

      number_attribute_constraints = {
        min_value = 2
        max_value = 6
      }
    },
  ]

  # user_pool_domain
  domain = "${local.mydomain}-com"

  # clients
  clients = [
    {
      allowed_oauth_flows_user_pool_client = false
      allowed_oauth_scopes                 = []
      callback_urls                        = ["https://${local.mydomain_dot_com}/callback"]
      default_redirect_uri                 = "https://${local.mydomain_dot_com}/callback"
      explicit_auth_flows                  = []
      generate_secret                      = true
      logout_urls                          = []
      name                                 = "test1"
      read_attributes                      = ["email"]
      supported_identity_providers         = []
      write_attributes                     = []
      access_token_validity                = 1
      id_token_validity                    = 1
      refresh_token_validity               = 60
      token_validity_units = {
        access_token  = "hours"
        id_token      = "hours"
        refresh_token = "days"
      }
      ui_customization_css        = file("./custom_style.css")
      ui_customization_image_file = filebase64("logo.png")
    },
    {
      allowed_oauth_flows                  = [
         "code",
         "implicit"
      ]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = [
        "aws.cognito.signin.user.admin",
        "email",
        "https://introspector.meme/sample-scope-1",
        "https://introspector.meme/sample-scope-2",
        "openid",
        "phone",
        "profile",

      ]
      callback_urls                        = ["https://${local.mydomain_dot_com}/callback"]
      default_redirect_uri                 = "https://${local.mydomain_dot_com}/callback"
      explicit_auth_flows                  = []
      generate_secret                      = false
      logout_urls                          = []
      name                                 = "test2"
      read_attributes                      = []
      supported_identity_providers         = [
        "COGNITO",
        "Google",

      ]
      write_attributes                     = []
      refresh_token_validity               = 30
    },
    {
      allowed_oauth_flows                  = ["code", "implicit"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = ["email", "openid"]
      callback_urls                        = ["https://${local.mydomain_dot_com}/callback"]
      default_redirect_uri                 = "https://${local.mydomain_dot_com}/callback"
      explicit_auth_flows                  = ["CUSTOM_AUTH_FLOW_ONLY", "ADMIN_NO_SRP_AUTH"]
      generate_secret                      = false
      logout_urls                          = ["https://${local.mydomain_dot_com}/logout"]
      name                                 = "test3"
      read_attributes                      = ["email", "phone_number"]
      supported_identity_providers         = []
      write_attributes                     = ["email", "gender", "locale", ]
      refresh_token_validity               = 30
    }
  ]

  # user_group
  user_groups = [
    { name        = "mygroup1"
      description = "My group 1"
    },
    { name        = "mygroup2"
      description = "My group 2"
    },
  ]

  # resource_servers
  resource_servers = [
    {
      identifier = "https://${local.mydomain_dot_com}"
      name       = "${local.mydomain}"
      scope = [
        {
          scope_name        = "sample-scope-1"
          scope_description = "A sample Scope Description for ${local.mydomain_dot_com}"
        },
        {
          scope_name        = "sample-scope-2"
          scope_description = "Another sample Scope Description for ${local.mydomain_dot_com}"
        },
      ]
    },
    {
      identifier = "https://weather-read-app.com"
      name       = "weather-read"
      scope = [
        {
          scope_name        = "weather.read"
          scope_description = "Read weather forecasts"
        }
      ]
    }
  ]

  # identity_providers
  identity_providers = [
    {
      provider_name = "Google"
      provider_type = "Google"

      provider_details = {
        authorize_scopes              = "email"
	#export TF_VAR_google_oauth_client_id=XXXX
        client_id                     = var.google_oauth_client_id    # This should be retrieved from AWS Secret Manager, otherwise Terraform will force an in-place replacement becuase is treated as a sensitive value
	# export TF_VAR_google_oauth_client_secret=YYY
        client_secret                 = var.google_oauth_client_secret #"your client_secret" # # This should be retrieved from AWS Secret Manager, otherwise Terraform will force an in-place replacement becuase is treated as a sensitive value
        attributes_url_add_attributes = "true"
        authorize_url                 = "https://accounts.google.com/o/oauth2/v2/auth"
        oidc_issuer                   = "https://accounts.google.com"
        token_request_method          = "POST"
        token_url                     = "https://www.googleapis.com/oauth2/v4/token"
      }

      attribute_mapping = {
        email    = "email"
        username = "sub"
        gender   = "gender"
      }
    }
  ]

  # tags
  tags = {
    Owner       = "infra"
    Environment = "production"
    Terraform   = true
  }
}


 # KMS key for lambda custom sender config"
 resource "aws_kms_key" "lambda-custom-sender" {
   count = 0
   description = "KMS key for lambda custom sender config"
 }

output cognito{
  value = module.aws_cognito_user_pool_complete_example
}
