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
  security_group_ids = [module.VPC.security_group_ids[1]]
  iam_instance_profile = module.IAM.ec2tos3iamrole
  tag_name = "web"
}

module "ALB" {
  source = "../child/ALB/"
  alb_name = "web"
  tg_name = "web"
  subnets  = [module.VPC.private_subnet_1_id, module.VPC.private_subnet_2_id]
  vpc_id = module.VPC.VPC_id
  security_group_ids = [module.VPC.security_group_ids[0]]
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

module "EC2_Template_app" {
  source = "../child/EC2_Template/"
  template_name = "app"
  ami_id = "ami-02f3f602d23f1659d"
  security_group_ids = [module.VPC.security_group_ids[3]]
  iam_instance_profile = module.IAM.ec2tos3iamrole
  tag_name = "app"
}


module "ALB_app" {
  source = "../child/ALB/"
  alb_name = "app"
  tg_name = "app"
  subnets  = [module.VPC.private_subnet_5_id, module.VPC.private_subnet_6_id]
  vpc_id = module.VPC.VPC_id
  security_group_ids = [module.VPC.security_group_ids[2]]
  target_group_port = "80"
  scheme = true
  
}

module "ASG_app" {
  source = "../child/ASG/"
  asg_name = "app"
  asg_tag = "app"
  launch_template_id = module.EC2_Template_app.launch_template_id
  vpc_zone_identifier = [module.VPC.private_subnet_5_id, module.VPC.private_subnet_6_id]
  target_group_arns = [module.ALB_app.target_group_arns]
}

module "WAF" {
  source = "../child/WAF/"
  alb_arn = module.ALB.alb_arn

}

module "Cognito" {
  source = "../child/Cognito/"
  user_pool_name = "gogreen-pool"

}
