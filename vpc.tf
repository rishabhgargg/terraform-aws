#Module to create a new vpc and associated resources
module "vpc" {
  source             = "./terraform-modules/vpc"
  cidr_block         = var.cidr_block
  tags               = var.common_tags
  dhcp_domain_name   = var.dhcp_domain_name
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  db_subnets         = var.db_subnets
  azs                = var.azs
  vpc_cidr_block     = var.vpc_cidr_block
  #transit_gateway_id = var.transit_gateway_id
}