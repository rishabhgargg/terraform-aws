data "aws_iam_policy" "AmazonEKSClusterPolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

data "aws_iam_policy" "AmazonEKSServicePolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

data "aws_iam_policy" "AmazonEKSVPCResourceController" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

data "aws_iam_policy_document" "eks-iam-policy" {
  statement {
    sid = ""
    actions = [
      "ec2:DescribeInternetGateways",
      "ec2:DescribeAccountAttributes"
    ]
    resources = [
      "*",
    ]
  }
}


resource "aws_iam_policy" "eks-policy" {
  name        = "-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
  path        = "/"
  description = "Policy For EKS Cluster"
  policy      = data.aws_iam_policy_document.eks-iam-policy.json
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "iam-policy-eks-${lookup(var.tags, "Name")}"
    Environment = "${lookup(var.tags, "Environment")}"
  }
}

data "aws_iam_policy_document" "eks-inline-policy" {
  statement {
    sid = "EKSClusterAssumeRole"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::619297012711:user/terraform_rishabh"]
    }
  }
}

resource "aws_iam_role" "eks_role" {
  name        = "EKS-cluster-role-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
  description = "Role for EKS Cluster"
  managed_policy_arns = [aws_iam_policy.eks-policy.arn,
    data.aws_iam_policy.AmazonEKSClusterPolicy.arn,
    data.aws_iam_policy.AmazonEKSServicePolicy.arn,
    data.aws_iam_policy.AmazonEKSVPCResourceController.arn
  ]
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.eks-inline-policy.json
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "eks-iam-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
    Environment = "${lookup(var.tags, "Environment")}"
  }
}