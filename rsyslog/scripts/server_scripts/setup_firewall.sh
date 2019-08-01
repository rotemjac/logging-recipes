#!/usr/bin/env bash

sudo systemctl start firewalld
sudo systemctl enable firewalld

sudo firewall-cmd --permanent --add-port=514/udp
sudo firewall-cmd --permanent --add-port=514/tcp
sudo firewall-cmd --reload