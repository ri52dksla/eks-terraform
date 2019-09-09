## Create Auto Scaling Group for EKS Worker Node
resource "aws_autoscaling_group" "eks_worker_node_autoscaling_group" {

  name = var.name

  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  min_size         = var.min_size

  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }

  vpc_zone_identifier = var.vpc_zone_identifier

  metrics_granularity = "1Minute"

  # https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-instance-monitoring.html
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = var.name
  }

  ## You must add tag `"kubernetes.io/cluster/${cluster_name}" = "owned"` and set it propagate_at_launch, or you will encounter error.
  ## EKS Documentation does not have this tagging requirement instruction as of now.
  ## https://github.com/awsdocs/amazon-eks-user-guide/issues/38
  ## https://stackoverflow.com/questions/51693092/aws-eks-terraform-tag-kubernetescluster-nor-kubernetes-io-cluster-not
  tag {
    key = "kubernetes.io/cluster/${
    var.cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }


  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.value.key
      value               = tag.value.value
      propagate_at_launch = tag.value.propagate_at_launch
    }
  }
}
