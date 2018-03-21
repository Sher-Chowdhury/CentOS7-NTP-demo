#!/usr/bin/env bash

set -ex

echo '##########################################################################'
echo '############### About to run ntp_peer.sh script ##################'
echo '##########################################################################'




firewall-cmd --add-service=smtp --permanent
systemctl restart firewalld.service


exit 0