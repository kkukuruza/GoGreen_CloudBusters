output "monitor_users" {
  value       = aws_iam_user.monitor_users[*].name
  description = "List of monitor users"
}

output "sysadmin_users" {
  value       = aws_iam_user.sysadmin_users[*].name
  description = "List of sysadmin users"
}

output "sysadmin_users_arn" {
  value = {
    for idx, user in aws_iam_user.sysadmin_users : idx => user.arn
  }
  description = "List of sysadmin users"
}

output "dbadmin_users" {
  value       = aws_iam_user.dbadmin_users[*].name
  description = "List of dbadmin users"
}

output "monitor_group" {
  value       = aws_iam_group.monitor_group.name
  description = "Name of the monitor group"
}

output "sysadmin_group" {
  value       = aws_iam_group.sysadmin_group.name
  description = "Name of the sysadmin group"
}

output "dbadmin_group" {
  value       = aws_iam_group.dbadmin_group.name
  description = "Name of the dbadmin group"
}

output "ec2tos3iamrole" {
  value       = aws_iam_role.ec2tos3iamrole.arn
  description = "ARN of the created IAM role"
}
