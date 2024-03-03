#!/bin/bash

source envs.sh
cd installation/
sudo chmod +x k8s.sh docker.sh node_exporter.sh && cd ..

sudo hostnamectl set-hostname ${K8SM_NAME}

bash installation/k8s.sh

sudo kubeadm init --pod-network-cidr=$POD_NET_CIDR
# in case your in root exit from it and run below commands
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

bash installation/node_exporter.sh