#!/bin/bash
# Script to compress and move log files older than 1 hour

BACKUP_DIR="$HOME/log_backup"
LOG_DIR="/var/log"

echo "Starting script at $(date)"
echo "Backup directory: $BACKUP_DIR"
echo "Log directory: $LOG_DIR"

if ! command -v gzip >/dev/null 2>&1; then
    echo "gzip not found, installing..."
    sudo apt install -y gzip
fi

# Create the backup directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Creating backup directory: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
fi

# Compress log files older than 30 minutes (for testing)
echo "Looking for .log files older than 30 minutes in $LOG_DIR..."
find "$LOG_DIR" -type f -name "*.log" -mmin +30 -exec echo "Compressing {}" \; -exec gzip {} \;

# Move compressed files to backup directory
echo "Moving compressed .log.gz files to $BACKUP_DIR..."
find "$LOG_DIR" -type f -name "*.log.gz" -exec echo "Moving {} to $BACKUP_DIR" \; -exec mv {} "$BACKUP_DIR" \;

echo "Script finished at $(date)"