# Locked down to var.admin_cidr on purpose - node_exporter (9100) and
# Prometheus (9090)/Grafana (3000) are only reachable from inside the SG,
# never from the internet.

resource "aws_security_group" "fleet" {
  name        = "${var.project_name}-sg"
  description = "Mini compute fleet: SSH + demo app from admin CIDR, monitoring ports within the fleet only"
  vpc_id      = aws_vpc.fleet.id

  ingress {
    description = "SSH from admin CIDR"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
  }

  ingress {
    description = "Demo app from admin CIDR"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
  }

  ingress {
    description = "Grafana UI from admin CIDR"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
  }

  ingress {
    description = "node_exporter + Prometheus, fleet-internal only"
    from_port   = 9090
    to_port     = 9100
    protocol    = "tcp"
    self        = true
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-sg"
    Project = var.project_name
  }
}
