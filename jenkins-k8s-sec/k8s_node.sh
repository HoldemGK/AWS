#!/bin/bash

source envs.sh
cd installation/
sudo chmod +x k8s.sh docker.sh node_exporter.sh && cd ..
IND=1

sudo hostnamectl set-hostname ${K8SW_NAME}$

sudo kubeadm join ${MASTER_IP}:${MASTER_PORT} --token ${MASTER_TOKEN} --discovery-token-ca-cert-hash ${MASTER_HASH}

bash installation/node_exporter.sh