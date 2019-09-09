# EKS Worker Node Launch Template

create EKS Worker Node Launch Template

This module is expected to use Amazon EKS-optimized AMI (https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html)

## Reference

- https://eksworkshop.com/spotworkers/workers/
- https://github.com/aws-samples/eks-workshop/blob/599bd784074b56c56d9cf43cb0fe60429613aa14/templates/amazon-eks-nodegroup

## Resources

- Launch Template

## Usage

```hcl-terraform

locals {
	eks_cluster_name = "example-cluster"
	eks_cluster_version = "1.14"
    default_region = "ap-northeast-1"
}

## get latest EKS-optimized AMI
## https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html
data "aws_ami" "eks_optimized_ami" {
  filter {
    name   = "name"
    values = [format("amazon-eks-node-%s-v*",local.eks_cluster_version)]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

variable "eks_worker_node_instance_profile_name" {
	type= string
}

## EKSのWorker Nodeとして必要なIAM Policyを付与されている必要がある
data "aws_iam_instance_profile" "eks_worker_node_instance_profile" {
  name = var.eks_worker_node_instance_profile_name
}

variable "eks_worker_node_scurity_group_id" {
	type = string
}

data "aws_security_group" "eks_worker_node_scurity_group" {
  id = var.eks_worker_node_scurity_group_id
}

module eks_worker_node_launch_template {
 
   source = "/path/to/module"
 
   name = format("%s-eks-worker-node", local.eks_cluster_name)
 
   description = format("Lauch Template for EKS(%s) Worker Node", local.eks_cluster_name)
 
   iam_instance_profile_arn = aws_iam_instance_profile.eks_worker_node_instance_profile.arn
 
   cluster_name = local.eks_cluster_name
 
   image_id = data.aws_ami.eks_optimized_ami.id
 
   instance_type = local.eks_worker_node_default_instance_type
 
   security_group_ids = [
     aws_security_group.eks_worker_node_security_group.id
   ]
   volume_name = data.aws_ami.eks_optimized_ami.root_device_name
   volume_type = lookup(tolist(data.aws_ami.eks_optimized_ami.block_device_mappings)[0], "ebs").volume_type
   volume_size = lookup(tolist(data.aws_ami.eks_optimized_ami.block_device_mappings)[0], "ebs").volume_size
 
   tags = local.default_tags
 
 }

```

## get latest ImageId, VolumeName, VolumeType, VolumeSize using awscli

```bash

export EKS_CLUSTER_VERSION=1.14

aws ec2 describe-images \
--filters \
Name=owner-id,Values=602401143452 \
Name=virtualization-type,Values=hvm \
Name=root-device-type,Values=ebs \
Name=is-public,Values=true \
Name=name,Values=amazon-eks-node-${EKS_CLUSTER_VERSION}-v\* \
--query 'max_by(Images[], &CreationDate).{Name: Name, ImageId: ImageId, VolumeName: RootDeviceName,VolumeType:BlockDeviceMappings[0].Ebs.VolumeType,  VolumeSize: BlockDeviceMappings[0].Ebs.VolumeSize}'
```