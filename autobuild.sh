#!/usr/bin/bash
# Setup script

# Install zip
apt-get install zip

# Create directory if it doesn't exist
mkdir -p "$HOME/Pixel-Launcher-Extended"

# Make sure the script has the correct permissions to access the directory
chmod a+rwx "$HOME/Pixel-Launcher-Extended"

# Create zip file
echo ">> Creating zip file"
zip -r PixelLauncherExtended.zip "$HOME/Pixel-Launcher-Extended"
echo ">> Done! You can find the zip file in the current directory - $(pwd)/PixelLauncherExtended.zip"
