#!/bin/bash

export IP=""
#export VERSION="1.0.7"

ARCHITECTURE=$(dpkg --print-architecture)
CLOUDPANEL_DEB_URL=https://github.com/cloudpanel-io/cloudpanel-ce/releases/latest/download/cloudpanel.deb

die()
{
  /bin/echo -e "ERROR: $*" >&2
  exit 1
}

setIp()
{
  IP=$(curl -s -4 ifconfig.co)
}

preConfig()
{
  echo -e "\n#\n" >> /etc/sudoers
}

setupRequiredPackages()
{
  apt update 
  DEBIAN_FRONTEND=noninteractive apt -y install curl sudo wget gnupg apt-transport-https
  DEBIAN_FRONTEND=noninteractive apt -y install postfix
}

addAptSourceList()
{
  curl -fsSL https://d17k9fuiwb52nc.cloudfront.net/key.gpg | apt-key add - &> /dev/null
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - &> /dev/null
  curl -fsSL https://packages.sury.org/php/apt.gpg | apt-key add - &> /dev/null
  curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &> /dev/null

  echo "" > /etc/apt/sources.list

  curl -sO --output-dir /etc/apt/sources.list.d/ https://raw.githubusercontent.com/timpihl/Debian/master/cloudpanel-bullseye.list
  curl -sO --output-dir /etc/apt/sources.list.d/ https://raw.githubusercontent.com/timpihl/Debian/master/cloudpanel-buster.list
  curl -sO --output-dir /etc/apt/sources.list.d/ https://raw.githubusercontent.com/timpihl/Debian/master/updates-bullseye.list
  curl -sO --output-dir /etc/apt/sources.list.d/ https://raw.githubusercontent.com/timpihl/Debian/master/updates-buster.list
  curl -sO --output-dir /etc/apt/sources.list.d/ https://raw.githubusercontent.com/timpihl/Debian/master/sury.list
  curl -sO --output-dir /etc/apt/sources.list.d/ https://raw.githubusercontent.com/timpihl/Debian/master/node.list
  curl -sO --output-dir /etc/apt/sources.list.d/ https://raw.githubusercontent.com/timpihl/Debian/master/yarn.list
  curl -sO --output-dir /etc/apt/preferences.d/ https://raw.githubusercontent.com/timpihl/Debian/master/00-cloudpanel.pref

  apt update
}

setupCloudPanel()
{
  rm -rf /etc/mysql/
  curl -Lks $CLOUDPANEL_DEB_URL -o /tmp/cloudpanel.deb
  DEBIAN_FRONTEND=noninteractive apt -o Dpkg::Options::="--force-overwrite" install -y -f /tmp/cloudpanel.deb
}

showSuccessMessage()
{
  CLOUDPANEL_URL_FILE="/etc/cloudpanel/.cloudpanel_url"
  if [ -f "$CLOUDPANEL_URL_FILE" ]; then
    CLOUDPANEL_URL=$(cat /etc/cloudpanel/.cloudpanel_url)
    printf "\n\n"
    printf "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
    printf "The installation of CloudPanel is complete!\n\n"
    printf "CloudPanel can be accessed now: $CLOUDPANEL_URL\n"
    printf "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
  fi
}

setIp
preConfig
setupRequiredPackages
addAptSourceList
setupCloudPanel
showSuccessMessage
