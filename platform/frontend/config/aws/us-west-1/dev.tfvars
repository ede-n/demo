stage = "dev"
az_config = [
    {
        "az": "us-west-1a"
        "private_subnets": ["10.1.0.0/19"]
        "public_subnets": ["10.1.32.0/19"]
    },
    {
        "az": "us-west-1c"
        "private_subnets": ["10.1.64.0/19"]
        "public_subnets": ["10.1.96.0/19"]
    }
]
vpc_cidr = "10.1.0.0/16"
region = "us-west-1"
