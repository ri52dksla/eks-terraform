resource "aws_iam_role_policy_attachment" "eks_cluster_role_AmazonEKSClusterPolicy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = var.iam_role_name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_role_AmazonEKSServicePolicy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = var.iam_role_name
}