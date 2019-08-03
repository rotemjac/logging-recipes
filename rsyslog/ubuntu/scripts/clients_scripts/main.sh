#!/usr/bin/env bash

sudo systemctl start rsyslog
sudo systemctl enable rsyslog

# ADD hostname - to be used below (no override - because of >>)
cat << 'EOT' >> /etc/hosts
192.168.11.11 syslog-server #This is the hostname given by vagrant networking
EOT

# Override (because of >) rules
cat << 'EOT' > /etc/rsyslog.d/50-default.conf
#  Send All to remote syslog server.
*.* @syslog-server:514
*.* @@syslog-server:514
EOT

sudo systemctl restart rsyslog



