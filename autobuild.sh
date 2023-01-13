#!/usr/bin/bash

# Check for the Distro Type

# Check if pkg package manager is available
which "pkg"
RESULT=$?
if [ $RESULT -eq 0 ]; then
  # Install zip package using pkg
  pkg install zip
fi

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

# Define an array of colors
colors=("\033[38;5;196m" "\033[38;5;202m" "\033[38;5;226m" "\033[38;5;82m" "\033[38;5;21m" "\033[38;5;55m")

# Display "Pixel Launcher Extended" in each rainbow color
for color in "${colors[@]}"; do
  echo -e "${color}Pixel Launcher Extended By TeamFiles"
done

# Reset the color to the default
echo -e "\033[0m"

# Check if zip is installed
if ! command -v zip >/dev/null; then
  echo "Error: zip is not installed. Please install it manually and try again."
  exit 1
fi

# Read version from module.prop file
version=$(grep "version=" module.prop | cut -d "=" -f 2)

# ask user if they want to build online installer or offline installer
echo "Do you want to build offline installer or online installer?"
echo "1. Offline Installer"
echo "2. Online Installer"
echo "3. Customize Installer"
read -p "Enter your choice: " choice

if [ $choice -eq 1 ]; then

  # Copy & Rename offline_setup.sh to setup.sh
  cp offline_setup.sh setup.sh

  # Check if the current directory has system folder and setup.sh to verify that current directory is valid
  if [ ! -d "system" ] || [ ! -f "setup.sh" ]; then
    echo "Error: Current directory is not valid. Make sure that you are in the right directory and try again."
    exit 1
  fi

  # Create zip file
  echo ">> Creating zip file"
  echo ""                                                                                                                                                                                                                                                                                                      # make the output look easier to read
  zip -r -q "Pixel Launcher Extended Offline Installer $version.zip" . -x .git/\* Modifications/\* ThemedIcons/\* screenshots/\* autobuild.sh autobuild.bat banner.jpg banner2.jpg changelog.md codename.txt logo.png online_setup.sh offline_setup.sh customize_setup.sh README.md Pixel\ Launcher\ Extended* # Ignore specified files and folders because they are not needed for the module
  echo ""                                                                                                                                                                                                                                                                                                      # make the output look easier to read
  echo ">> Done! You can find the module zip file in the current directory - '$(pwd)/Pixel Launcher Extended Offline Installer $version.zip'"

