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

variable "vpc_zone_identifier" {
  type        = list(string)
  description = "The VPC Zone Identifier"
}

variable "cluster_name" {
  type        = string
  description = "The name of the EKS Cluster"
}

variable "tags" {
  type = list(object({
    key                 = string
    value               = string
    propagate_at_launch = bool
  }))

  default = []

  description = "A map of tags to add to Auto Scaling Group. if propagate_at_launch is true, then propagate the tag to EC2 Instance"

}