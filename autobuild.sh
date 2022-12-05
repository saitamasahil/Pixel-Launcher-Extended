#!/usr/bin/bash
# Setup script

# Install requirements
sudo apt-get install zip

# Make autobuild.sh executable
chmod +x autobuild.sh

# Give permission
sudo ./autobuild.sh

# Check if the Pixel-Launcher-Extended directory exists and contains files
if [ ! -d Pixel-Launcher-Extended ] || [ -z "$(ls -A Pixel-Launcher-Extended)" ]; then
    echo ">> Pixel-Launcher-Extended directory not found or is empty"
    exit
else
    # Make sure the script has the correct permissions to access the directory
    chmod u+rwx Pixel-Launcher-Extended

    # Create zip file
    echo ">> Creating zip file"
    zip -r PixelLauncherExtended.zip Pixel-Launcher-Extended
    echo ">> Done! You can find the zip file in the current directory - $(pwd)/PixelLauncherExtended.zip"
fi
