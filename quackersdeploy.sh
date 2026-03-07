#!/bin/bash

# Define variables for easy updates later
SOURCE_ZIP="quackers.zip"
TARGET_DIR="/var/www/html"

# 1. Check if the zip file actually exists before starting
if [ ! -f "$SOURCE_ZIP" ]; then
    echo "Error: $SOURCE_ZIP not found!"
    exit 1
fi

# 2. Unzip the file
# -q makes it quiet, -d specifies the extraction directory
echo "Unzipping $SOURCE_ZIP..."
unzip -q "$SOURCE_ZIP" -d ./temp_quackers

# 3. Move contents to the web directory
echo "Moving files to $TARGET_DIR..."
sudo mv ./temp_quackers/* "$TARGET_DIR/"

# 4. Set Permissions
# Set ownership to the web server user (usually www-data on Ubuntu/Debian)
echo "Setting permissions..."
sudo chown -R www-data:www-data "$TARGET_DIR"

# Set directory permissions to 755 (rwxr-xr-x) and files to 644 (rw-r--r--)
sudo find "$TARGET_DIR" -type d -exec chmod 755 {} \;
sudo find "$TARGET_DIR" -type f -exec chmod 644 {} \;

# 5. Start/Restart Apache2
echo "🚀 Starting Apache2..."
sudo systemctl restart apache2

# 6. Verify Service Status
if systemctl is-active --quiet apache2; then
    echo "✅ Apache2 is running!"
else
    echo "⚠️ Warning: Apache2 failed to start. Check 'systemctl status apache2'"
fi

# 5. Cleanup
rm -rf ./temp_quackers
echo "Done! Quackers is live."
