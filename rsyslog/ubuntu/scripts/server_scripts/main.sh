#!/usr/bin/env bash

service rsyslog start
service rsyslog enable

# Enable both UDP and TCP log reception
sed -i '/module(load="imudp")/s/^#//g' /etc/rsyslog.conf
sed -i '/input(type="imudp" port="514")/s/^#//g' /etc/rsyslog.conf
sed -i '/module(load="imtcp")/s/^#//g' /etc/rsyslog.conf
sed -i '/input(type="imtcp" port="514")/s/^#//g' /etc/rsyslog.conf


#Insert after global directives section (To Insert before - replace */a with */i)
sed -i '/^#### GLOBAL DIRECTIVES ####.*/i ## Rules for processing remote logs \n $template RemoteLogs,"/var/log/%HOSTNAME%/%PROGRAMNAME%.log" \n *.* ?RemoteLogs \n ' /etc/rsyslog.conf

service rsyslog restart

# Only if SELinux enabled
#sudo semanage -a -t syslogd_port_t -p udp 514
#sudo semanage -a -t syslogd_port_t -p tcp 514


#ufw is a bit special imho - it's not really a "service" in the traditional sense (such as running a listening daemon for example), it's just an interface to the kernel's iptables ruleset
#If enabled (as a "service") it just runs once on boot to load the rules into the kernel, and then exits - hence
#Code:
#(code=exited, status=0/SUCCESS)

# https://help.ubuntu.com/lts/serverguide/firewall.html
# https://www.linode.com/docs/security/firewalls/configure-firewall-with-ufw/
ufw enable
ufw allow 514/udp
ufw allow 514/tcp