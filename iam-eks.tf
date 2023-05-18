#Module to create IAM role for EKS
module "iam-eks" {
  source = "./terraform-modules/iam-eks"
  tags   = var.common_tags
}