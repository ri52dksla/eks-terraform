## Create EKS Worker Node IAM Role
resource "aws_iam_role" "eks_worker_node_role" {
  name               = format("%s-eks-worker-node", var.eks_cluster_name)
  assume_role_policy = data.aws_iam_policy_document.eks_worker_node_role_assume_role_policy_document.json
  tags = {
    Name = format("%s-eks-worker-node", var.eks_cluster_name)
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
  source        = "../../modules/eks/eks_worker_node_iam_policies"
  iam_role_name = aws_iam_role.eks_worker_node_role.name
}

## EKS Worker Node用のInstance Profileを作成
resource "aws_iam_instance_profile" "eks_worker_node_instance_profile" {
  name = format("%s-eks-worker-node", var.eks_cluster_name)
  role = aws_iam_role.eks_worker_node_role.name
}

## get latest EKS-optimized AMI
## https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html
data "aws_ami" "eks_optimized_ami" {
  filter {
    name = "name"
    values = [
    format("amazon-eks-node-%s-v*", var.eks_cluster_version)]
  }

  most_recent = true
  owners = [
  "602401143452"]
  # Amazon EKS AMI Account ID
}


## Create EKS Worker Node Launch Template
module eks_worker_node_launch_template {

  source = "../../modules/eks/eks_worker_node_launch_template"

  name = format("%s-eks-worker-node", var.eks_cluster_name)

  description = format("Lauch Template for EKS(%s) Worker Node", var.eks_cluster_name)

  iam_instance_profile_arn = aws_iam_instance_profile.eks_worker_node_instance_profile.arn

  cluster_name = var.eks_cluster_name

  image_id = data.aws_ami.eks_optimized_ami.id

  instance_type = var.instance_type

  security_group_ids = [
    aws_security_group.eks_worker_node_security_group.id
  ]

  volume_name = data.aws_ami.eks_optimized_ami.root_device_name
  volume_type = tolist(data.aws_ami.eks_optimized_ami.block_device_mappings)[0].ebs.volume_type
  volume_size = tolist(data.aws_ami.eks_optimized_ami.block_device_mappings)[0].ebs.volume_size

  tags = var.default_tags

}

//module eks_worker_node_mixed_instance_types_autoscaling_group {
//
//  source = "../modules/eks/eks_worker_node_mixed_instance_types_autoscaling_group"
//
//  name = format("%s-eks-worker-node-mixed-instance-types", local.eks_cluster_name)
//
//  max_size         = 4
//  desired_capacity = 4
//  min_size         = 4
//
//  launch_template_id      = module.eks_worker_node_launch_template.id
//  launch_template_version = module.eks_worker_node_launch_template.latest_version
//  instance_types          = local.eks_worker_node_instance_types
//
//  on_demand_base_capacity                  = 1
//  on_demand_percentage_above_base_capacity = 0
//  spot_allocation_strategy                 = "lowest-price"
//  spot_instance_pools                      = length(local.eks_worker_node_instance_types)
//
//  vpc_zone_identifier = local.private_subnet_ids
//
//  cluster_name = local.eks_cluster_name
//
//  tags = [
//    for k, v in local.default_tags : {
//      key                 = k,
//      value               = v,
//      propagate_at_launch = true
//  }]
//}

## Create EKS Worker Node Autoscaling Group
module eks_worker_node_single_instance_type_autoscaling_group {
  source = "../../modules/eks/eks_worker_node_single_instance_type_autoscaling_group"

  name = format("%s-eks-worker-node", var.eks_cluster_name)

  max_size         = var.num_of_instances
  desired_capacity = var.num_of_instances
  min_size         = var.num_of_instances

  launch_template_id      = module.eks_worker_node_launch_template.id
  launch_template_version = module.eks_worker_node_launch_template.latest_version

  vpc_zone_identifier = local.private_subnet_ids

  cluster_name = var.eks_cluster_name

  tags = [
    for k, v in var.default_tags : {
      key                 = k,
      value               = v,
      propagate_at_launch = true
  }]


}