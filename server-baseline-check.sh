#!/usr/bin/env bash
HOSTNAME=$(hostnamectl --static)
IPADDR=$(ip -4 -br a show eth0 | awk '{print $3}' | cut -d/ -f1)
GATEWAY=$(ip r show default | awk '{print $3}')
ROOT_USAGE=$(df -h / | awk 'NR==2 {print $5}')

echo "Your hostname is $HOSTNAME" 
echo -e "\nYour ip address is $IPADDR"
echo -e "\nYour gateway is $GATEWAY"
echo -e "\nRoot usage filesystem $ROOT_USAGE"
echo -e "\nStatus services"
systemctl is-active --quiet ssh
ssh_status=$?
systemctl is-active --quiet qemu-guest-agent
qemu_status=$?
if [[ $ssh_status -eq 0 && $qemu_status -eq 0 ]]; then
	STATUS="OK"
	EXIT_CODE=0
else
	STATUS="WARN"
	EXIT_CODE=1
fi

echo "status: $STATUS"
exit $EXIT_CODE
