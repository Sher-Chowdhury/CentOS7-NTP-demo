#!/usr/bin/env bash

set -ex

echo '##########################################################################'
echo '################# About to run ntp_server.sh script ######################'
echo '##########################################################################'


firewall-cmd --permanent --add-service=ntp
systemctl restart firewalld.service

exit 0