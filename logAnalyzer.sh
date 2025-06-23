#!/bin/bash

output="log_summary.txt"
> "$output"

auth_log="/var/log/auth.log"
sys_log="/var/log/syslog"

if [ ! -f "$auth_log" ]; then
  echo "Auth log not found!" >> "$output"
  exit 1
fi

if [ ! -f "$sys_log" ]; then
  echo "Syslog not found!" >> "$output"
  exit 1
fi

echo "---- Failed Login Attempts ----" >> "$output"
grep "Failed password" "$auth_log" | awk '{print $(NF)}' | sort | uniq -c | sort -nr >> "$output"
echo "" >> "$output"

echo "---- Top Active IPs ----" >> "$output"
grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' "$auth_log" | sort | uniq -c | sort -nr | head -10 >> "$output"
echo "" >> "$output"

echo "---- Common Error Messages ----" >> "$output"
grep -i "error" "$sys_log" | awk -F ':' '{print $NF}' | sed 's/^ *//' | sort | uniq -c | sort -nr | head -10 >> "$output"
echo "" >> "$output"

echo "Log analysis completed. Report saved to $output"
