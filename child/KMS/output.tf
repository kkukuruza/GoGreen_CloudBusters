output "kms_key_id" {
  description = "The ID of the created KMS key."
  value       = aws_kms_key.admin_key.key_id
}

output "kms_key_arn" {
  description = "The ARN of the created KMS key."
  value       = aws_kms_key.admin_key.arn
}
