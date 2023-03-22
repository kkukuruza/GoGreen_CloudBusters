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

module "EC2_Template" {
  source = "../child/EC2_Template/"
  template_name = "web"
  ami_id = "ami-02f3f602d23f1659d"
  security_group_ids = [module.VPC.security_group_ids[2]]
  iam_instance_profile = module.IAM.ec2tos3iamrole
  tag_name = "web"
}

module "ALB" {
  source = "../child/ALB/"
  alb_name = "web"
  tg_name = "web"
  subnets  = [module.VPC.private_subnet_1_id, module.VPC.private_subnet_2_id]
  vpc_id = module.VPC.VPC_id
  security_group_ids = module.VPC.security_group_ids
  target_group_port = "80"
  
}

module "ASG" {
  source = "../child/ASG/"
  asg_name = "web"
  asg_tag = "web"
  launch_template_id = module.EC2_Template.launch_template_id
  vpc_zone_identifier = [module.VPC.private_subnet_1_id, module.VPC.private_subnet_2_id]
  target_group_arns = [module.ALB.target_group_arns]
}

module "Route53" {
  source = "../child/Route53/"
}

module "WAF" {
  source = "../child/WAF/"
  alb_arn = module.ALB.alb_arn

}

module "Cognito" {
  source = "../child/Cognito/"
  user_pool_name = "gogreen-pool"

}