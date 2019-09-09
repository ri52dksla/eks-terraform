## Create Cloudwatch Log Group for EKS Control Plan
## https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
resource "aws_cloudwatch_log_group" "eks_cluster_control_plane_log_group" {

  name              = format("/aws/eks/%s/cluster", var.eks_cluster_name)
  retention_in_days = 1

  tags = merge(
    {
      Name = format("/aws/eks/%s/cluster", var.eks_cluster_name)
    },
    var.default_tags
  )
}