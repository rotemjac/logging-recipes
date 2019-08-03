#!/usr/bin/env bash

#Uncomment - Just to save time in development
#yum update

sudo yum install -y epel-release
sudo yum install -y syslog-ng syslog-ng-libdbi

systemctl stop rsyslog
systemctl disable rsyslog

#yum install -y wget

##On RHEL Only (no need for Centos)
##subscription-manager repos --enable rhel-7-server-optional-rpms

#wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#rpm -Uvh epel-release-latest-7.noarch.rpm

#cd /etc/yum.repos.d/
#wget https://copr.fedorainfracloud.org/coprs/czanik/syslog-ng321/repo/epel-7/czanik-syslog-ng321-epel-7.repo
#yum install syslog-ng

systemctl enable syslog-ng
systemctl start syslog-ng




