data "aws_region" "current_region" {}

locals {

  ## create UserData from template
  rendered_user_data = templatefile("${path.module}/templates/eks_worker_node_userdata.sh.template", {
    pre_userdata                       = var.pre_user_data
    cluster_name                       = var.cluster_name,
    aws_region                         = data.aws_region.current_region.name
    bootstrap_arguments_for_spot_fleet = var.bootstrap_arguments_for_spot_fleet,
    bootstrap_arguments_for_on_demand  = var.bootstrap_arguments_for_on_demand
    additional_userdata                = var.additional_user_data
  })
}


## Create Launch Template for EKS Worker Node
resource "aws_launch_template" "eks_worker_node_launch_template" {

  name        = var.name
  description = var.description

  block_device_mappings {

    device_name = var.volume_name
    ebs {
      volume_size           = var.volume_size
      volume_type           = var.volume_type
      delete_on_termination = true
    }
  }

  instance_type = var.instance_type

  disable_api_termination = var.disable_api_termination
  ebs_optimized           = var.ebs_optimized

  iam_instance_profile {
    arn = var.iam_instance_profile_arn
  }

  image_id = var.image_id

  key_name = var.key_name

  monitoring {
    enabled = var.monitoring_enable
  }

  vpc_security_group_ids = var.security_group_ids

  user_data = base64encode(local.rendered_user_data)

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}
