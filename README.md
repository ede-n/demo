# Demo

Demonstrates the creation of AWS networking and a deployment strategies.

## Setup

### Required tooling

1. terraform cli version `1.1.2` or higher
2. git cli
3. aws cli

### Required environment variables

Ensure that Aws profile is configured and validate by running 

```
 aws sts get-caller-identity --no-cli-pager
```

### Bootstrapping setup

Terraform state backend setup/configuration. 

```
git clone https://github.com/ede-n/demo.git
cd demo/platform/bootstrap
terraform init
terraform apply
rm terraform.tfstate*
```

As the state is not managed in a backend, to update this config in future, you would have to import and execute changes.

```
cd demo/platform/bootstrap
terraform init
terraform import module.terraform-state-s3-backend.aws_dynamodb_table.terraform_locks terraform-locks-nede-demo
terraform import module.terraform-state-s3-backend.aws_s3_bucket.terraform-state terraform-state-nede-demo

### Frontend application


