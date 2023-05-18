output "subnet_ids" {
  value = aws_subnet.aws-subnets.*.id
}