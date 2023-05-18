module "eks" {
  source              = "./terraform-modules/eks"
  cluster_name        = var.cluster_name
  role_arn            = module.iam-eks.iam_role
  subnet_ids          = module.vpc.private_subnets
  security_group_ids  = [module.eks_security_group.Security_Group_Id, module.nodegroup_security_group.Security_Group_Id]
  public_access_cidrs = var.public_access_cidrs
  tags                = var.common_tags
  map_roles           = var.map_roles
  map_users           = var.map_users
}