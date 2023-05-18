

# #Module to create IAM role for bastion
# module "iam" {
#     source = "./terraform-modules/iam-bastion"
#     tags = var.common_tags
#     cluster_name =  "customer-engagement-dev"
#     cluster_openID_connect ="https://oidc.eks.us-east-1.amazonaws.com/id/51DFEC1C3784C99E115F3ADEB2E2E156"
# }

#Module to create keypair for bastion
# module "keypair" {
#   source = "./terraform-modules/keypair"
#   name = var.key_pair_name
#   public_key = var.public_key
#   tags = var.common_tags
# }




#Module to create Bastion
# module "bastion" {
#   source = "./terraform-modules/bastion"
#   vpc_security_group_id = module.bastion_security_group.Security_Group_Id
#   instance_count = var.instance_count
#   associate_public_ip_address = var.associate_public_ip_address
#   iam_instance_profile = var.iam_instance_profile
#   fs_dns_name = ""
#   subnet_id = module.vpc.public_subnets[0]
#   instance_type = var.instance_type
#   key_name = module.keypair.key-pair-name
#   tags = var.common_tags
# }


























# module "nodegroup_2" {
#   source = "./terraform-modules/node_group"
#    desired_capacity = var.desired_capacity
#    min_size = var.min_size
#    max_size = var.max_size
#    name = "customer-engagement-2"
#    launch_template_id = module.launch_template.launch_template_id
#    launch_template_version = module.launch_template.latest_version
#    iam_instance_profile = var.iam_instance_profile
#    security_group = module.nodegroup_security_group.Security_Group_Id
#    subnet_ids = module.vpc.private_subnets
#    tags = var.common_tags
#    cluster_name = module.eks.cluster_name
#    node_role_arn = module.iam-nodegroup.iam_role
#    instance_types = var.instance_type
# }

#terraform {
#  backend "s3" {
#    region         = "ap-south-1"
#    bucket         = "tf-state-customer-engagement"
#    key            = "dev/tfstate/terraform.tfstate"
#    dynamodb_table = "customer-engagement-tf-state-lock"
#    encrypt        = true
#  }
#}