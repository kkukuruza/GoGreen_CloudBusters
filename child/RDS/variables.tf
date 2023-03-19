variable "db_subnet_id" {
  type = string
}

variable "storage_type" {
  type = string
  default = "gp2"
}

variable "instance_class" {
  type = string
  default = "db.t3.micro"
}

variable "security_group_db_id" {
  type = list(string)
  description = "A list of security group IDs to associate with the DB"
  default = []
}

variable "kem_key_arn" {
  type = string
  description = "The KMS arn to associate with the DB"
}

variable "subnet_ids" {
  type = list(string)
  default = []
}