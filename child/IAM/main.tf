#Create Users

resource "aws_iam_user" "monitor_users" {
    count = length(var.monitor_users)
    name = element(var.monitor_users, count.index)
}

resource "aws_iam_user" "sysadmin_users" {
    count = length(var.sysadmin_users)
    name = element(var.sysadmin_users, count.index)
}

resource "aws_iam_user" "dbadmin_users" {
    count = length(var.dbadmin_users)
    name = element(var.dbadmin_users, count.index)
}

#Create Groups

resource "aws_iam_group" "monitor_group" {
  name = var.monitor_group
}

resource "aws_iam_group" "sysadmin_group" {
  name = var.sysadmin_group
}

resource "aws_iam_group" "dbadmin_group" {
  name = var.dbadmin_group
}

#Add users to groups 

resource "aws_iam_group_membership" "monitor_group_users" {
  name = "${var.monitor_group} membership"
  users = var.monitor_users
  group = var.monitor_group
}

resource "aws_iam_group_membership" "sysadmin_group_users" {
  name = "${var.sysadmin_group} membership"
  users = var.sysadmin_users
  group = var.sysadmin_group
}

resource "aws_iam_group_membership" "dbadmin_group_users" {
  name = "${var.dbadmin_group} membership"
  users = var.dbadmin_users
  group = var.dbadmin_group
}

#Attaching policies to groups

resource "aws_iam_group_policy_attachment" "monitor_policy_attachments" {
    for_each = toset(var.policy_arns_monitor)
  group      = var.monitor_group
  policy_arn = each.value
}

resource "aws_iam_group_policy_attachment" "sysadmin_policy_attachments" {
    for_each = toset(var.policy_arns_sysadmin)
  group      = var.sysadmin_group
  policy_arn = each.value
}

resource "aws_iam_group_policy_attachment" "dbadmin_policy_attachments" {
    for_each = toset(var.policy_arns_dbadmin)
  group      = var.dbadmin_group
  policy_arn = each.value
}

# Create a role
resource "aws_iam_role" "ec2tos3iamrole" {
 name = var.role 
 assume_role_policy = jsonencode({
    
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutAnalyticsConfiguration",
                "s3:PutAccessPointConfigurationForObjectLambda",
                "s3:GetObjectVersionTagging",
                "s3:PutStorageLensConfiguration",
                "s3:DeleteAccessPoint",
                "s3:CreateBucket",
                "s3:DeleteAccessPointForObjectLambda",
                "s3:GetStorageLensConfigurationTagging",
                "s3:ReplicateObject",
                "s3:GetObjectAcl",
                "s3:GetBucketObjectLockConfiguration",
                "s3:DeleteBucketWebsite",
                "s3:GetIntelligentTieringConfiguration",
                "s3:PutLifecycleConfiguration",
                "s3:GetObjectVersionAcl",
                "s3:DeleteObject",
                "s3:CreateMultiRegionAccessPoint",
                "s3:GetBucketPolicyStatus",
                "s3:GetObjectRetention",
                "s3:GetBucketWebsite",
                "s3:GetJobTagging",
                "s3:GetMultiRegionAccessPoint",
                "s3:PutReplicationConfiguration",
                "s3:GetObjectAttributes",
                "s3:PutObjectLegalHold",
                "s3:InitiateReplication",
                "s3:GetObjectLegalHold",
                "s3:GetBucketNotification",
                "s3:PutBucketCORS",
                "s3:DescribeMultiRegionAccessPointOperation",
                "s3:GetReplicationConfiguration",
                "s3:PutObject",
                "s3:GetObject",
                "s3:PutBucketNotification",
                "s3:DescribeJob",
                "s3:PutBucketLogging",
                "s3:GetAnalyticsConfiguration",
                "s3:PutBucketObjectLockConfiguration",
                "s3:GetObjectVersionForReplication",
                "s3:CreateJob",
                "s3:GetAccessPointForObjectLambda",
                "s3:GetStorageLensDashboard",
                "s3:CreateAccessPoint",
                "s3:GetLifecycleConfiguration",
                "s3:GetAccessPoint",
                "s3:GetInventoryConfiguration",
                "s3:GetBucketTagging",
                "s3:PutAccelerateConfiguration",
                "s3:SubmitMultiRegionAccessPointRoutes",
                "s3:GetAccessPointPolicyForObjectLambda",
                "s3:DeleteObjectVersion",
                "s3:GetBucketLogging",
                "s3:RestoreObject",
                "s3:GetAccelerateConfiguration",
                "s3:GetObjectVersionAttributes",
                "s3:GetBucketPolicy",
                "s3:PutEncryptionConfiguration",
                "s3:GetEncryptionConfiguration",
                "s3:GetObjectVersionTorrent",
                "s3:AbortMultipartUpload",
                "s3:GetBucketRequestPayment",
                "s3:GetAccessPointPolicyStatus",
                "s3:UpdateJobPriority",
                "s3:GetObjectTagging",
                "s3:GetMetricsConfiguration",
                "s3:GetBucketOwnershipControls",
                "s3:DeleteBucket",
                "s3:PutBucketVersioning",
                "s3:GetBucketPublicAccessBlock",
                "s3:GetMultiRegionAccessPointPolicyStatus",
                "s3:PutIntelligentTieringConfiguration",
                "s3:GetMultiRegionAccessPointPolicy",
                "s3:GetAccessPointPolicyStatusForObjectLambda",
                "s3:PutMetricsConfiguration",
                "s3:PutBucketOwnershipControls",
                "s3:DeleteMultiRegionAccessPoint",
                "s3:UpdateJobStatus",
                "s3:GetBucketVersioning",
                "s3:GetBucketAcl",
                "s3:GetAccessPointConfigurationForObjectLambda",
                "s3:PutInventoryConfiguration",
                "s3:GetObjectTorrent",
                "s3:GetMultiRegionAccessPointRoutes",
                "s3:GetStorageLensConfiguration",
                "s3:DeleteStorageLensConfiguration",
                "s3:GetAccountPublicAccessBlock",
                "s3:PutBucketWebsite",
                "s3:PutBucketRequestPayment",
                "s3:PutObjectRetention",
                "s3:CreateAccessPointForObjectLambda",
                "s3:GetBucketCORS",
                "s3:GetBucketLocation",
                "s3:GetAccessPointPolicy",
                "s3:ReplicateDelete",
                "s3:GetObjectVersion"
            ],
            "Resource": "*"
        }
    ]
    
 })
 }

