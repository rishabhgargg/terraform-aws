output "policy_json" {
  value = data.aws_iam_policy_document.eks-iam-policy.json
}