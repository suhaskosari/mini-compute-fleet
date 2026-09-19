output "fleet_public_ips" {
  description = "Public IP of every fleet node, in order"
  value       = aws_instance.fleet[*].public_ip
}

output "fleet_private_ips" {
  description = "Private IP of every fleet node, in order"
  value       = aws_instance.fleet[*].private_ip
}

output "monitoring_node_public_ip" {
  description = "Public IP of the node running Prometheus + Grafana"
  value       = aws_instance.fleet[var.monitoring_node_index].public_ip
}

output "ssh_commands" {
  description = "Ready-to-paste SSH commands for each node"
  value = [
    for instance in aws_instance.fleet :
    "ssh -i ~/.ssh/${var.ssh_key_name}.pem ubuntu@${instance.public_ip}"
  ]
}
