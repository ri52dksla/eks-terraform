resource "aws_iam_role_policy_attachment" "eks_worker_node_role_AmazonEKSWorkerNodePolicy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = var.iam_role_name
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_role_AmazonEKS_CNI_Policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = var.iam_role_name
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_role_AmazonEC2ContainerRegistryReadOnly_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = var.iam_role_name
}