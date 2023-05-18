output "policy_json" {
  value = data.aws_iam_policy_document.eks-iam-policy.json
}

output "iam_role" {
  value = aws_iam_role.eks_role.arn
}