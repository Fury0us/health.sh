#!/bin/bash
main_menu() {
echo $'\e[1;32m'
echo -en '\n'
echo '--------------------------------------'
echo ""
figlet -f smshadow health.sh
echo '--------------------------------------'
echo $'\e[1;36m'
echo '------------'
echo 'By: fury0us'
echo '------------'
echo $'\e[0m'
PS3=('main: ') && echo $'\e[1;32m'
options=("CPU Usage" "Memory Usage" "Disk Usage" "Network Interfaces" "Running Processes" "System Uptime" "System Load Avg" "System Temp" "Error Logs" "System Logs" "System Status" "Active Users" "Open Ports" "Listening Services" "Firewall Rules" "DNS Config" "Installed Packages" "Kernel Version" "Exit")
COLUMNS=12
select o in "${options[@]}"; do
case $o in
"CPU Usage")
cpu_usage=$(top -bn2 | grep "Cpu(s)" | tail -n 1 | awk '{print $2 + $4}')
echo -en '\n'
echo "CPU USAGE: $cpu_usage%"
echo -en '\n'
sleep 2
main_menu
;;
"Memory Usage")
total_mem=$(free -m | grep Mem | awk '{print $2}')
used_mem=$(free -m | grep Mem | awk '{print $3}')
percentage=$(awk "BEGIN {printf \"%.2f\",$used_mem/$total_mem*100}")
echo -en '\n'
echo "Total Memory: $total_mem"
echo "Used Memory: $used_mem"
echo "Percent: $percentage"
echo -en '\n'
sleep 2
main_menu
;;
"Disk Usage")
disk_usage=$(df -h)
echo "Disk Usage: "
echo -en '\n'
echo "$disk_usage"
echo -en '\n'
sleep 2
main_menu
;;
"Network Interfaces")
interfaces=$(ifconfig)
echo "Network Interfaces: "
echo -en '\n'
echo "$interfaces"
echo -en '\n'
sleep 2
main_menu
;;
"Running Processes")
read -p $'\e[1;31mAll(1) or User(2)\e[0m' v
if [ "$v" == "1" ]; then
echo "All Processes: "
echo -en '\n'
ps aux
elif [ "$v" == "2" ]; then
ps aux | grep $USER
fi
echo -en '\n'
sleep 2
main_menu
;;
"System Uptime")
up_time=$(uptime | awk '{print $3 $4 }')
echo "Uptime: "
echo -en '\n'
echo "$up_time"
echo -en '\n'
sleep 2
main_menu
;;
"System Load Avg")
load_average=$(uptime | awk -F "average:" '{print $2}')
echo "Load Average: "
echo -en '\n'
echo "$load_average"
echo -en '\n'
sleep 2
main_menu
;;
"System Temp")
temps=$(sensors)
echo "System Temps: "
echo -en '\n'
echo "$temps"
echo -en '\n'
sleep 2
main_menu
;;
"Error Logs")
errors=$(dmesg | tail)
echo "Latest Error Logs: "
echo -en '\n'
echo "$errors"
echo -en '\n'
sleep 2
main_menu
;;
"System Logs")
latest_logs=$(sudo tail /var/log/syslog)
echo "Latest Logs: "
echo -en '\n'
echo "$latest_logs"
echo -en '\n'
sleep 2
main_menu
;;
"System Status")
sysstat=$(systemctl status)
echo "System Status: "
echo -en '\n'
echo "$sysstat"
echo -en '\n'
sleep 2
main_menu
;;
"Active Users")
actusr=$(sudo who)
echo "Active Users: "
echo -en '\n'
echo "$actusr"
echo -en '\n'
sleep 2
main_menu
;;
"Open Ports")
open_ports=$(ss -tuln)
echo "Open Ports: "
echo -en '\n'
echo "$open_ports"
echo -en '\n'
sleep 2
main_menu
;;
"Listening Services")
listeners=$(ss -tln | grep "Listen")
echo "Listening Services: "
echo -en '\n'
echo "$listeners"
echo -en '\n'
sleep 2
main_menu
;;
"Firewall Rules")
fwrules=$(sudo iptables -L)
echo "Firewall Rules: "
echo -en '\n'
echo "$fwrules"
echo -en '\n'
sleep 2
main_menu
;;
"DNS Config")
dnsconf=$(cat /etc/resolv.conf)
echo "DNS Config: "
echo -en '\n'
echo "$dnsconf"
echo -en '\n'
sleep 2
main_menu
;;
"Installed Packages")
instpack=$(dpkg --get-selections)
echo "Installed Packages: "
echo -en '\n'
echo "$instpack"
echo -en '\n'
sleep 2
main_menu
;;
"Kernel Version")
kernel=$(uname -r)
echo "Kernel: "
echo -en '\n'
echo "$kernel"
echo -en '\n'
sleep 2
main_menu
;;
"Exit")
exit
;;
esac
done
}
main_menu
