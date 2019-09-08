# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "iam_role_name" {
  type        = string
  description = "The name of the IAM Role to which this module attach IAM Policies for EKS Worker Node"
}