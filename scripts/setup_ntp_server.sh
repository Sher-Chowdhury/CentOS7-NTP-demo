#!/usr/bin/env bash

set -ex

echo '##########################################################################'
echo '################# About to run ntp_server.sh script ######################'
echo '##########################################################################'

yum install -y ntp


cp /etc/ntp.conf /etc/ntp.conf-orig
cp /etc/chrony.conf /etc/chrony.conf-orig

systemctl restart chronyd
systemctl enable chronyd

firewall-cmd --permanent --add-service=ntp
systemctl restart firewalld.service

exit 0