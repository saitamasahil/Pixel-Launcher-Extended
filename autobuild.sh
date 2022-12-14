#!/usr/bin/bash

# Check for the Distro Type

which "apt"

RESULT=$?
if [ $RESULT -eq 0 ]; then
  sudo apt-get install zip
fi

if [ $RESULT -eq 1 ]; then
  sudo pacman -S zip
fi

if ! command -v zip >/dev/null; then
  echo "Error: zip is not installed. Please install it manually and try again."
  exit 1
fi

# Check if the current directory has system folder and setup.sh to verify that current directory is valid
if [ ! -d "system" ] || [ ! -f "setup.sh" ]; then
  echo "Error: Current directory is not valid. Make sure that you are in the right directory and try again."
  exit 1
fi

# Create zip file
echo ">> Creating zip file"
echo "" # make the output look easier to read
zip -r PixelLauncherExtended.zip . -x .git/\* # Ignore .git folder because it's not needed for the module
echo "" # make the output look easier to read
echo ">> Done! You can find the zip file in the current directory - '$(pwd)/PixelLauncherExtended.zip'"