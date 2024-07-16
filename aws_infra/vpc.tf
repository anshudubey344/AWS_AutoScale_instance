# Existing resources (VPC, subnets, security group, launch configuration, etc.)

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.anshu_vpc.id

  tags = {
    Name = "${var.my_env}_internet_gateway"
  }
}

# Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.anshu_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.my_env}_public_route_table"
  }
}

# Route Table Association
resource "aws_route_table_association" "public" {
  count      = length(var.subnet_cidrs)
  subnet_id  = element(aws_subnet.anshu_subnet[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

# Modify the Subnet to be Public
resource "aws_subnet" "anshu_subnet" {
  count = length(var.subnet_cidrs)

  vpc_id            = aws_vpc.anshu_vpc.id
  cidr_block        = element(var.subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.my_env}_subnet_${count.index + 1}"
  }
}

