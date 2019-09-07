# EKS Security Group Rules

Attach Security Group Rules to the Security Groups of EKS Control Plane and Worker Node

This module follows recommended settings in [document](https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html)

## Resources

- AWS Security Group Rule

## Usage

```hcl-terraform

variable "vpc_id" {}

data "aws_vpc" "vpc" {
  id = "${var.vpc_id}"
}

## Create Security Group for EKS Worker Node
resource "aws_security_group" "eks_worker_node_security_group" {
  name        = "eks-worker-node"
  vpc_id      = data.aws_vpc.vpc.id
  description = "EKS Worker Node Security Group"
}

## Create Security Group for EKS Control Plane
resource "aws_security_group" "eks_control_plane_security_group" {
  name        = "eks-control-plane"
  vpc_id      = data.aws_vpc.vpc.id
  description = "EKS Control Plane Security Group"
}

## Use this module
module eks_security_groups_rules {
  source                              = "/path/to/module"
  eks_control_plane_security_group_id = aws_security_group.eks_control_plane_security_group.id
  eks_worker_node_security_group_id   = aws_security_group.eks_worker_node_security_group.id

}
```

## Inputs

## Outputs