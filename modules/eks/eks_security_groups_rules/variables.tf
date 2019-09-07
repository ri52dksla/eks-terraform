# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "eks_control_plane_security_group_id" {
  type = string
  description = "Security Group ID of EKS Control Plane"
}

variable "eks_worker_node_security_group_id" {
  type = string
  description = "Security Group ID of EKS Worker Node"
}