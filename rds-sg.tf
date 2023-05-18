#Module to create security group for RDS
module "rds_security_group" {
  source = "./terraform-modules/security-group"
  vpc    = module.vpc.vpc_id
  ports  = [{ fromport = 3306, toport = 3306, source = "0.0.0.0/0" }]
  tags   = var.common_tags
  name   = "rds"
}