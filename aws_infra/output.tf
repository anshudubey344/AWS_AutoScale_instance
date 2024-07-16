output "vpc_id" {
  value = aws_vpc.anshu_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.anshu_subnet[*].id
}

output "security_group_id" {
  value = aws_security_group.example_security_group.id
}

output "autoscaling_group_id" {
  value = aws_autoscaling_group.example.id
}

output "load_balancer_dns_name" {
  value = aws_lb.example.dns_name
}
output "instance_public_ips" {
  value = data.aws_instances.example.public_ips
}
