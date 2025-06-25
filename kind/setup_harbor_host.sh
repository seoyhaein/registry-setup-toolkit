#!/usr/bin/env bash
set -euo pipefail

NODE_NAME="harbor-cluster-control-plane"
HOSTNAME="harbor.local"

echo "🔍 Fetching Kind control-plane InternalIP…"
NODE_IP=$(kubectl get node "${NODE_NAME}" \
  -o jsonpath='{.status.addresses[?(@.type=="InternalIP")].address}')

if [ -z "$NODE_IP" ]; then
  echo "❌ Failed to fetch IP for node ${NODE_NAME}."
  exit 1
fi

ENTRY="${NODE_IP} ${HOSTNAME}"

echo "🔧 Removing any old '${HOSTNAME}' entries from /etc/hosts…"
# harbor.local 이 언급된 줄을 모두 지움
sudo sed -i.bak '/[[:space:]]'"${HOSTNAME}"'$/d' /etc/hosts

echo "🔧 Adding new entry: ${ENTRY}"
echo "${ENTRY}" | sudo tee -a /etc/hosts > /dev/null

echo "✔ Done. /etc/hosts updated. You can now access Harbor at http://${HOSTNAME}"
