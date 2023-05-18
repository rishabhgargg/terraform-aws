output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = module.public_subnets.subnet_ids
}

output "private_subnets" {
  value = module.private_subnets.subnet_ids
}

output "db_subnets" {
  value = module.db_subnets.subnet_ids
}