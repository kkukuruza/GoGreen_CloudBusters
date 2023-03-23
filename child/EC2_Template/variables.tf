variable "template_name" {
  type = string
}

variable "ami_id" {
  type = string
  default = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "security_group_ids" {
  type = list(string)
  description = "A list of security group IDs to associate with the instances"
}

variable "iam_instance_profile" {
  type = string
  description = "The IAM instance profile to associate with the instances"
}

variable "user_data" {
  type = string
  default = ""
  description = "User data to provide when launching the instances"
}

variable "tag_name" {
  type = string
  default = ""
  description = "Tag name to provide when launching the instances"
}