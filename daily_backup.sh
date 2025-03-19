#!/bin/bash
# Automated Daily System Backup & Alerts Script

#Backup Configuration
SOURCE_DIR="/home"                     # Directory to back up
BACKUP_DIR="/var/backups"               # Backup storage location
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')  # Timestamp for the backup file
BACKUP_FILE="$BACKUP_DIR/home_backup_$TIMESTAMP.tar.gz"

#Logging & Alert Settings
LOG_FILE="/var/log/daily_backup.log"    # Log file path
RETENTION_DAYS=7                        # Number of days before old backups are deleted
EMAIL_ALERT="abdulrahman.yasser.elbanna@gmail.com"  # Email to receive failure alerts

#Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

#Rotate logs to prevent excessive file size
LOG_MAX_SIZE=1000000  # 1MB
if [ -f "$LOG_FILE" ] && [ $(stat -c%s "$LOG_FILE") -gt $LOG_MAX_SIZE ]; then
    mv "$LOG_FILE" "$LOG_FILE.old"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Log rotated" > "$LOG_FILE"
fi

#Start the backup process
echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting backup of $SOURCE_DIR" >> "$LOG_FILE"

if tar -czf "$BACKUP_FILE" "$SOURCE_DIR" 2>>"$LOG_FILE"; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup completed successfully: $BACKUP_FILE" >> "$LOG_FILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup failed!" >> "$LOG_FILE"

    # 🔔 Send an email alert on failure
    if command -v mail >/dev/null 2>&1; then
        echo "Backup of $SOURCE_DIR failed at $(date)" | mail -s "Backup Failure Alert" "$EMAIL_ALERT"
    else
        echo "Mail command not found! Unable to send failure alert." >> "$LOG_FILE"
    fi
fi

#Cleanup old backups to free up space
find "$BACKUP_DIR" -type f -name "home_backup_*.tar.gz" -mtime +$RETENTION_DAYS -exec rm {} \;
echo "$(date '+%Y-%m-%d %H:%M:%S') - Cleanup completed: Removed backups older than $RETENTION_DAYS days" >> "$LOG_FILE"

exit 0
