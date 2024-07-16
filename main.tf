module "Development" {
    source = "./aws_infra"
    my_env = "dev"
    key_pair = "xyz"
    volume_size = "8"	
    instance_type = "t2.micro"
    ami = "ami-007855ac798b5175e"
    vpc_cidr           = "10.0.0.0/16"
    subnet_cidrs       = ["10.0.1.0/24", "10.0.2.0/24"]
    availability_zones = ["us-east-1a", "us-east-1b"]
    desired_capacity   = "1"
    max_size           = "3"
    min_size           = "1"
}


module "Testing" {
    source = "./aws_infra"
    my_env = "test"
    key_pair = "xyz"
    volume_size = "8"
    instance_type = "t2.small"
    ami = "ami-007855ac798b5175e"
    vpc_cidr           = "10.0.0.0/16"
    subnet_cidrs       = ["10.0.1.0/24", "10.0.2.0/24"]
    availability_zones = ["us-east-1a", "us-east-1b"]
    desired_capacity   = "1"
    max_size           = "3"
    min_size           = "1"
   
}


module "UAT" {
    source = "./aws_infra"
    my_env = "uat"
    key_pair = "xyz"
    volume_size = "8"
    instance_type = "t2.small"
    ami = "ami-007855ac798b5175e"
    vpc_cidr           = "10.0.0.0/16"
    subnet_cidrs       = ["10.0.1.0/24", "10.0.2.0/24"]
    availability_zones = ["us-east-1c", "us-east-1d"]
    desired_capacity   = "1"
    max_size           = "3"
    min_size           = "1"
}


module "Prod" {
    source = "./aws_infra"
    my_env = "prod"
    key_pair = "xyz"
    volume_size = "8"
    instance_type = "t2.medium"
    ami = "ami-007855ac798b5175e"
    vpc_cidr           = "10.0.0.0/16"
    subnet_cidrs       = ["10.0.1.0/24", "10.0.2.0/24"]
    availability_zones = ["us-east-1a", "us-east-1b"]
    desired_capacity   = "1"
    max_size           = "3"
    min_size           = "1"
}
