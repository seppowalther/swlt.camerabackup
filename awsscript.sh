#!/bin/bash

# Path to source dir
SOURCE_DIR="/home/upload/"

# Destination dir (Bucket/Remote)
RCLONE_REMOTE="AWS:cctv-remote/"

# Date components for folder structure
YEAR=$(date +'%Y')
MONTH=$(date +'%m')
DAY=$(date +'%d')

# Create folder structure
UPLOAD_DIR="$YEAR/$MONTH/$DAY"
LOCAL_ZIP_DIR="/tmp/$UPLOAD_DIR"

# Create local destination path if it doesn't exist
mkdir -p "$LOCAL_ZIP_DIR"

# Name of the ZIP file (with current date and time for unique names)
ZIP_FILE="$LOCAL_ZIP_DIR/backup_$(date +'%Y-%m-%d_%H-%M-%S').zip"

# 1. Compress the directory into a ZIP file
echo "Creating ZIP file: $ZIP_FILE"
zip -r "$ZIP_FILE" "$SOURCE_DIR" --exclude ".*"

# Check if the ZIP file was created successfully
if [ $? -ne 0 ]; then
    echo "Fehler beim Erstellen der ZIP-Datei. Abbruch."
    exit 1
fi

# 2. Upload ZIP file
REMOTE_PATH="$RCLONE_REMOTE$UPLOAD_DIR/"
echo "Uploading ZIP file to: $REMOTE_PATH"
rclone copy "$ZIP_FILE" "$REMOTE_PATH"

# Check if the upload was successful
if [ $? -eq 0 ]; then
    echo "Upload successful: $ZIP_FILE"

    # 3.  3. Delete local ZIP file
    echo "Deleting local ZIP file: $ZIP_FILE"
    rm -f "$ZIP_FILE"
else
    echo "Error uploading ZIP file."
    exit 1
fi

# 4. Clear source directory
echo "Deleting contents of source directory: $SOURCE_DIR"
rm -rf "$SOURCE_DIR"/*

echo "Operation completed."
