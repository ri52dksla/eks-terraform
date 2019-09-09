output "id" {
  value       = aws_launch_template.eks_worker_node_launch_template.id
  description = "The ID of the launch template."
}

output "default_version" {
  value       = aws_launch_template.eks_worker_node_launch_template.default_version
  description = " The default version of the launch template."
}

output "latest_version" {
  value       = aws_launch_template.eks_worker_node_launch_template.latest_version
  description = " The latest version of the launch template."
}
