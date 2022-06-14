# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_IMAGE = "bento/ubuntu-18.04"
NODE_COUNT = 3

Vagrant.configure("2") do |config|

  config.vm.define "control-plane" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "control-plane"
    subconfig.vm.network :private_network, ip: "192.168.101.2"
    config.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
    subconfig.vm.provision "shell", inline: "/vagrant/k8s-control-plane.sh", privileged: false
    subconfig.vm.provision "shell", inline: "/vagrant/k8s-set-kubelet-node-ip.sh \"192.168.101.2\"", privileged: false
  end

  (1..NODE_COUNT).each do |i|
    config.vm.define "worker-node#{i}" do |subconfig|
      subconfig.vm.box = BOX_IMAGE
      subconfig.vm.hostname = "worker-node#{i}"
      subconfig.vm.network :private_network, ip: "192.168.101.#{i + 2}"
      config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
      end
      subconfig.vm.provision "shell", inline: "/vagrant/k8s-worker.sh", privileged: false
      subconfig.vm.provision "shell", inline: "/vagrant/k8s-set-kubelet-node-ip.sh \"192.168.101.#{i + 2}\"", privileged: false
    end
  end
end
