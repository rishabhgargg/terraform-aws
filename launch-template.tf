#Module to create launch template for EKS
module "launch_template" {
  source         = "./terraform-modules/launch-template"
  instance_type  = var.launch_template_instance_type
  security_group = module.eks_security_group.Security_Group_Id
  key_name       = var.key_pair
  volume_size    = var.volume_size
  tags           = var.common_tags
}