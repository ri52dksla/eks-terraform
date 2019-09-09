## Create aws-auth configmap
## https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html
resource "kubernetes_config_map" "aws_auth_configmap" {

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<EOF
- rolearn: ${aws_iam_role.eks_worker_node_role.arn}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
EOF
  }

}