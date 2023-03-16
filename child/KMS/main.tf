resource "aws_kms_key" "admin_key" {
  description = var.kms_key_description
  key_usage   = "ENCRYPT_DECRYPT"
  is_enabled  = true
}

resource "aws_kms_alias" "user_key_alias" {
  name          = var.kms_key_alias
  target_key_id = aws_kms_key.admin_key.key_id
}

resource "aws_kms_grant" "user_grant" {
  name              = "kms-grant-user"
  key_id            = aws_kms_key.admin_key.key_id
  grantee_principal = var.user_arn
  operations        = ["Encrypt", "Decrypt", "GenerateDataKey", "ReEncryptFrom", "ReEncryptTo", "DescribeKey", "CreateGrant", "ListGrants", "RetireGrant", "ScheduleKeyDeletion", "CancelKeyDeletion"]
}
