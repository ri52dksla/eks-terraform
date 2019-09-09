
variable "default_region" {
  type        = string
  description = "The name of region where resources created"
  default     = "ap-northeast-1"
}

variable "eks_cluster_name" {
  type        = string
  description = "The name of the EKS Cluster"
  default     = "simple-cluster"
}

variable "eks_cluster_version" {
  type        = string
  description = "The Version of the EKS Cluster"
  default     = "1.14"
}

variable "num_of_instances" {
  type        = number
  description = "number of instances to launch"
  default     = 3
}

variable "instance_type" {
  type        = string
  description = "instance type to launch"
  default     = "t3.large"
}

variable "default_tags" {
  type        = map(string)
  description = "tags attached to all resources"
  default     = {}
}

locals {

  eks_worker_node_instance_types = [
    var.instance_type,
    "m5.large",
  "c5.large"]
}