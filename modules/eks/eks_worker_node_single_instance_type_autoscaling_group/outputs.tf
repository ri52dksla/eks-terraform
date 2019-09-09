output "name" {
  value       = aws_autoscaling_group.eks_worker_node_autoscaling_group.name
  description = "the name of the Auto Scaling Group"
}

output "arn" {
  value       = aws_autoscaling_group.eks_worker_node_autoscaling_group.arn
  description = "The ARN of the Auto Scaling Group"
}