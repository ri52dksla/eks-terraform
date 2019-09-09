
## Create IAM Role for EKS Cluster
resource "aws_iam_role" "eks_cluster_role" {
  name               = format("%s-eks-cluster", var.eks_cluster_name)
  description        = format("IAM Role for EKS Cluster (%s)", var.eks_cluster_name)
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_role_assume_role_policy_document.json
  tags = {
    Name = format("%s-cluster", var.eks_cluster_name)
  }
}

## Generate Assume Role Policy Document for EKS Cluster
data "aws_iam_policy_document" "eks_cluster_role_assume_role_policy_document" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = [
        "eks.amazonaws.com"
      ]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

module "eks_cluster_iam_policies" {
  source        = "../../modules/eks/eks_cluster_iam_policies"
  iam_role_name = aws_iam_role.eks_cluster_role.name
}



## Create EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {

  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.eks_cluster_version

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true

    security_group_ids = [
      aws_security_group.eks_control_plane_security_group.id
    ]
    subnet_ids = flatten([
      local.private_subnet_ids
    ])
  }

  ## Enable Control Plane Logs
  ## https://docs.aws.amazon.com/eks/latest/userguide/control_plane_logs.html
  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  depends_on = [
    aws_cloudwatch_log_group.eks_cluster_control_plane_log_group
  ]
}

## https://www.terraform.io/docs/providers/aws/d/eks_cluster_auth.html
data "aws_eks_cluster_auth" "eks_cluster_auth" {
  name = aws_eks_cluster.eks_cluster.id
}

locals {
  eks_cluster_id                         = aws_eks_cluster.eks_cluster.id
  eks_cluster_endpoint                   = aws_eks_cluster.eks_cluster.endpoint
  eks_cluster_certificate_authority_data = aws_eks_cluster.eks_cluster.certificate_authority[0].data
  eks_cluster_authentication_token       = data.aws_eks_cluster_auth.eks_cluster_auth.token
}
