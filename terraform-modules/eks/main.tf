resource "aws_eks_cluster" "eks-cluster" {
  name     = var.cluster_name
  role_arn = var.role_arn
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "${var.cluster_name}-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
    Environment = "${lookup(var.tags, "Environment")}"
  }

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    subnet_ids              = var.subnet_ids
    security_group_ids      = var.security_group_ids
    public_access_cidrs     = var.public_access_cidrs
  }
  timeouts {
    create = "30m"
    delete = "15m"
  }
}
