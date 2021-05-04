#!/bin/bash
echo "/dev/cdrom    /media    iso9660    defaults    0 0" >> /etc/fstab
mount -a
mkdir /etc/yum.repos.d/bak
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak
cat <<EOF>> /etc/yum.repos.d/dvd.repo
[dvdrepo]
name=dvd
baseurl=file:///media
gpgcheck=0
EOF
yum -y install vim bash-completion git psmisc httpd-tools python3-pip

