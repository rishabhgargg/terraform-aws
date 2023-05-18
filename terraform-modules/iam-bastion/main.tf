data "aws_iam_policy_document" "eks-iam-policy" {
  statement {
    sid = "ElectricClusterAutoscaleALL"
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "ec2:DescribeLaunchTemplateVersions"
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = "ElectricClusterAutoscaleOwn"
    actions = [
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "autoscaling:UpdateAutoScalingGroup"
    ]

    resources = [
      "*",
    ]

    condition {
      test     = "StringEquals"
      variable = "autoscaling:ResourceTag/k8s.io/cluster-autoscaler/enabled"
      values   = ["true"]
    }

    condition {
      test     = "StringEquals"
      variable = "autoscaling:ResourceTag/kubernetes.io/cluster/${var.cluster_name}"
      values   = ["owned"]
    }
  }
}

resource "aws_iam_policy" "eks-policy" {
  name        = "AutoScaler-Policy-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
  path        = "/"
  description = "Policy to Allow Autoscaler to act on your behalf"
  policy      = data.aws_iam_policy_document.eks-iam-policy.json
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "iam-policy-${lookup(var.tags, "Name")}"
    Environment = "${lookup(var.tags, "Environment")}"
  }
}

data "aws_iam_policy_document" "eks-inline-policy" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]
    principals {
      type        = "Federated"
      identifiers = ["www.amazon.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "www.amazon.com:app_id"
      values   = [var.cluster_openID_connect]
    }
  }
}


resource "aws_iam_role" "eks_role" {
  name                = "cluster-autoscaler-role-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
  description         = "Allows Autoscaler to act on your behalf"
  managed_policy_arns = [aws_iam_policy.eks-policy.arn]
  path                = "/"
  assume_role_policy  = data.aws_iam_policy_document.eks-inline-policy.json
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "iam-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
    Environment = "${lookup(var.tags, "Environment")}"
  }
}