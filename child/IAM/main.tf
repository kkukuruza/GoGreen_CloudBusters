#Create Users

resource "aws_iam_user" "monitor_users" {
  count = length(var.monitor_users)
  name  = element(var.monitor_users, count.index)
}

resource "aws_iam_user" "sysadmin_users" {
  count = length(var.sysadmin_users)
  name  = element(var.sysadmin_users, count.index)
}

resource "aws_iam_user" "dbadmin_users" {
  count = length(var.dbadmin_users)
  name  = element(var.dbadmin_users, count.index)
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
  name  = "${var.monitor_group} membership"
  users = aws_iam_user.monitor_users.*.name
  group = aws_iam_group.monitor_group.name
}

resource "aws_iam_group_membership" "sysadmin_group_users" {
  name  = "${var.sysadmin_group} membership"
  users = aws_iam_user.sysadmin_users.*.name
  group = aws_iam_group.sysadmin_group.name
}

resource "aws_iam_group_membership" "dbadmin_group_users" {
  name  = "${var.dbadmin_group} membership"
  users = aws_iam_user.dbadmin_users.*.name
  group = aws_iam_group.dbadmin_group.name
}

#Attaching policies to groups

resource "aws_iam_group_policy_attachment" "monitor_policy_attachments" {
  for_each   = toset(var.policy_arns_monitor)
  group      = aws_iam_group.monitor_group.name
  policy_arn = each.value
}

resource "aws_iam_group_policy_attachment" "sysadmin_policy_attachments" {
  for_each   = toset(var.policy_arns_sysadmin)
  group      = aws_iam_group.sysadmin_group.name
  policy_arn = each.value
}

resource "aws_iam_group_policy_attachment" "dbadmin_policy_attachments" {
  for_each   = toset(var.policy_arns_dbadmin)
  group      = aws_iam_group.dbadmin_group.name
  policy_arn = each.value
}

#Create policy for Role

resource "aws_iam_policy" "role_policy" {
  name        = "read_and_write_s3"
  policy      = file("${path.module}/policy/role_policy.json")
  description = "Role policy for Read and Write on S3"
}

# Create a role
resource "aws_iam_role" "ec2tos3iamrole" {
  name = var.role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2tos3iamrole_policy" {
  policy_arn = aws_iam_policy.role_policy.arn
  role       = aws_iam_role.ec2tos3iamrole.name
}

# Setup password policy

resource "aws_iam_account_password_policy" "password_policy" {
  minimum_password_length        = var.minimum_password_length
  require_lowercase_characters   = var.require_lowercase_characters
  require_uppercase_characters   = var.require_uppercase_characters
  require_numbers                = var.require_numbers
  require_symbols                = var.require_symbols
  allow_users_to_change_password = var.allow_users_to_change_password
  max_password_age               = var.max_password_age
  password_reuse_prevention      = var.password_reuse_prevention
}

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

# Create access keys for each IAM user in the group
resource "aws_iam_access_key" "sysadmin_group_access_keys" {
  for_each = toset(aws_iam_user.sysadmin_users.*.name)
  user = each.key
}

resource "aws_iam_access_key" "dbadmin_group_access_keys" {
  for_each = toset(aws_iam_user.dbadmin_users.*.name)
  user = each.key
}
