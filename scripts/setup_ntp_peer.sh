#!/usr/bin/env bash

set -ex

echo '##########################################################################'
echo '############### About to run ntp_peer.sh script ##################'
echo '##########################################################################'


yum install -y ntp


cp /etc/ntp.conf /etc/ntp.conf-orig

sed -i 's/^server/#server/g' /etc/ntp.conf
cat 'server 127.127.1.0' >> /etc/ntp.conf


systemctl restart ntpd 
systemctl enable ntpd 

firewall-cmd --permanent --add-service=ntp
systemctl restart firewalld.service

systemctl restart ntpd 
systemctl enable ntpd 


# check this has worked by running commands like:
# ntpq -p
# ntpstat

exit 0