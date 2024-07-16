variable "key_pair" {
  description = "Please mentioned your key pair "

  type = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type = string	
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type = string
 
}
variable "volume_size" {
  description = "Size of the root volume in GB"
  type = string
  
}

variable "my_env" {
    description = "The environment for the app"
    type = string
}


variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "A list of CIDR blocks for the subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "A list of availability zones to create subnets in"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}







variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group."
  default     = 1
}

variable "max_size" {
  description = "The maximum size of the Auto Scaling group."
  default     = 3
}

variable "min_size" {
  description = "The minimum size of the Auto Scaling group."
  default     = 1
}
