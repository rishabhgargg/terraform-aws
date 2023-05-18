output "cluster_endpoint" {
  value = aws_eks_cluster.eks-cluster.endpoint
}

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.eks-cluster.certificate_authority
}

output "cluster_name" {
  value = aws_eks_cluster.eks-cluster.name
}

output "identity" {
  value = aws_eks_cluster.eks-cluster.identity
}

output "certificate_authority" {
  value = aws_eks_cluster.eks-cluster.certificate_authority
}
