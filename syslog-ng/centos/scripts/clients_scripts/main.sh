#!/usr/bin/env bash

# ADD hostname - to be used below (no override - because of >>)
cat << 'EOT' >> /etc/hosts
192.168.11.11 syslog-server #This is the hostname given by vagrant networking
EOT

cat << 'EOT' > /etc/syslog-ng/syslog-ng.conf
@version: 3.5
@include "scl.conf"
#@include "`scl-root`/system/tty10.conf"

options {
     time-reap(30);
     mark-freq(10);
     keep-hostname(yes);
};

source s_local {
        system();
        internal();
};

destination d_remote {
       network("syslog-server" transport(udp) port(514));
       network("syslog-server" transport(tcp) port(514));
};

log { source(s_local);destination(d_remote); };

# Source additional configuration files (.conf extension only)
@include "/etc/syslog-ng/conf.d/*.conf"
EOT


systemctl restart syslog-ng