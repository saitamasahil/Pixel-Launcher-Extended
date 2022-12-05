#!/usr/bin/bash
# Setup script

# Install zip if it is not already installed
if ! command -v zip >/dev/null; then
  echo "Error: zip is not installed. Please install it manually and try again."
  exit 1
fi

# Create directory if it doesn't exist
mkdir -p "$HOME/Pixel-Launcher-Extended"

# Make sure the script has the correct permissions to access the directory
chmod a+rwx "$HOME/Pixel-Launcher-Extended"

# Change to the /tmp directory
cd /tmp

# Create zip file
echo ">> Creating zip file"
zip -r PixelLauncherExtended.zip "$HOME/Pixel-Launcher-Extended"
echo ">> Done! You can find the zip file in the /tmp directory - /tmp/PixelLauncherExtended.zip"
