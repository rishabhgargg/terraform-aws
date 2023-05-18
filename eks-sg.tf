#Module to create security group for EKS
module "eks_security_group" {
  source = "./terraform-modules/security-group"
  vpc    = module.vpc.vpc_id
  ports = [
    { fromport = 80, toport = 65535, source = "0.0.0.0/0" },
    { fromport = 22, toport = 22, source = "0.0.0.0/0" },
    { fromport = 443, toport = 443, source = "0.0.0.0/0" }
  ]
  tags = var.common_tags
  name = "eks"
}