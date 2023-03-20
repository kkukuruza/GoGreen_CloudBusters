variable "vpc_tag" {
  type    = string
  default = "GoGreen"
}

variable "env_tag" {
  type    = string
  default = ""
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}


variable "public_subnet_1" {
  type    = string
  default = "10.10.1.0/24"
}

variable "public_subnet_2" {
  type    = string
  default = "10.10.2.0/24"
}

variable "private_subnet_1" {
  type    = string
  default = "10.10.3.0/24"
}

variable "private_subnet_2" {
  type    = string
  default = "10.10.4.0/24"
}

variable "private_subnet_3" {
  type    = string
  default = "10.10.5.0/24"
}

variable "private_subnet_4" {
  type    = string
  default = "10.10.6.0/24"
}

variable "private_subnet_5" {
  type    = string
  default = "10.10.7.0/24"
}

variable "private_subnet_6" {
  type    = string
  default = "10.10.8.0/24"
}