variable "monitor_users" {
  type    = list(any)
  default = ["monitoruser1", "monitoruser2", "monitoruser3", "monitoruser4"]
}

variable "sysadmin_users" {
  type    = list(any)
  default = ["sysadmin1", "sysadmin2"]
}

variable "dbadmin_users" {
  type    = list(any)
  default = ["dbadmin1", "dbadmin2"]
}

variable "monitor_group" {
  type    = string
  default = "Monitor"
}

variable "sysadmin_group" {
  type    = string
  default = "SysAdmin"
}

variable "dbadmin_group" {
  type    = string
  default = "DBAdmin"
}

variable "policy_arns_monitor" {
  description = "List of ARNs for the monitor group"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  ]
}

variable "policy_arns_dbadmin" {
  description = "List of ARNs for the dbadmin group"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
  ]
}

variable "policy_arns_sysadmin" {
  description = "List of ARNs for the sysadmin group"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
}
variable "role" {
  type    = string
  default = "EC2toS3IAMRole"
}

variable "minimum_password_length" {
  type        = number
  description = "The minimum length required for passwords"
  default     = 8
}

variable "require_lowercase_characters" {
  type        = bool
  description = "Whether to require lowercase characters in passwords"
  default     = true
}

variable "require_uppercase_characters" {
  type        = bool
  description = "Whether to require uppercase characters in passwords"
  default     = true
}

variable "require_numbers" {
  type        = bool
  description = "Whether to require numbers in passwords"
  default     = true
}

variable "require_symbols" {
  type        = bool
  description = "Whether to require symbols in passwords"
  default     = true
}

variable "allow_users_to_change_password" {
  type        = bool
  description = "Whether to allow users to change their own passwords"
  default     = true
}

variable "max_password_age" {
  type        = number
  description = "The maximum age for passwords, in days"
  default     = 90
}

variable "password_reuse_prevention" {
  type        = number
  description = "The number of previous passwords that cannot be reused"
  default     = 3
}

#MFA policy for admin groups

variable "require_mfa_policy" {
  type    = string
  default = "mfa-policy"
}

