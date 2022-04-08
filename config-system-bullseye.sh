#!/bin/bash

export LC_ALL=en_US.UTF-8
export LC_CTYPE=UTF-8
export LANG=en_US.UTF-8

apt update
apt -y full-upgrade

timedatectl set-timezone Europe/Stockholm
