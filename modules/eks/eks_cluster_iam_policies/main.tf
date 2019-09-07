resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy_eks_cluster_role_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = var.iam_role_name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy_eks_cluster_role_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = var.iam_role_name
}