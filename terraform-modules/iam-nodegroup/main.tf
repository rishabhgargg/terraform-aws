data "aws_iam_policy" "SecretsManagerReadWrite" {
  arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

data "aws_iam_policy" "AmazonSQSFullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}

data "aws_iam_policy" "AmazonEKSWorkerNodePolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

data "aws_iam_policy" "AmazonS3FullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

data "aws_iam_policy" "AmazonEC2ContainerRegistryReadOnly" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

data "aws_iam_policy" "CloudWatchAgentServerPolicy" {
  arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy" "AmazonEKS_CNI_Policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}


data "aws_iam_policy_document" "eks-autoscaling-iam-policy" {
  statement {
    actions = [
      "autoscaling:*",
    ]
    resources = [
      "*",
    ]
  }
  statement {
    actions = [
      "ec2:*",
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = ""
    actions = [
      "cloudwatch:*",
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = ""
    actions = [
      "elasticloadbalancing:*",
    ]
    resources = [
      "*",
    ]
  }
}


resource "aws_iam_policy" "nodegroup-autoscaling-policy" {
  name        = "nodegroup-eks-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
  path        = "/"
  description = "Policy For EKS autoscaling for node groups"
  policy      = data.aws_iam_policy_document.eks-autoscaling-iam-policy.json
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "nodegroup-eks-${lookup(var.tags, "Name")}"
    Environment = "${lookup(var.tags, "Environment")}"
  }
}

data "aws_iam_policy_document" "elb-autoscaling-iam-policy" {
  statement {
    actions = [
      "acm:DescribeCertificate",
      "acm:ListCertificates",
      "acm:GetCertificate"
    ]
    resources = [
      "*",
    ]
  }
  statement {
    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CreateSecurityGroup",
      "ec2:CreateTags",
      "ec2:DeleteTags",
      "ec2:DeleteSecurityGroup",
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeVpcs",
      "ec2:ModifyInstanceAttribute",
      "ec2:ModifyNetworkInterfaceAttribute",
      "ec2:RevokeSecurityGroupIngress"
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = ""
    actions = [
      "elasticloadbalancing:AddListenerCertificates",
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateRule",
      "elasticloadbalancing:CreateTargetGroup",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:DeleteRule",
      "elasticloadbalancing:DeleteTargetGroup",
      "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:DescribeListenerCertificates",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:DescribeSSLPolicies",
      "elasticloadbalancing:DescribeTags",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:ModifyRule",
      "elasticloadbalancing:ModifyTargetGroup",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:RemoveListenerCertificates",
      "elasticloadbalancing:RemoveTags",
      "elasticloadbalancing:SetIpAddressType",
      "elasticloadbalancing:SetSecurityGroups",
      "elasticloadbalancing:SetSubnets",
      "elasticloadbalancing:SetWebACL"
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = ""
    actions = [
      "iam:CreateServiceLinkedRole",
      "iam:GetServerCertificate",
      "iam:ListServerCertificates"
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = ""
    actions = [
      "cognito-idp:DescribeUserPoolClient"
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = ""
    actions = [
      "shield:DescribeProtection",
      "shield:GetSubscriptionState",
      "shield:DeleteProtection",
      "shield:CreateProtection",
      "shield:DescribeSubscription",
      "shield:ListProtections"
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = ""
    actions = [
      "waf-regional:GetWebACLForResource",
      "waf-regional:GetWebACL",
      "waf-regional:AssociateWebACL",
      "waf-regional:DisassociateWebACL"
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = ""
    actions = [
      "tag:GetResources",
      "tag:TagResources"
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = ""
    actions = [
      "waf:GetWebACL"
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = ""
    actions = [
      "wafv2:GetWebACL",
      "wafv2:GetWebACLForResource",
      "wafv2:AssociateWebACL",
      "wafv2:DisassociateWebACL"
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "nodegroup-elb-autoscaling-policy" {
  name        = "nodegroup-elb-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
  path        = "/"
  description = "ELB Management for EKS nodes"
  policy      = data.aws_iam_policy_document.elb-autoscaling-iam-policy.json
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "nodegroup-elb-${lookup(var.tags, "Name")}"
    Environment = "${lookup(var.tags, "Environment")}"
  }
}

data "aws_iam_policy_document" "eks-inline-policy" {
  statement {
    sid = "EKSWorkerAssumeRole"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]
    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${var.account_id}:oidc-provider/${var.oidc_arn[1]}"]
    }
    condition {
      test     = "StringEquals"
      variable = "${var.oidc_arn[1]}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_role" {
  name        = "NODEGROUP-EKS-role-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
  description = "Role for Nodegroup of EKS Cluster"
  managed_policy_arns = [
    aws_iam_policy.nodegroup-autoscaling-policy.arn,
    aws_iam_policy.nodegroup-elb-autoscaling-policy.arn,
    data.aws_iam_policy.SecretsManagerReadWrite.arn,
    data.aws_iam_policy.AmazonSQSFullAccess.arn,
    data.aws_iam_policy.AmazonEKSWorkerNodePolicy.arn,
    data.aws_iam_policy.AmazonS3FullAccess.arn,
    data.aws_iam_policy.AmazonEC2ContainerRegistryReadOnly.arn,
    data.aws_iam_policy.CloudWatchAgentServerPolicy.arn,
    data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn,
    data.aws_iam_policy.AmazonEKS_CNI_Policy.arn,

  ]
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.eks-inline-policy.json
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "nodegroup-iam-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
    Environment = "${lookup(var.tags, "Environment")}"
  }
}