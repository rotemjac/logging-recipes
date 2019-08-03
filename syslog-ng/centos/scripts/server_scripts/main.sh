#!/usr/bin/env bash

mkdir -p /var/log/syslog-ng

# Override (because of >) rules
cat << 'EOT' > /etc/syslog-ng/syslog-ng.conf

@version: 3.5
@include "scl.conf"
#@include "`scl-root`/system/tty10.conf"

options {
     time-reap(30);
     mark-freq(10);
     keep-hostname(yes);
};

source s_local { system(); internal(); };
source s_network {
     syslog(transport(udp) port(514));
     syslog(transport(tcp) port(514));
};

destination d_local {
   file(
         "/var/log/syslog-ng/logs.txt"
         owner("root")
         group("root")
         perm(0777)
    );
};

destination d_remote {
  file("/var/log/syslog-ng/logs_${HOST}");
};

log { source(s_local); destination(d_local); };
log { source(s_network); destination(d_remote); };

# Source additional configuration files (.conf extension only)
@include "/etc/syslog-ng/conf.d/*.conf"
EOT


systemctl restart syslog-ng

sudo systemctl start firewalld
sudo systemctl enable firewalld

sudo firewall-cmd --permanent --add-port=514/udp
sudo firewall-cmd --permanent --add-port=514/tcp
sudo firewall-cmd --reload
