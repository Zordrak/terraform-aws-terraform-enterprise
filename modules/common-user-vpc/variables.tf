### =================================================================== REQUIRED

variable "vpc_id" {
  type        = "string"
  description = "AWS VPC id to install into"
  default = ""
}

variable "prefix" {
  type        = "string"
  description = "Prefix for resource names"
}

variable "project_name" {
  description = "name to attach to external services components"
}

### =================================================================== OPTIONAL

variable "subnet_tags" {
  type        = "map"
  description = "tags to use to match subnets to use"
  default     = {}
}

variable "allow_list" {
  type        = "list"
  description = "list of CIDRs we allow to access the infrastructure"
  default     = []
}

### ======================================================================= MISC

resource "random_string" "install_id" {
  length  = 8
  special = false
  upper   = false
}
