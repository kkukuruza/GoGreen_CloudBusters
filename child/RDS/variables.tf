variable "db_subnet_id" {
  type = list(string)
  default = [ ]
}

variable "storage_type" {
  type    = string
  default = "gp2"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "security_group_db_id" {
  type        = list(string)
  description = "A list of security group IDs to associate with the DB"
  default     = []
}

variable "kms_key_arn" {
  type        = string
  description = "The KMS arn to associate with the DB"
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "identifier" {
  type    = string
  default = "gogreendb"
}

variable "allocated_storage" {
  type    = string
  default = "6144"
}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type    = string
  default = "5.7.41"
}

variable "db_name" {
  type    = string
  default = "gogreen"
}

variable "username" {
  type    = string
  default = "admin"
}

variable "password" {
  type    = string
  default = "gogreen2023"
}

variable "multi_az" {
  type    = bool
  default = "true"
}

variable "publicly_accessible" {
  type    = bool
  default = "false"
}

variable "backup_retention_period" {
  type   = string
  default = "0"
}

variable "skip_final_snapshot" {
  type    = string
  default = "true"
}

variable "lambda_function_payload_path" {
  type        = string
  description = "Path to the Lambda function payload zip file"
}