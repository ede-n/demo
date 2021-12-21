variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources"
}

variable "stage" {
  type        = string
  description = "Staging area of the product- dev, qa, uat or prod"
  validation {
    condition     = contains(["dev", "qa", "uat", "prod"], var.stage)
    error_message = "Stage must be one of \"dev\", \"qa\", \"uat\", or \"prod\"."
  }
}

variable "long_name" {
  type        = string
  description = "Long name descriptor of the component"
  validation {
    condition     = length(var.long_name) > 4
    error_message = "Must be atleast 4 characters long."
  }
}

variable "cidr_block" {
  type        = string
  description = "IPv4 CIDR to assign to the VPC"
}

variable "az_config" {
  type = list(object({
      az = string
      private_subnets = list(string)
      public_subnets = list(string)
    }))
}

variable "instance_tenancy" {
  type        = string
  description = "A tenancy option for instances launched into VPC"
  default     = "default"
  validation {
    condition     = contains(["default", "dedicated", "host"], var.instance_tenancy)
    error_message = "Instance tenancy must be one of \"default\", \"dedicated\", or \"host\"."
  }
}

variable "dns_hostnames_enabled" {
  type        = bool
  description = "A boolean flag to enable/disable DNS hostnames"
  default     = true
}

variable "dns_support_enabled" {
  type        = bool
  description = "A boolean flag to enable/disable DNS support"
  default     = true
}

variable "additional_tags" {
  type        = map(string)
  default     = {}
  description = "Example `{'OrgUnit': 'Engineering'}`"
}
