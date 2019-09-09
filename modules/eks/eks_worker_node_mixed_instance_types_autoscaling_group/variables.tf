# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "name" {
  type        = string
  description = "The name of the Auto Scaling Group"
}

variable "max_size" {
  type        = number
  description = "The maximum size of the auto scale group."
}

variable "desired_capacity" {
  type        = number
  description = "The number of Amazon EC2 instances that should be running in the group"
}

variable "min_size" {
  type        = number
  description = "The minimum size of the auto scale group. "
}

variable "launch_template_id" {
  type        = string
  description = "The ID of the launch template."
}

variable "launch_template_version" {
  type        = string
  description = "The version of the launch template."
}

variable "instance_types" {
  type        = list(string)
  description = "A list of instance type"
}

variable "on_demand_base_capacity" {
  type        = number
  description = "Absolute minimum amount of desired capacity that must be fulfilled by on_demand instances."
}

variable "spot_allocation_strategy" {
  type        = string
  description = "Indicates how to allocate instances across Spot Instance pools. value should be either lowest_price or capacity_optimized"
}

variable "on_demand_percentage_above_base_capacity" {
  type        = number
  description = "Percentage split between on_demand and Spot instances above the base on_demand capacity"
}

variable "spot_instance_pools" {
  type        = number
  description = "Number of Spot pools per availability zone to allocate capacity"
}

variable "vpc_zone_identifier" {
  type        = list(string)
  description = "A list of subnet IDs"
}

variable "cluster_name" {
  type        = string
  description = "The name of the EKS Cluster"
}



# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------



variable "tags" {
  type = list(object({
    key                 = string
    value               = string
    propagate_at_launch = bool
  }))

  default = []

  description = "A map of tags to add to Auto Scaling Group. if propagate_at_launch is true, then propagate the tag to EC2 Instance"

}
