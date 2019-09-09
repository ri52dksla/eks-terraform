# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------


variable "name" {
  type        = string
  description = "The name of the Launch Template"
}

variable "iam_instance_profile_arn" {
  type        = string
  description = "The ARN of the IAM Instance Profile attached to the EC2 instance launched by this template"
}

variable "image_id" {
  type        = string
  description = "The ID of the AMI from which to launch the instance. This module expects that image_id should be an Amazon EKS-optimized AMI"
}

variable "security_group_ids" {
  type        = list(string)
  description = "A list of the Security Group IDs attached to the launched EC2 instance"
}

variable "cluster_name" {
  type        = string
  description = "The name of the EKS Cluster"
}

variable "volume_name" {
  type        = string
  description = "root volume name"
}

variable "volume_type" {
  type        = string
  description = "ebs volume type to use"
}

variable "volume_size" {
  type        = number
  description = "root volume size"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------


variable "description" {
  type        = string
  default     = "Launch Template for EKS Worker Node"
  description = "description for Launch Template"
}

variable "instance_type" {
  type        = string
  default     = null
  description = "Instnace Type"
}

variable "disable_api_termination" {
  type        = bool
  default     = false
  description = "If true, enables EC2 Instance Termination Protection"
}

variable "ebs_optimized" {
  type        = bool
  default     = false
  description = "If true, the launchced EC2 instance will be ebs optimized"
}

variable "key_name" {
  type        = string
  default     = null
  description = "The key name to use for the instance"
}

variable "monitoring_enable" {
  type        = bool
  default     = false
  description = "If true, the launched EC2 instance will have detailed monitoring enabled."
}

variable "pre_user_data" {
  type        = string
  description = "supply pre userdata code"
  default     = ""
}

variable "bootstrap_arguments_for_spot_fleet" {
  type = string
  ## copy from https://eksworkshop.com/spotworkers/workers/
  default     = "--kubelet-extra-args '--node-labels=lifecycle=Ec2Spot --register-with-taints=spotInstance=true:PreferNoSchedule'"
  description = "Arguments to pass to the bootstrap script. See files/bootstrap.sh in https://github.com/awslabs/amazon-eks-ami"
}

variable "bootstrap_arguments_for_on_demand" {
  type = string
  ## copy from https://eksworkshop.com/spotworkers/workers/
  default     = "--kubelet-extra-args --node-labels=lifecycle=OnDemand"
  description = "Arguments to pass to the bootstrap script. See files/bootstrap.sh in https://github.com/awslabs/amazon-eks-ami"
}

variable "additional_user_data" {
  type        = string
  description = "supply additional userdata code"
  default     = ""
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to lauch template"
}
