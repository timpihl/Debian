#!/bin/bash

apt update
apt -y full-upgrade

timedatectl set-timezone Europe/Stockholm
