#!/bin/bash

sudo useradd --system --no-create-home --shell /bin/false node_exporter
wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXP_VER}/node_exporter-${NODE_EXP_VER}.linux-amd64.tar.gz
tar -xvf node_exporter-${NODE_EXP_VER}.linux-amd64.tar.gz
sudo mv node_exporter-${NODE_EXP_VER}.linux-amd64/node_exporter /usr/local/bin/
rm -rf node_exporter*
node_exporter --version
mv node_exporter.service /etc/systemd/system/node_exporter.service
sudo systemctl enable node_exporter
sudo systemctl start node_exporter
sudo systemctl status node_exporter