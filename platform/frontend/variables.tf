variable "stage" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "app" {
  type    = string
  default = "frontend"
}

variable "region" {
  type        = string
  description = "Aws region"
}
