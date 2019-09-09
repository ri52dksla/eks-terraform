# EKS Terraform

## Structure

### modules

- [EKS Security Group Rules](./modules/eks/eks_security_groups_rules/README.md)
- [EKS Cluster IAM Policies](modules/eks/eks_cluster_iam_policies/README.md)
- [EKS Worker Node IAM Policies](modules/eks/eks_worker_node_iam_policies/README.md)
- [EKS Worker Node Launch Template](modules/eks/eks_worker_node_launch_template/README.md)
- [EKS Worker Node Single Instance Type AutoScaling Group](modules/eks/eks_worker_node_single_instance_type_autoscaling_group/README.md)
- [EKS Worker Node Mixed Instance Types AutoScaling Group](modules/eks/eks_worker_node_mixed_instance_types_autoscaling_group/README.md)

### examples

- [simple](examples/simple/README.md)