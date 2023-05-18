# resource "aws_autoscaling_group" "nodegroup_autoscaling" {
#   desired_capacity     = var.desired_capacity
#   max_size             = var.max_size
#   min_size             = var.min_size
#   name                 = var.name
#   vpc_zone_identifier  = var.subnet_ids
#   launch_template {
#     id      = var.launch_template_id
#     version = var.launch_template_version
#   }

#   dynamic "tag" {
#     for_each = var.tags

#     content {
#       key    =  tag.key
#       value   =  tag.value
#       propagate_at_launch =  true
#     }
#   }
# }



resource "aws_eks_node_group" "eks-nodegroup" {
  cluster_name    = var.cluster_name
  node_group_name = var.name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids
  instance_types  = [var.instance_types]
  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_size
    min_size     = var.min_size
  }

  lifecycle {
    create_before_destroy = false
    ignore_changes        = [scaling_config[0].desired_size]
  }

  update_config {
    max_unavailable = 2
  }
  #  launch_template {
  #  id = var.launch_template_id
  #  version = var.launch_template_version
  # }
  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
}