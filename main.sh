#!/bin/bash

# server-stats.sh - A script to analyze basic server performance statistics
# Created: April 20, 2025

echo "==================================================="
echo "          SERVER PERFORMANCE STATISTICS            "
echo "==================================================="
echo ""

# Get current date and time
echo "Report generated on: $(date)"
echo ""

# Get hostname and kernel information
echo "Hostname: $(hostname)"
echo "Kernel: $(uname -r)"
echo ""

# CPU USAGE
echo "==================================================="
echo "CPU USAGE"
echo "==================================================="
echo ""

# Get total CPU usage percentage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | awk '{printf "%.2f%%", $0}')
echo "Total CPU Usage: $cpu_usage"
echo ""

# MEMORY USAGE
echo "==================================================="
echo "MEMORY USAGE"
echo "==================================================="
echo ""

# Get memory usage statistics
total_mem=$(free -m | grep "Mem:" | awk '{print $2}')
used_mem=$(free -m | grep "Mem:" | awk '{print $3}')
free_mem=$(free -m | grep "Mem:" | awk '{print $4}')
mem_percentage=$(awk "BEGIN {printf \"%.2f\", $used_mem/$total_mem*100}")

echo "Total Memory: $total_mem MB"
echo "Used Memory: $used_mem MB"
echo "Free Memory: $free_mem MB"
echo "Memory Usage: $mem_percentage%"
echo ""

# DISK USAGE
echo "==================================================="
echo "DISK USAGE"
echo "==================================================="
echo ""

# Get disk usage statistics
echo "Filesystem      Size  Used  Avail  Use%  Mounted on"
df -h | grep -v "tmpfs\|devtmpfs" | grep "^/dev"
echo ""

# TOP PROCESSES BY CPU USAGE
echo "==================================================="
echo "TOP 5 PROCESSES BY CPU USAGE"
echo "==================================================="
echo ""

echo "USER       PID  %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND"
ps aux --sort=-%cpu | head -6 | tail -5
echo ""

# TOP PROCESSES BY MEMORY USAGE
echo "==================================================="
echo "TOP 5 PROCESSES BY MEMORY USAGE"
echo "==================================================="
echo ""

echo "USER       PID  %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND"
ps aux --sort=-%mem | head -6 | tail -5
echo ""

echo "==================================================="
echo "          END OF PERFORMANCE REPORT                "
echo "==================================================="