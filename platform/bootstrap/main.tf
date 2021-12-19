module "terraform-state-s3-backend" {
  source = "../module/terraform-state-backend-s3"
  
  s3_bucket = "terraform-state-nede-demo"
  locks_dynamodb_table = "terraform-locks-nede-demo"
}
