#!/bin/bash

apt purge -y php* mysql* nginx* percona-server-* postfix* redis* memcached* nodejs* clp*

apt autopurge -y

rm -rf /etc/cloudpanel*
rm -rf /etc/mysql*
rm -rf /etc/alternatives/my.cnf
rm -rf /etc/nginx*
rm -rf /etc/postfix*
rm -rf /var/mail*
rm -rf /var/www*
rm -rf /var/lib/mysql*
rm -rf /var/lib/clp*
rm -rf /usr/bin/clpctl
rm -rf /usr/local/bin/clp_reset_permissions
rm -rf /home/mysql*
rm -rf /home/cloudpanel*
rm -rf /home/clp*
rm -rf /home/clp-admin*

killall -u clp
killall -u clp-admin

deluser clp
deluser clp-admin
delgroup clp
delgroup clp-admin
