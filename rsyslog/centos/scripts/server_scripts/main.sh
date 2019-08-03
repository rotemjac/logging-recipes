#!/usr/bin/env bash

sudo systemctl start rsyslog
sudo systemctl enable rsyslog

# Uncomment UDP section
sed -i '/ModLoad imudp/s/^#//g' /etc/rsyslog.conf
sed -i '/$UDPServerRun 514/s/^#//g' /etc/rsyslog.conf

# Uncomment TCP section - Not being used in this example
sed -i '/$ModLoad imtcp/s/^#//g' /etc/rsyslog.conf
sed -i '/$InputTCPServerRun 514/s/^#//g' /etc/rsyslog.conf


#Insert after GLOBAL DIRECTIVES section (To Insert before - replace */a with */i)
sed -i '/^#### GLOBAL DIRECTIVES ####.*/i ## Rules for processing remote logs \n $template RemoteLogs,"/var/log/%HOSTNAME%/%PROGRAMNAME%.log" \n *.* ?RemoteLogs \n ' /etc/rsyslog.conf


sudo systemctl restart rsyslog

# Only if SELinux enabled
#sudo semanage -a -t syslogd_port_t -p udp 514
#sudo semanage -a -t syslogd_port_t -p tcp 514


sudo systemctl start firewalld
sudo systemctl enable firewalld

sudo firewall-cmd --permanent --add-port=514/udp
sudo firewall-cmd --permanent --add-port=514/tcp
sudo firewall-cmd --reload
