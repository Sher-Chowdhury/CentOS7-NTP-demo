#!/usr/bin/env bash
# exit 0
set -ex

echo '##########################################################################'
echo '################# About to run ntp_server.sh script ######################'
echo '##########################################################################'

yum install -y ntp


cp /etc/ntp.conf /etc/ntp.conf-orig

sed -i 's/^server/#server/g' /etc/ntp.conf
echo 'server 127.127.1.0' >> /etc/ntp.conf


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