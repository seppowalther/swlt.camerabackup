#!/bin/bash
  
# Path to status log file
STATUS_FILE="./status_file.log"

# List of scripts to be executed
SCRIPTS=(
    "awsscript.sh"
#    Add more scripts if needed
)

# Clear status file prior to daily sync
echo "### Script execution protocol - $(date) ###" > "$STATUS_FILE"
echo "---------------------------------------------" >> "$STATUS_FILE"

# Execute scripts
for SCRIPT in "${SCRIPTS[@]}"; do
    echo "Starting $SCRIPT - $(date)" >> "$STATUS_FILE"
    echo "---------------------------------------------" >> "$STATUS_FILE"

    # Execute script and write logs in status file
    bash "$SCRIPT" >> "$STATUS_FILE" 2>&1

    # Report success or error
    if [ $? -eq 0 ]; then
        echo "[$SCRIPT] SUCCESS script execution completed - $(date)" >> "$STATUS_FILE"
    else
        echo "[$SCRIPT] ERROR during script execution - $(date)" >> "$STATUS_FILE"
    fi
    echo "---------------------------------------------" >> "$STATUS_FILE"
done

echo "### All scripts executed - $(date) ###" >> "$STATUS_FILE"
