module "IAM" {
  source = "../child/IAM/"

}

module "VPC" {
  source = "../child/VPC/"

  env_tag = "Test"

}
