#!/usr/bin/env bash

set -euo pipefail

if [[ $# -eq 0 || -z "$1" ]]
then
  echo "* Please input node IP address. Usage: $0 <node_ip>"
  exit 1
fi

NODE_IP="$1"

function set_node_ip_to_kubelet() {
  KUBEADM_CONF='/etc/systemd/system/kubelet.service.d/10-kubeadm.conf'
  OPTIONS="--node-ip=$NODE_IP"

  if [[ ! -e "$KUBEADM_CONF" ]]; then
    echo "* Cannot find $KUBEADM_CONF"
    exit 1
  fi

  if sudo grep -q -- "$OPTIONS" "$KUBEADM_CONF"; then
    echo "* --node-ip=$NODE_IP option already set."
  else
    sudo sed -i "s#bin/kubelet#bin/kubelet $OPTIONS#g" "$KUBEADM_CONF"
  fi
}

set_node_ip_to_kubelet && \
  sudo systemctl daemon-reload && \
  sudo systemctl restart kubelet
