#!/usr/bin/env bash
# Local equivalent of the CI deploy pipeline, for running the whole thing
# from a laptop instead of GitHub Actions: provision the fleet, wait for
# SSH, then run the full Ansible configuration.
set -euo pipefail

cd "$(dirname "$0")/../terraform"

echo "==> terraform init"
terraform init

echo "==> terraform apply"
terraform apply

echo "==> waiting for SSH on every node"
for host in $(terraform output -json fleet_public_ips | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+'); do
  echo "waiting for $host:22..."
  timeout 180 bash -c "until nc -z $host 22; do sleep 5; done"
done

cd ../ansible
echo "==> ansible-playbook playbooks/site.yml"
ansible-playbook playbooks/site.yml

echo "==> done. Grafana: http://$(terraform -chdir=../terraform output -raw monitoring_node_public_ip):3000 (admin/admin on first login)"
