#Module to create security group for EKS Node Groups
module "nodegroup_security_group" {
  source = "./terraform-modules/security-group"
  vpc    = module.vpc.vpc_id
  ports = [
    { fromport = 0, toport = 65535, source = "0.0.0.0/0" },
  ]
  tags = var.common_tags
  name = "nodegroup"
}