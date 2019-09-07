## Control Plane Security Group Rule (Inbound)

resource "aws_security_group_rule" "allow_tco_443_inbound_traffic_from_worker_node_to_control_plane_security_group_rule" {
  description = "allow 443 inbound traffic from worker node to control plane"
  protocol = "tcp"
  source_security_group_id = var.eks_worker_node_security_group_id
  security_group_id = var.eks_control_plane_security_group_id
  from_port = 443
  to_port = 443
  type = "ingress"
}

## Control Plane Security Group Rule (Outbound))

resource "aws_security_group_rule" "allow_tcp_1025_to_65535_outbound_traffic_from_control_plane_to_worker_node_security_group_rule" {
  description = "allow outbound traffic from worker node to control plane"
  protocol = "tco"
  security_group_id = var.eks_control_plane_security_group_id
  source_security_group_id = var.eks_worker_node_security_group_id
  from_port = 1025
  to_port = 65535
  type = "egress"
}

## Worker Node Security Group Rule (Inbound)

resource "aws_security_group_rule" "allow_all_inbound_traffic_from_worker_node_to_worker_node_security_group_rule" {
  description = "allow all inbound traffic from worker node"
  from_port = 0
  protocol = "-1"
  security_group_id = var.eks_worker_node_security_group_id
  source_security_group_id = var.eks_worker_node_security_group_id
  to_port = 65536
  type = "ingress"
}


resource "aws_security_group_rule" "allow_tcp_443_inbound_traffic_from_control_plane_to_worker_node_security_group_rule" {
  description = "allow tcp 443 inbound traffic from control plane to worker node"
  from_port = 443
  protocol = "tcp"
  security_group_id = var.eks_worker_node_security_group_id
  source_security_group_id = var.eks_control_plane_security_group_id
  to_port = 443
  type = "ingress"
}

resource "aws_security_group_rule" "allow_tcp_1025_to_65535_inbound_traffic_from_control_plane_to_worker_node_security_group_rule" {
  description = "allow tcp 1025 to 65535 inbound traffic from control plane to worker node"
  from_port = 1025
  protocol = "tcp"
  security_group_id = var.eks_worker_node_security_group_id
  source_security_group_id = var.eks_control_plane_security_group_id
  to_port = 65535
  type = "ingress"
}


## Worker Node Security Group Rule (Outbound)

resource "aws_security_group_rule" "allow_outbound_traffic_from_worker_node_to_internet_security_group_rule" {
  description = "allow outbound traffic from worker node to the Internet"
  protocol = "-1"
  security_group_id = var.eks_worker_node_security_group_id
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  from_port = 0
  to_port = 0
  type = "egress"
}