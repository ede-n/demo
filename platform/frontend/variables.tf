variable "stage" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "az_config" {
  type = list(object({
      az = string
      private_subnets = list(string)
      public_subnets = list(string)
    }))
}

variable "app" {
  type    = string
  default = "frontend"
}

variable "region" {
  type        = string
  description = "Aws region"
}
