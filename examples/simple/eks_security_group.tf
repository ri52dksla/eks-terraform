## Create Security Group for EKS Worker Node
resource "aws_security_group" "eks_worker_node_security_group" {
  name        = format("%s-eks-worker-node", var.eks_cluster_name)
  vpc_id      = local.vpc_id
  description = format("EKS (%s) Worker Node Security Group", var.eks_cluster_name)
  tags = merge(
    {
      Name = format("%s-eks-worker-node", var.eks_cluster_name)
    },
    var.default_tags
  )
}

## Create Security Group for EKS Control Plane
resource "aws_security_group" "eks_control_plane_security_group" {
  name        = format("%s-eks-control-plane", var.eks_cluster_name)
  vpc_id      = local.vpc_id
  description = format("EKS (%s) Control Plane Security Group", var.eks_cluster_name)
  tags = merge(
    {
      Name = format("%s-eks-control-plane", var.eks_cluster_name)
    },
    var.default_tags
  )
}

module eks_security_groups_rules {
  source                              = "../../modules/eks/eks_security_groups_rules"
  eks_control_plane_security_group_id = aws_security_group.eks_control_plane_security_group.id
  eks_worker_node_security_group_id   = aws_security_group.eks_worker_node_security_group.id

}