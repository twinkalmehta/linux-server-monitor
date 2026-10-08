
#!/bin/bash

echo "============================="
echo "      SERVER MONITOR"
echo "============================="
echo

HOSTNAME=$(hostname)

CPU_USAGE=$(top -bn1 | grep "Cpu" | awk '{print 100 - $8}')

MEMORY_USAGE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')

DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

PROCESS_COUNT=$(ps aux --no-heading | wc -l)

UPTIME=$(uptime -p)

echo "Hostname:           $HOSTNAME"
echo "CPU Usage:          ${CPU_USAGE}%"
echo "Memory Usage:       ${MEMORY_USAGE}%"
echo "Disk Usage:         ${DISK_USAGE}%"
echo "Running Processes:  $PROCESS_COUNT"
echo "Uptime:             $UPTIME"

if [ "$CPU_USAGE" -gt 80 ] || [ "$MEMORY_USAGE" -gt 80 ] || [ "$DISK_USAGE" -gt 80 ]; then
    STATUS="WARNING"
else
    STATUS="HEALTHY"
fi

echo
echo "Status: $STATUS"
