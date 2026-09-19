#!/usr/bin/env bash
# Tears the fleet down completely so it doesn't sit around burning free-tier
# hours (or money, past the free tier).
set -euo pipefail

cd "$(dirname "$0")/../terraform"
terraform destroy