/*# Create a policy for the role
resource "aws_iam_policy" "role_policy" {
 name = "example-policy"
 description = "An example policy for the role" 
 policy = jsonencode({
 Version = "2012-10-17"
 Statement = [
 {
 Action = [
 "s3:ListAllMyBuckets",
 ]
 Effect = "Allow"
 Resource = "*"
 }
 ]
 })
}*/

# Attach the policy to the role

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
 policy_arn = var.role_policy
 role = var.role
}

/*resource "aws_iam_group_policy_attachment" "dbadmin_policy_attachments" {
    for_each = toset(var.policy_arns_dbadmin)
  group      = var.dbadmin_group
  policy_arn = each.value
}*/

# Setup password policy

resource "aws_iam_account_password_policy" "password_policy" {
  minimum_password_length = var.minimum_password_length
  require_lowercase_characters = var.require_lowercase_characters
  require_uppercase_characters = var.require_uppercase_characters
  require_numbers = var.require_numbers
  require_symbols = var.require_symbols
  allow_users_to_change_password = var.allow_users_to_change_password
  max_password_age = var.max_password_age
  password_reuse_prevention = var.password_reuse_prevention
}
/*
#Create policy for monitor group 

resource "aws_iam_group_policy" "password_policy_monitor" {
  name = var.password_policy_monitor_group
  group = var.monitor_group

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:ChangePassword"
        ]
        Effect = "Allow"
        Resource = "*"
      }
    ]
  })
}

#Attach password policy to monitor group 

resource "aws_iam_group_policy_attachment" "password_policy_attachment_monitor" {
  group = var.monitor_group
  policy_arn = aws_iam_account_password_policy.password_policy.arn
}
*/
# Enable MFA for admin groups

# Create the IAM policy that requires MFA
resource "aws_iam_policy" "require_mfa_policy" {
  name        = var.require_mfa_policy
  description = "Require MFA for all IAM users in the groups"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "iam:*"
        Effect   = "Deny"
        Resource = "*"
        Condition = {
          BoolIfExists = {
            "aws:MultiFactorAuthPresent" = false
          }
        }
      }
    ]
  })
}

# Attach the policy to the groups
resource "aws_iam_group_policy_attachment" "sysadmin_mfa_policy_attachment" {
  policy_arn = aws_iam_policy.require_mfa_policy.arn
  group      = var.sysadmin_group
}

resource "aws_iam_group_policy_attachment" "dbadmin_mfa_policy_attachment" {
  policy_arn = aws_iam_policy.require_mfa_policy.arn
  group      = var.dbadmin_group
}

# Configure MFA settings for IAM users in the groups
resource "aws_iam_user_mfa_settings" "sysadmin_mfa_settings" {
  for_each = toset(var.sysadmin_group.users)

  user = each.key

  enabled = true
}

resource "aws_iam_user_mfa_settings" "dbadmin_mfa_settings" {
  for_each = toset(var.dbadmin_group.users)

  user = each.key

  enabled = true
}


/*resource "aws_iam_user_mfa_configuration" "admin_mfa" {
 user_name = aws_iam_user.username.name
 virtual_mfa_device {
 mfa_seed = "your-mfa-seed"
 }
}*/

# Create access keys for each IAM user in the group
resource "aws_iam_access_key" "sysadmin_group_access_keys" {
  for_each = toset(var.sysadmin_group.users)

  user = each.key
}

resource "aws_iam_access_key" "dbadmin_group_access_keys" {
  for_each = toset(var.dbadmin_group.users)

  user = each.key
}
