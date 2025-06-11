#!/bin/bash
set -e

# 1. Create package structure
PKG=pb_1.0.0
WORKDIR=$(pwd)/$PKG

# Clean up any previous build
rm -rf "$WORKDIR"

# 2. Create necessary directories
mkdir -p "$WORKDIR/DEBIAN"
mkdir -p "$WORKDIR/usr/local/bin"
mkdir -p "$WORKDIR/usr/share/periodic-backup"
mkdir -p "$WORKDIR/etc/systemd/system"

# 3. Copy files
cp backup.sh "$WORKDIR/usr/local/bin/backup.sh"
cp periodic-backup.service "$WORKDIR/etc/systemd/system/periodic-backup.service"
cp periodic-backup.timer "$WORKDIR/etc/systemd/system/periodic-backup.timer"
cp periodic-backup.conf "$WORKDIR/usr/share/periodic-backup/periodic-backup.conf"
cp -r DEBIAN "$WORKDIR/"

# 4. Set permissions
chmod 755 "$WORKDIR/usr/local/bin/backup.sh"
chmod 644 "$WORKDIR/etc/systemd/system/periodic-backup.service"
chmod 644 "$WORKDIR/etc/systemd/system/periodic-backup.timer"
chmod 644 "$WORKDIR/usr/share/periodic-backup/periodic-backup.conf"

# 5. Build the package
dpkg-deb --build "$WORKDIR"

echo "DEB package created: $WORKDIR.deb"
