#!/usr/bin/env bash

sudo systemctl start rsyslog
sudo systemctl enable rsyslog

#UDP
sed -i '/^# ### end of the forwarding rule ###.*/i *.* @192.168.11.11:514 ' /etc/rsyslog.conf

#TCP
sed -i '/^# ### end of the forwarding rule ###.*/i *.* @@192.168.11.11:514 ' /etc/rsyslog.conf

sudo systemctl restart rsyslog