elif [ $choice -eq 2 ]; then

  # Copy & Rename online_setup.sh to setup.sh
  cp online_setup.sh setup.sh

  # Check if the current directory has system folder and setup.sh to verify that current directory is valid
  if [ ! -d "system" ] || [ ! -f "setup.sh" ]; then
    echo "Error: Current directory is not valid. Make sure that you are in the right directory and try again."
    exit 1
  fi

  # Create zip file
  echo ">> Creating zip file"
  echo ""                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             # make the output look easier to read
  zip -r -q "Pixel Launcher Extended Online Installer $version.zip" . -x .git/\* Modifications/\* ThemedIcons/\* screenshots/\* autobuild.sh autobuild.bat banner.jpg banner2.jpg changelog.md codename.txt logo.png offline_setup.sh customize_setup.sh online_setup.sh README.md system/product/priv-app/NexusLauncherRelease/*\* system/product/priv-app/PixelLauncherMods/PixelLauncherMods.apk system/product/overlay/ThemedIconsOverlay/*\* system/system_ext/priv-app/WallpaperPickerGoogleRelease/WallpaperPickerGoogleRelease.apk Pixel\ Launcher\ Extended* # Ignore specified files and folders because they are not needed for the module
  echo ""                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             # make the output look easier to read
  echo ">> Done! You can find the module zip file in the current directory - '$(pwd)/Pixel Launcher Extended Online Installer $version.zip'"

elif [ $choice -eq 3 ]; then

  # Copy & Rename customize_setup.sh to setup.sh
  cp customize_setup.sh setup.sh

  # Check if the current directory has system folder and setup.sh to verify that current directory is valid
  if [ ! -d "system" ] || [ ! -f "setup.sh" ]; then
    echo "Error: Current directory is not valid. Make sure that you are in the right directory and try again."
    exit 1
  fi

  echo "Which Android Version are you using?"
  echo "1. Android 13(November SP or Below)"
  echo "2. Android 13 QPR(December SP or Above)"
  read -p "Enter your choice: " choice

  if [ $choice -eq 1 ]; then
    mkdir system/product/priv-app/NexusLauncherRelease/temp
    mkdir system/product/overlay/ThemedIconsOverlay/temp
    mkdir system/product/priv-app/temp
    mkdir system/product/etc/permissions/temp
    mkdir system/product/overlay/temp
    mkdir system/product/overlay/IconShape/temp
    mkdir system/temp
    mkdir temp
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"

  elif [ $choice -eq 2 ]; then
    mkdir system/product/priv-app/NexusLauncherRelease/temp
    mkdir system/product/overlay/ThemedIconsOverlay/temp
    mkdir system/product/priv-app/temp
    mkdir system/product/etc/permissions/temp
    mkdir system/product/overlay/temp
    mkdir system/product/overlay/IconShape/temp
    mkdir system/temp
    mkdir temp
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
  fi

  echo "Do you want to install Extra Grids in Launcher?"
  echo "Extra Grids will enable more Grids Options in App Grid"
  echo "1. Yes"
  echo "2. No"
  read -p "Enter your choice: " choice

  if [ $choice -eq 1 ]; then
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true

  elif [ $choice -eq 2 ]; then
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
  fi

  echo "Do you wanna add 'Material You Greetings In At A Glance' & Some Tweaks In QSB?"
  echo "1. Yes"
  echo "2. No"
  read -p "Enter your choice: " choice

  if [ $choice -eq 1 ]; then
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    echo "Do you want to install Glance Greetings Style 1 or Glance Greetings Style 2?"
    echo "You can check preview of these two styles in Pixel Launcher Extended post on GitHub Repo"
    echo "1. Glance Greetings Style 1"
    echo "2. Glance Greetings Style 2"
    read -p "Enter your choice: " choice

    if [ $choice -eq 1 ]; then
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true

    elif [ $choice -eq 2 ]; then
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    fi

  elif [ $choice -eq 2 ]; then
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12z.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
  fi

  echo "Do you want to enable DT2S in Launcher?"
  echo "DT2S Means - Double Tap To Sleep Feature"
  echo "Make sure you have LSPosed Installed in your rom"
  echo "Without LSPosed it won't work"
  echo "Read Documentation on GitHub to know more about activating it"
  echo "1. Yes"
  echo "2. No"
  read -p "Enter your choice: " choice

  if [ $choice -eq 1 ]; then
    :

  elif [ $choice -eq 2 ]; then
    mv "system/product/priv-app/PixelLauncherDT2S" "system/product/priv-app/temp/$folder"
    mv -f "system/product/etc/permissions/privapp-permissions-com.uragiristereo.pldt2s.xml" "system/product/etc/permissions/temp/$file"
  fi

  echo "Which of the following themed icons you want to install?"
  echo "This feature is currently in beta due to Android 13 restrictions"
  echo "1. Lawnicons"
  echo "2. TeamFiles Icons(Recommended)"
  echo "3. RK Icons"
  echo "4. DG Icons"
  echo "5. ACons"
  echo "6. Cayicons"
  echo "7. None Of The Above"
  read -p "Enter your choice: " choice

  if [ $choice -eq 1 ]; then
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayRKIcons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayTeamFilesIcons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayDGIcons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayACons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayCayicons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"

  elif [ $choice -eq 2 ]; then
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayRKIcons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayLawnicons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayDGIcons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayACons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayCayicons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"

  elif [ $choice -eq 3 ]; then
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayLawnicons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayTeamFilesIcons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayDGIcons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayACons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayCayicons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"

  elif [ $choice -eq 4 ]; then
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayLawnicons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayTeamFilesIcons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayRKIcons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayACons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayCayicons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"

  elif [ $choice -eq 5 ]; then
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayLawnicons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayTeamFilesIcons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayRKIcons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayDGIcons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayCayicons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"

  elif [ $choice -eq 6 ]; then
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayLawnicons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayTeamFilesIcons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayRKIcons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayDGIcons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"
    mv -f "system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayACons.apk" "system/product/overlay/ThemedIconsOverlay/temp/$file"

  elif [ $choice -eq 7 ]; then
    mv "system/product/overlay/ThemedIconsOverlay" "system/product/overlay/temp/$folder"
  fi

  echo "Do you wanna install Pixel Launcher Mods App?"
  echo "It's by Developer KieronQuinn"
  echo "You will be able to apply Icon Packs using it"
  echo "It will also enable some more functionality to pixel launcher"
  echo "1. Yes"
  echo "2. No"
  read -p "Enter your choice: " choice

  if [ $choice -eq 1 ]; then
    :

  elif [ $choice -eq 2 ]; then
    mv "system/product/priv-app/PixelLauncherMods" "system/product/priv-app/temp/$folder"
    mv -f "system/product/etc/permissions/privapp-permissions-com.kieronquinn.app.pixellaunchermods.xml" "system/product/etc/permissions/temp/$file"
    mv "system/product/overlay/PixelLauncherModsOverlay" "system/product/overlay/temp/$folder"
  fi

  echo "Which of the following icon shape you want to use with launcher?"
  echo "1. Circle(Default)"
  echo "2. Cloudy"
  echo "3. Cylinder"
  echo "4. Flower"
  echo "5. Heart"
  echo "6. Hexagon"
  echo "7. Leaf"
  echo "8. Mallow"
  echo "9. Pebble"
  echo "10. Rounded Hexagon"
  echo "11. Rounded Rectangle"
  echo "12. Square"
  echo "13. Squircle"
  echo "14. Stretched"
  echo "15. Tapered Rectangular"
  echo "16. Teardrops"
  echo "17. Vessel"
  echo "18. Samsung(One UI Like)"
  read -p "Enter your choice: " choice

  if [ $choice -eq 1 ]; then
    mv "system/product/overlay/IconShape" "system/product/overlay/temp/$folder"

  elif [ $choice -eq 2 ]; then
    mv -f "system/product/overlay/IconShape/Cylinder.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Flower.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Heart.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Hexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Leaf.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Mallow.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Pebble.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedHexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedRectangle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Square.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Squircle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Stretched.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/TaperedRectangular.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Teardrops.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Vessel.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Samsung.apk" "system/product/overlay/IconShape/temp/$file"

  elif [ $choice -eq 3 ]; then
    mv -f "system/product/overlay/IconShape/Cloudy.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Flower.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Heart.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Hexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Leaf.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Mallow.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Pebble.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedHexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedRectangle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Square.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Squircle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Stretched.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/TaperedRectangular.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Teardrops.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Vessel.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Samsung.apk" "system/product/overlay/IconShape/temp/$file"

  elif [ $choice -eq 4 ]; then
    mv -f "system/product/overlay/IconShape/Cloudy.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Cylinder.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Heart.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Hexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Leaf.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Mallow.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Pebble.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedHexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedRectangle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Square.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Squircle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Stretched.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/TaperedRectangular.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Teardrops.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Vessel.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Samsung.apk" "system/product/overlay/IconShape/temp/$file"

  elif [ $choice -eq 5 ]; then
    mv -f "system/product/overlay/IconShape/Cloudy.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Cylinder.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Flower.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Hexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Leaf.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Mallow.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Pebble.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedHexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedRectangle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Square.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Squircle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Stretched.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/TaperedRectangular.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Teardrops.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Vessel.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Samsung.apk" "system/product/overlay/IconShape/temp/$file"

  elif [ $choice -eq 6 ]; then
    mv -f "system/product/overlay/IconShape/Cloudy.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Cylinder.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Flower.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Heart.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Leaf.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Mallow.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Pebble.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedHexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedRectangle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Square.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Squircle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Stretched.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/TaperedRectangular.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Teardrops.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Vessel.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Samsung.apk" "system/product/overlay/IconShape/temp/$file"

  elif [ $choice -eq 7 ]; then
    mv -f "system/product/overlay/IconShape/Cloudy.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Cylinder.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Flower.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Heart.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Hexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Mallow.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Pebble.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedHexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedRectangle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Square.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Squircle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Stretched.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/TaperedRectangular.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Teardrops.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Vessel.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Samsung.apk" "system/product/overlay/IconShape/temp/$file"

  elif [ $choice -eq 8 ]; then
    mv -f "system/product/overlay/IconShape/Cloudy.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Cylinder.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Flower.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Heart.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Hexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Leaf.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Pebble.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedHexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedRectangle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Square.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Squircle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Stretched.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/TaperedRectangular.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Teardrops.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Vessel.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Samsung.apk" "system/product/overlay/IconShape/temp/$file"

  elif [ $choice -eq 9 ]; then
    mv -f "system/product/overlay/IconShape/Cloudy.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Cylinder.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Flower.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Heart.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Hexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Leaf.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Mallow.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedHexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedRectangle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Square.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Squircle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Stretched.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/TaperedRectangular.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Teardrops.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Vessel.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Samsung.apk" "system/product/overlay/IconShape/temp/$file"

  elif [ $choice -eq 10 ]; then
    mv -f "system/product/overlay/IconShape/Cloudy.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Cylinder.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Flower.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Heart.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Hexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Leaf.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Mallow.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Pebble.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedRectangle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Square.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Squircle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Stretched.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/TaperedRectangular.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Teardrops.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Vessel.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Samsung.apk" "system/product/overlay/IconShape/temp/$file"

  elif [ $choice -eq 11 ]; then
    mv -f "system/product/overlay/IconShape/Cloudy.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Cylinder.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Flower.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Heart.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Hexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Leaf.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Mallow.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Pebble.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedHexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Square.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Squircle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Stretched.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/TaperedRectangular.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Teardrops.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Vessel.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Samsung.apk" "system/product/overlay/IconShape/temp/$file"

  elif [ $choice -eq 12 ]; then
    mv -f "system/product/overlay/IconShape/Cloudy.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Cylinder.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Flower.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Heart.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Hexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Leaf.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Mallow.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Pebble.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedHexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedRectangle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Squircle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Stretched.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/TaperedRectangular.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Teardrops.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Vessel.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Samsung.apk" "system/product/overlay/IconShape/temp/$file"

  elif [ $choice -eq 13 ]; then
    mv -f "system/product/overlay/IconShape/Cloudy.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Cylinder.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Flower.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Heart.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Hexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Leaf.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Mallow.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Pebble.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedHexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedRectangle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Square.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Stretched.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/TaperedRectangular.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Teardrops.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Vessel.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Samsung.apk" "system/product/overlay/IconShape/temp/$file"

  elif [ $choice -eq 14 ]; then
    mv -f "system/product/overlay/IconShape/Cloudy.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Cylinder.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Flower.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Heart.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Hexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Leaf.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Mallow.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Pebble.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedHexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedRectangle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Square.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Squircle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/TaperedRectangular.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Teardrops.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Vessel.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Samsung.apk" "system/product/overlay/IconShape/temp/$file"

  elif [ $choice -eq 15 ]; then
    mv -f "system/product/overlay/IconShape/Cloudy.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Cylinder.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Flower.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Heart.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Hexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Leaf.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Mallow.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Pebble.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedHexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedRectangle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Square.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Squircle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Stretched.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Teardrops.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Vessel.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Samsung.apk" "system/product/overlay/IconShape/temp/$file"

  elif [ $choice -eq 16 ]; then
    mv -f "system/product/overlay/IconShape/Cloudy.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Cylinder.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Flower.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Heart.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Hexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Leaf.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Mallow.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Pebble.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedHexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedRectangle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Square.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Squircle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Stretched.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/TaperedRectangular.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Vessel.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Samsung.apk" "system/product/overlay/IconShape/temp/$file"

  elif [ $choice -eq 17 ]; then
    mv -f "system/product/overlay/IconShape/Cloudy.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Cylinder.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Flower.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Heart.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Hexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Leaf.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Mallow.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Pebble.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedHexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedRectangle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Square.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Squircle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Stretched.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/TaperedRectangular.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Teardrops.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Samsung.apk" "system/product/overlay/IconShape/temp/$file"

  elif [ $choice -eq 18 ]; then
    mv -f "system/product/overlay/IconShape/Cloudy.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Cylinder.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Flower.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Heart.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Hexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Leaf.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Mallow.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Pebble.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedHexagon.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/RoundedRectangle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Square.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Squircle.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Stretched.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/TaperedRectangular.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Teardrops.apk" "system/product/overlay/IconShape/temp/$file"
    mv -f "system/product/overlay/IconShape/Vessel.apk" "system/product/overlay/IconShape/temp/$file"
  fi

  echo "Do you want to enable push notification service?"
  echo "We will send notifications for quick support"
  echo "or if there is any new update available"
  echo "This feature uses very little internet"
  echo "Check ReadMe on GitHub to know more about it"
  echo "1. Yes"
  echo "2. No"
  read -p "Enter your choice: " choice

  if [ $choice -eq 1 ]; then
    :

  elif [ $choice -eq 2 ]; then
    mv "system/lib64" "system/temp/$folder"
    mv -f "cns" "temp/$file"
    mv "system/product/priv-app/OnePunchNotifier" "system/product/priv-app/temp/$folder"
    mv -f "system/product/etc/permissions/privapp-permissions-com.looper.notifier.xml" "system/product/etc/permissions/temp/$file"
  fi

  echo "Do you want to enable Developer Opions in launcher?"
  echo "1. Yes"
  echo "2. No"
  read -p "Enter your choice: " choice

  if [ $choice -eq 1 ]; then
    cp system2.prop system.prop
    mv -f "system1.prop" "temp/$file"
    mv -f "system2.prop" "temp/$file"

  elif [ $choice -eq 2 ]; then
    cp system1.prop system.prop
    mv -f "system1.prop" "temp/$file"
    mv -f "system2.prop" "temp/$file"
    mv -f "sepolicy.rule" "temp/$file"
  fi

  # Create zip file
  echo ">> Creating zip file"
  echo ""                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     # make the output look easier to read
  zip -r -q "Pixel Launcher Extended Customize Installer $version.zip" . -x .git/\* Modifications/\* ThemedIcons/\* screenshots/\* autobuild.sh autobuild.bat banner.jpg banner2.jpg changelog.md codename.txt logo.png online_setup.sh offline_setup.sh customize_setup.sh README.md Pixel\ Launcher\ Extended* system/product/priv-app/NexusLauncherRelease/temp/\* system/product/priv-app/temp/\* system/product/etc/permissions/temp/\* system/product/overlay/ThemedIconsOverlay/temp/\* system/product/overlay/temp/\* system/product/overlay/IconShape/temp/\* system/temp/\* temp/\* # Ignore specified files and folders because they are not needed for the module
  echo ""                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     # make the output look easier to read
  echo ">> Done! You can find the module zip file in the current directory - '$(pwd)/Pixel Launcher Extended Customize Installer $version.zip'"

  # Move temp files & folders back to original location
  for file in system/product/priv-app/NexusLauncherRelease/temp/*; do
    mv -f "$file" "system/product/priv-app/NexusLauncherRelease/$(basename $file)"
  done
  for file in system/product/etc/permissions/temp/*; do
    mv -f "$file" "system/product/etc/permissions/$(basename $file)"
  done
  for file in system/product/overlay/ThemedIconsOverlay/temp/*; do
    mv -f "$file" "system/product/overlay/ThemedIconsOverlay/$(basename $file)" 2>/dev/null || true
  done
  for file in system/product/overlay/IconShape/temp/*; do
    mv -f "$file" "system/product/overlay/IconShape/$(basename $file)" 2>/dev/null || true
  done
  for file in temp/*; do
    mv -f "$file" "$(basename $file)"
  done
  mv "system/product/priv-app/temp/PixelLauncherDT2S" "system/product/priv-app/$folder"
  mv "system/product/overlay/temp/ThemedIconsOverlay" "system/product/overlay/$folder" 2>/dev/null || true
  mv "system/product/priv-app/temp/PixelLauncherMods" "system/product/priv-app/$folder"
  mv "system/product/overlay/temp/PixelLauncherModsOverlay" "system/product/overlay/$folder"
  mv "system/product/overlay/temp/IconShape" "system/product/overlay/$folder" 2>/dev/null || true
  mv "system/temp/lib64" "system/$folder"
  mv "system/product/priv-app/temp/OnePunchNotifier" "system/product/priv-app/$folder"

  # Delete temp folders
  rm -rf system/product/priv-app/NexusLauncherRelease/temp
  rm -rf system/product/overlay/ThemedIconsOverlay/temp
  rm -rf system/product/priv-app/temp
  rm -rf system/product/etc/permissions/temp
  rm -rf system/product/overlay/temp
  rm -rf system/product/overlay/IconShape/temp
  rm -rf system/temp
  rm -rf temp

else
  # if user enters invalid choice
  echo "Error: Invalid choice. Please try again."
  exit 1
fi

if [ -f "setup.sh" ]; then
  rm setup.sh
fi

if [ -f "system.prop" ]; then
  rm system.prop
fi
