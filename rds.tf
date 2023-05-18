#Module to create RDS
module "rds" {
  source                = "./terraform-modules/rds"
  family                = var.family
  parameters            = var.parameters
  tags                  = var.common_tags
  subnets               = module.vpc.db_subnets
  vpc_security_group_id = module.rds_security_group.Security_Group_Id
  engine                = var.engine
  engine_version        = var.engine_version
  instance_class        = var.instance_class
  username              = var.username
  password              = var.password
  port                  = var.port
  db_name               = var.db_name
}