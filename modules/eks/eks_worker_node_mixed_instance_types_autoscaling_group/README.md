# EKS Worker Node Mixed Instance Types AutoScaling Group

Create AutoScaling Group that uses supplied Launch Template and launch instances based on mixed instances policy. 

## Resources

- AutoScaling Group  

## Usage

```hcl-terraform

locals {
	eks_cluster_name = "example"
 	instance_types = [
    "t3.large",
    "m5.large",
    "c5.large"
 	]
}

variable "eks_worker_node_launch_template_id" {
	type = string
}

data "aws_launch_template" "eks_worker_node_launch_template" {
  name = var.eks_worker_node_launch_template_id
}

variable "subnet_ids" {
	type = list(string)
}

locals {
  tags = {
    Terraform = "true"
  }
}

module eks_worker_node_mixed_instance_types_autoscaling_group {

 source = "/path/to/module"
 
 name = local.eks_cluster_name
 
 max_size = 10
 desired_capacity = 10
 min_size = 10
 
 launch_template_id = data.aws_launch_template.eks_worker_node_launch_template.id
 launch_template_version = data.aws_launch_template.eks_worker_node_launch_template.latest_version
 instance_types = local.instance_types
 
 on_demand_base_capacity = 2
 on_demand_percentage_above_base_capacity = 50
 spot_allocation_strategy = "lowest-price"
 spot_instance_pools = length(local.instance_types)
 
 vpc_zone_identifier = var.subnet_ids
 
 cluster_name = local.eks_cluster_name
 
  tags = [
  for k, v in local.tags : {
    key                 = k,
    value               = v,
    propagate_at_launch = true
  }]
}
```
