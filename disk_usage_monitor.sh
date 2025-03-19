#!/bin/bash

# Set the threshold percentage for disk usage (e.g., 80%)
THRESHOLD=80

# Function to check disk usage
check_disk_usage() {
    echo "Checking disk usage..."
    df -h | awk 'NR>1 {print $1, $5}' | while read partition usage; do
        # Remove the '%' symbol from the usage value
        usage=${usage%\%}
        
        # Check if usage exceeds the threshold
        if [ "$usage" -ge "$THRESHOLD" ]; then
            echo "WARNING: Partition $partition is ${usage}% full!"
        else
            echo "Partition $partition is ${usage}% full (OK)."
        fi
    done
}

# Main execution
echo "=== Disk Usage Monitoring Script ==="
check_disk_usage
echo "=== Monitoring Completed ==="