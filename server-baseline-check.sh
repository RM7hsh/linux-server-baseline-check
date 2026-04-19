#!/usr/bin/env bash
set -euo pipefail

HOSTNAME=$(hostnamectl --static)
IPADDR=$(ip -4 -br a show eth0 | awk '{print $3}' | cut -d/ -f1)
GATEWAY=$(ip r show default | awk '{print $3}')
ROOT_USAGE=$(df -h / | awk 'NR==2 {print $5}')
SSH_STATE=$(systemctl is-active ssh || true)
QGA_STATE=$(systemctl is-active qemu-guest-agent || true)

echo "Your hostname is $HOSTNAME" 
echo -e "\nYour ip address is $IPADDR"
echo -e "\nYour gateway is $GATEWAY"
echo -e "\nRoot usage filesystem $ROOT_USAGE"
if [[ $SSH_STATE == "active" && $QGA_STATE == "active" ]]; then
	STATUS="OK"
	EXIT_CODE=0
else
	STATUS="WARN"
	EXIT_CODE=1
fi
echo -e "\nstatus services is $STATUS"
echo -e "\nSSH is $SSH_STATE"
echo -e "\nQemu-guest-agent is $QGA_STATE"
exit $EXIT_CODE
