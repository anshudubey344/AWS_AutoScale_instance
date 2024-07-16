################################VPC#######################################


resource "aws_vpc" "anshu_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.my_env}_VPC"
  }
}

##################Security_Group#######################

resource "aws_security_group" "example_security_group" {
  name        = "${var.my_env}-SG"
  description = "This is the security group for EC2 instance"
  vpc_id      = aws_vpc.anshu_vpc.id  # Replace with your VPC ID

  // Define ingress rules (inbound traffic)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere
  }

  // Define egress rules (outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }
}










resource "aws_launch_configuration" "example" {
  name          = "${var.my_env}-launch-configuration"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_pair
  security_groups = [aws_security_group.example_security_group.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.id
  vpc_zone_identifier  = aws_subnet.anshu_subnet[*].id
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size

  tag {
    key                 = "Name"
    value               = "${var.my_env}-autoscaling-group"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }

  health_check_type         = "ELB"
  health_check_grace_period = 300

  target_group_arns = [aws_lb_target_group.example.arn]
}

resource "aws_lb" "example" {
  name               = "${var.my_env}-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.example_security_group.id]
  subnets            = aws_subnet.anshu_subnet[*].id

  enable_deletion_protection = false
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}

resource "aws_lb_target_group" "example" {
  name     = "${var.my_env}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.anshu_vpc.id
}


# Data source to fetch the ASG instances
data "aws_autoscaling_group" "example" {
  name = aws_autoscaling_group.example.name
}

data "aws_instances" "example" {
  instance_tags = {
    Name = "${var.my_env}-autoscaling-group"
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }

  depends_on = [aws_autoscaling_group.example]
}









/*
resource "aws_instance" "anshu_instance" {

	ami = var.ami
	instance_type = var.instance_type
	security_groups = [aws_security_group.example_security_group.name]
	key_name = var.key_pair

	tags = {
        Name = "${var.my_env}-server"
    }
	

	ebs_block_device {
    		device_name = "/dev/sdf"  // Device name (e.g., /dev/sdf)
   		volume_size = var.volume_size  // Size of the volume in GB
    		volume_type = "gp2"  // Volume type
    		encrypted   = true  // Whether the volume should be encrypted
  		}
}

*/
