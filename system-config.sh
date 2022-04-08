#!/bin/bash

ssh_conf="/etc/ssh/sshd_config.d/ssh.conf"

export LC_ALL=en_US.UTF-8
export LC_CTYPE=UTF-8
export LANG=en_US.UTF-8

apt update
apt -y full-upgrade

timedatectl set-timezone Europe/Stockholm

echo "PrintMotd no" > $ssh_conf
echo "PrintLastLog no" >> $ssh_conf
echo "TCPKeepAlive yes" >> $ssh_conf
echo "ClientAliveInterval 60" >> $ssh_conf
echo "ClientAliveCountMax 100" >> $ssh_conf

service ssh restart
