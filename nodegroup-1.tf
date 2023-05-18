module "nodegroup_1" {
  source                  = "./terraform-modules/node_group"
  desired_capacity        = var.desired_capacity
  min_size                = var.min_size
  max_size                = var.max_size
  name                    = "customer-engagement-1"
  launch_template_id      = module.launch_template.launch_template_id
  launch_template_version = module.launch_template.latest_version
  iam_instance_profile    = var.iam_instance_profile
  security_group          = module.nodegroup_security_group.Security_Group_Id
  subnet_ids              = module.vpc.private_subnets
  tags                    = var.common_tags
  cluster_name            = module.eks.cluster_name
  node_role_arn           = module.iam-nodegroup.iam_role
  instance_types          = var.instance_type
}