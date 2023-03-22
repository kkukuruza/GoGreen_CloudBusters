module "IAM" {
  source = "../child/IAM/"

}

module "VPC" {
  source = "../child/VPC/"

  env_tag = "Test"

}

module "KMS" {
  source = "../child/KMS/"

  user_arn = module.IAM.sysadmin_users_arn

}

module "S3" {
  source = "../child/S3/"

  bucket_name = "gogreen_cloudbusters_2023"
  kms_key_id = module.KMS.kms_key_id

}

module "Cognito" {
  source = "../child/Cognito/"
  user_pool_name = "gogreen-pool"

}