# EKS Worker Node IAM Policies

Attach IAM Policies for EKS Worker Node to supplied IAM Role

This module attaches three IAM Policies to supplied IAM Role

- AmazonEKSWorkerNodePolicy
- AmazonEKS_CNI_Policy
- AmazonEC2ContainerRegistryReadOnly


## Reference

https://docs.aws.amazon.com/eks/latest/userguide/worker_node_IAM_role.html

## Resources

- IAM Policy Attachment

## Usage

```hcl-terraform
## Create EKS Worker Node IAM Role
resource "aws_iam_role" "eks_worker_node_role" {
  name               = "eks-worker-node"
  assume_role_policy = data.aws_iam_policy_document.eks_worker_node_role_assume_role_policy_document.json
  tags = {
    Name = "eks-worker-node"
  }
}

## Generate Assume Role Policy Document for EKS Worker Node
data "aws_iam_policy_document" "eks_worker_node_role_assume_role_policy_document" {

  statement {
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

module eks_worker_node_iam_policies {
  source = "/path/to/module"
  iam_role_name = aws_iam_role.eks_worker_node_role.name
}
```

## Inputs

## Outputs