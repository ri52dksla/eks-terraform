# EKS Cluster IAM Policies

Attach IAM Policies for EKS Cluster to supplied IAM Role

This module attach two IAM Policies to supplied IAM Role

- AmazonEKSServicePolicy
- AmazonEKSClusterPolicy

## Reference

https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html

## Resources

- IAM Policy Attachment


## Usage

```hcl-terraform

## Create IAM Role for EKS Cluster
resource "aws_iam_role" "eks_cluster_role" {
  name               = "eks-cluster-role"
  description        = "EKS Cluster role"
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_role_assume_role_policy_document.json
  tags = {
               Name = "eks-cluster-role"
	}
}

## Generate Assume Role Policy Document
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
    "sts:AssumeRole"]
  }
}

module eks_cluster_iam_policies {
  source = "/path/to/module"
  iam_role_name = aws_iam_role.eks_cluster_role.name
}
```

## Inputs

## Outputs