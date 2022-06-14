# kubernetes-vagrantfile

Includes Vagrantfile and scripts for provisioning Kubernetes

* Kubernetes 1.21.8
* Docker 20.10.17
* Flannel CNI v0.13.0
* Ubuntu 18.04

## Requirements

* Install [Vagrant](https://www.vagrantup.com/docs/installation)
  * Tested Vagrant v2.2.18
* Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
  * Tested VirtualBox v6.1.34
## Usage

```bash
$ git clone https://github.com/devinjeon
$ cd vagrant-k8s
$ vagrant up
$ vagrant ssh [control-plane|worker-node1|worker-node2|worker-node3]
```
