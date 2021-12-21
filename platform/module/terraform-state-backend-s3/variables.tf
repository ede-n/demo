variable "s3_bucket" {
  type        = string
  description = "Name of the s3 bucket where terraform state files are stored"
}

variable "locks_dynamodb_table" {
  type        = string
  description = "Name of the dynamo db table where Terraform state locks are maintained"
}
