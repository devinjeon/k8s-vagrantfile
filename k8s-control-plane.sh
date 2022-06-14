#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
. /vagrant/k8s-common.sh

# Setup Control-plane
# Create kubeadm init configuration file
# podSubnet should be same with flannel network cidr block
# https://github.com/coreos/flannel/blob/v0.13.0/Documentation/kube-flannel.yml#L128
cat <<EOF | tee ./kubeadm-init-config.yml
apiVersion: kubeadm.k8s.io/v1beta2
kind: InitConfiguration
localAPIEndpoint:
  advertiseAddress: 192.168.101.2
  bindPort: 6443
---
apiVersion: kubelet.config.k8s.io/v1beta1
kind: KubeletConfiguration
cgroupDriver: systemd
---
apiVersion: kubeadm.k8s.io/v1beta2
kind: ClusterConfiguration
networking:
  podSubnet: 10.244.0.0/16
apiServer:
  certSANs:
  - "192.168.101.2"
EOF

sudo kubeadm init --config kubeadm-init-config.yml | sudo tee "/tmp/kube-adm-result.txt"

sudo tail -n 2 "/tmp/kube-adm-result.txt" | sudo tee "$KUBEADM_INIT_WORKER"
sudo chmod +x "$KUBEADM_INIT_WORKER"

# Kubectl
mkdir -p "$HOME/.kube"
sudo cp -i /etc/kubernetes/admin.conf "$HOME/.kube/config"
sudo chown "$(id -u)":"$(id -g)" "$HOME/.kube/config"

# Use flannel as CNI
kubectl apply -f /vagrant/kube-flannel.yml
