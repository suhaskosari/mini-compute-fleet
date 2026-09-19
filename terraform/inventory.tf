# Bridges provisioning -> configuration management: every `terraform apply`
# regenerates the Ansible inventory from live instance state, so the two
# tools never drift out of sync with each other.

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory/hosts.ini"
  content = templatefile("${path.module}/templates/hosts.ini.tftpl", {
    fleet_ips        = aws_instance.fleet[*].public_ip
    monitoring_index = var.monitoring_node_index
    ssh_key_name     = var.ssh_key_name
  })
}
