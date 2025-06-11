#!/bin/bash


printf "Starting backup process...\n"

set -x

# Load configuration
CONFIG_FILE="/usr/share/periodic-backup/periodic-backup.conf"

if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    printf "Configuration file not found: %s\n" "$CONFIG_FILE"
    exit 1
fi

if [ -z "$SOURCE_DIR" ] || [ -z "$DESTINATION_DIR" ]; then
    printf "SOURCE_DIR or DESTINATION_DIR not set in configuration file.\n"
    exit 1
fi

mkdir -p "$DESTINATION_DIR"

# Backup the directory
rsync -a -v "$SOURCE_DIR/" "$DESTINATION_DIR/"

printf "Backup completed successfully.\n"
