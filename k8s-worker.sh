#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
. /vagrant/k8s-common.sh

sudo "$KUBEADM_INIT_WORKER"
