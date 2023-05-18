# #Module to create fsx for EKS
# module "fsx" {
#   source                      = "./terraform-modules/fsx"
#   security_group_ids          = module.fsx_security_group.Security_Group_Id
#   subnet_ids                  = module.vpc.private_subnets[0]
#   storage_capacity            = var.storage_capacity
#   deployment_type             = var.deployment_type
#   per_unit_storage_throughput = var.per_unit_storage_throughput
#   tags                        = var.common_tags
# }