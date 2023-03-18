variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}


variable "public_subnet" {
  type    = string
  default = "10.10.1.0/24"
}

variable "public_subnet2" {
  type    = string
  default = "10.10.2.0/24"
}

variable "private_subnet" {
  type    = string
  default = "10.10.3.0/24"
}

variable "private_subnet2" {
  type    = string
  default = "10.10.4.0/24"
}

variable "private_subnet3" {
  type    = string
  default = "10.10.5.0/24"
}

variable "private_subnet4" {
  type    = string
  default = "10.10.6.0/24"
}

variable "private_subnet5" {
  type    = string
  default = "10.10.7.0/24"
}

variable "private_subnet6" {
  type    = string
  default = "10.10.8.0/24"
}

variable "sg_ports" {
  type    = list(any)
  default = []
}
