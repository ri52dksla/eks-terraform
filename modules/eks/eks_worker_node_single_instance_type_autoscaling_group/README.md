# EKS Worker Node Single Instance Type AutoScaling Group

Create AutoScaling Group that uses supplied Launch Template's instance type.  
The Launch Template passed to this module must set its Instance Type.  

## Resources

- AutoScaling Group

## Usage

```hcl-terraform

locals {
  eks_cluster_name = "example"
}

variable "eks_worker_node_launch_template_id" {
	type = string
}

## Launch Template must set instance_type
data "aws_launch_template" "eks_worker_node_launch_template" {
  name = var.eks_worker_node_launch_template_id
}

variable "subnet_ids" {
	type = list(string)
}


module eks_worker_node_single_instance_type_autoscaling_group {

 source = "/path/to/module"
 
 name = local.eks_cluster_name
 
 max_size = 3
 desired_capacity = 3
 min_size = 3
 
 launch_template_id = data.aws_launch_template.eks_worker_node_launch_template.id
 launch_template_version = data.aws_launch_template.eks_worker_node_launch_template.latest_version
 
 subnet_ids = var.subnet_ids
 
 cluster_name = local.eks_cluster_name
}

```