variable "aws_region" {
  description = "AWS region to provision the fleet in"
  type        = string
  default     = "eu-north-1" # Stockholm - closest free-tier region to Sweden
}

variable "fleet_size" {
  description = "Number of Linux VMs in the fleet"
  type        = number
  default     = 3
}

variable "instance_type" {
  description = "EC2 instance type (t3.micro is free-tier eligible)"
  type        = string
  default     = "t3.micro"
}

variable "project_name" {
  description = "Short name used to prefix/tag every resource"
  type        = string
  default     = "mini-compute-fleet"
}

variable "admin_cidr" {
  description = "CIDR allowed to reach SSH (22) and the demo app port (8080). Set this to your own IP/32, never 0.0.0.0/0."
  type        = string
}

variable "ssh_key_name" {
  description = "Name of an existing EC2 key pair to attach to every instance"
  type        = string
}

variable "monitoring_node_index" {
  description = "Index (0-based) of the fleet node that also runs Prometheus + Grafana"
  type        = number
  default     = 0
}
