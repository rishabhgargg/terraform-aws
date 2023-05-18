#Module to create IAM role for EKS Nodegroup
module "iam-nodegroup" {
  source     = "./terraform-modules/iam-nodegroup"
  tags       = var.common_tags
  oidc_arn   = split("https://", module.eks.identity[0].oidc[0].issuer)
  account_id = data.aws_caller_identity.current.account_id
}