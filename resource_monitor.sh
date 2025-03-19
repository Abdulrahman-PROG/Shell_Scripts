#!/bin/bash

# Log file location (user-writable directory)
LOG_FILE="$HOME/resource_monitor.log"

# Function to log resource usage
log_resources() {
    echo "=== Resource Usage at $(date) ===" >> "$LOG_FILE"
    echo "CPU Usage:" >> "$LOG_FILE"
    top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}' >> "$LOG_FILE"
    echo "Memory Usage:" >> "$LOG_FILE"
    free -h | grep Mem >> "$LOG_FILE"
    echo "Disk Usage:" >> "$LOG_FILE"
    df -h >> "$LOG_FILE"
    echo "===============================" >> "$LOG_FILE"
}

# Main execution
if [ ! -f "$LOG_FILE" ]; then
    echo "Creating new log file: $LOG_FILE"
fi

echo "Logging resource usage..."
log_resources

if [ $? -eq 0 ]; then
    echo "Resource usage logged successfully to $LOG_FILE"
else
    echo "Failed to log resource usage!"
fi

#cat ~/resource_monitor.log