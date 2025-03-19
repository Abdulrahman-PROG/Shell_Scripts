#!/bin/bash
# Script to automate system updates

# Define the log file
LOG_FILE="/var/log/system_update.log"

# Add a timestamp to the log to mark the start of the update
echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting system update" >> "$LOG_FILE"

# Update package list and log output/errors
sudo apt update >> "$LOG_FILE" 2>&1

 # Upgrade installed packages automatically and log output/errors
sudo apt upgrade -y >> "$LOG_FILE" 2>&1

# Add a success message with timestamp
echo "$(date '+%Y-%m-%d %H:%M:%S') - System updated successfully" >> "$LOG_FILE"

# Add a separator line for readability
echo "---------------------------------------------------------------" >> "$LOG_FILE"