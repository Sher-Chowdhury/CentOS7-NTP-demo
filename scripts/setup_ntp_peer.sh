#!/usr/bin/env bash

set -ex

echo '##########################################################################'
echo '############### About to run ntp_peer.sh script ##################'
echo '##########################################################################'

yum install -y ntp


cp /etc/ntp.conf /etc/ntp.conf-orig
cp /etc/chrony.conf /etc/chrony.conf-orig



systemctl restart chronyd
systemctl enable chronyd


firewall-cmd --add-service=smtp --permanent
systemctl restart firewalld.service


exit 0