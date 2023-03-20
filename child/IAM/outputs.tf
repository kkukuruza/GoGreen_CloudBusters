output "monitor_users" {
value = aws_iam_user.monitor_users[*].name
description = "List of monitor users"
}

output "sysadmin_users" {
value = aws_iam_user.sysadmin_users[*].name
description = "List of sysadmin users"
}

output "dbadmin_users" {
value = aws_iam_user.dbadmin_users[*].name
description = "List of dbadmin users"
}

output "monitor_group" {
value = aws_iam_group.monitor_group.name
description = "Name of the monitor group"
}

output "sysadmin_group" {
value = aws_iam_group.sysadmin_group.name
description = "Name of the sysadmin group"
}

output "dbadmin_group" {
value = aws_iam_group.dbadmin_group.name
description = "Name of the dbadmin group"
}

output "monitor_group_membership" {
value = aws_iam_group_membership.monitor_group_users.group
description = "Monitor group membership"
}

output "sysadmin_group_membership" {
value = aws_iam_group_membership.sysadmin_group_users.group
description = "Sysadmin group membership"
}

output "dbadmin_group_membership" {
value = aws_iam_group_membership.dbadmin_group_users.group
description = "DBAdmin group membership"
}

output "ec2tos3iamrole" {
value = aws_iam_role.ec2tos3iamrole.arn
description = "ARN of the created IAM role"
}

output "role_policy_attachment" {
value = aws_iam_role_policy_attachment.role_policy_attachment.id
description = "Role policy attachment ID"
}

output "password_policy" {
value = aws_iam_account_password_policy.password_policy.id
description = "Password policy ID"
}

output "require_mfa_policy" {
value = aws_iam_policy.require_mfa_policy.arn
description = "ARN of the MFA policy"
}

output "sysadmin_mfa_policy_attachment" {
value = aws_iam_group_policy_attachment.sysadmin_mfa_policy_attachment.id
description = "Sysadmin group MFA policy attachment ID"
}

output "dbadmin_mfa_policy_attachment" {
value = aws_iam_group_policy_attachment.dbadmin_mfa_policy_attachment.id
description = "DBAdmin group MFA policy attachment ID"
}

