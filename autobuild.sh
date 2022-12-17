#!/usr/bin/bash

# Check for the Distro Type

# Check if apt package manager is available
which "apt"
RESULT=$?
if [ $RESULT -eq 0 ]; then
  # Install zip package using apt-get
  sudo apt-get install zip
fi

# Check if yum package manager is available
which "yum"
RESULT=$?
if [ $RESULT -eq 0 ]; then
  # Install zip package using yum
  sudo yum install zip
fi

# Check if dnf package manager is available
which "dnf"
RESULT=$?
if [ $RESULT -eq 0 ]; then
  # Install zip package using dnf
  sudo dnf install zip
fi

# Check if pacman package manager is available
which "pacman"
RESULT=$?
if [ $RESULT -eq 0 ]; then
  # Install zip package using pacman
  sudo pacman -S zip
fi

# Check if zypper package manager is available
which "zypper"
RESULT=$?
if [ $RESULT -eq 0 ]; then
  # Install zip package using zypper
  sudo zypper install zip
fi

# Check if the current Linux distribution is Fedora
if [ -f /etc/fedora-release ]; then
  # Install zip package using dnf
  sudo dnf install zip
fi

# Check if zip is installed
if ! command -v zip >/dev/null; then
  echo "Error: zip is not installed. Please install it manually and try again."
  exit 1
fi

# Rename offline_setup.sh to setup.sh
mv offline_setup.sh setup.sh

# Check if the current directory has system folder and setup.sh to verify that current directory is valid
if [ ! -d "system" ] || [ ! -f "setup.sh" ]; then
  echo "Error: Current directory is not valid. Make sure that you are in the right directory and try again."
  exit 1
fi

# Read version from module.prop file
version=$(grep "version=" module.prop | cut -d "=" -f 2)

# Create zip file
echo ">> Creating zip file"
echo "" # make the output look easier to read
zip -r "Pixel Launcher Extended $version.zip" . -x .git/\* ThemedIcons/\* screenshots/\* autobuild.sh autobuild.bat banner.jpg banner2.jpg changelog.md codename.txt logo.png online_setup.sh README.md # Ignore specified files and folders because they are not needed for the module
echo "" # make the output look easier to read
echo ">> Done! You can find the zip file in the current directory - '$(pwd)/Pixel Launcher Extended $version.zip'"
