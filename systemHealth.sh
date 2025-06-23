#!/bin/bash

LOG_FILE="/var/log/sys_health.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

CPU_THRESHOLD=80
RAM_THRESHOLD=80
DISK_THRESHOLD=80

echo "=== System Health Check @ $TIMESTAMP ===" >> $LOG_FILE

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_USAGE_INT=${CPU_USAGE%.*}
echo "CPU Usage: $CPU_USAGE%" >> $LOG_FILE

MEM=$(free | grep Mem)
USED_RAM=$(echo "$MEM" | awk '{print $3/$2 * 100.0}')
USED_RAM_INT=${USED_RAM%.*}
echo "RAM Usage: $USED_RAM%" >> $LOG_FILE

DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
echo "Disk Usage (/): $DISK_USAGE%" >> $LOG_FILE

LOAD=$(uptime | awk -F'load average:' '{ print $2 }')
echo "Load Average: $LOAD" >> $LOG_FILE

echo "--- Alerts ---" >> $LOG_FILE

if [ "$CPU_USAGE_INT" -gt "$CPU_THRESHOLD" ]; then
    echo "High CPU Usage: $CPU_USAGE%" >> $LOG_FILE
fi

if [ "$USED_RAM_INT" -gt "$RAM_THRESHOLD" ]; then
    echo "High RAM Usage: $USED_RAM%" >> $LOG_FILE
fi

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    echo "High Disk Usage: $DISK_USAGE%" >> $LOG_FILE
fi

echo "" >> $LOG_FILE
