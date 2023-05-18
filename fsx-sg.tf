# #Module to create security group for EKS
# module "fsx_security_group" {
#   source = "./terraform-modules/security-group"
#   vpc    = module.vpc.vpc_id
#   ports = [
#     { fromport = 988, toport = 988, source = "0.0.0.0/0" },
#     { fromport = 988, toport = 988, source = "0.0.0.0/0" },
#     { fromport = 22, toport = 22, source = "0.0.0.0/0" }
#   ]
#   tags = var.common_tags
#   name = "fsx"
# }