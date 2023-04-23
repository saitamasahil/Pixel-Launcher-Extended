#!/usr/bin/bash

# Define some color variables
GREEN='\033[1m\033[32m'
ORANGE='\033[1m\033[38;5;214m'
PURPLE='\033[1m\033[38;5;140m'
NC='\033[0m' # No Color

# This script adds the PLE function definition to the appropriate shell configuration file
# Get the name of the current shell
shell=$(basename "$SHELL")

# Check if the configuration file exists
if [ -f ~/."$shell"rc ]; then
  # Check if the PLE function is already defined in the file
  if grep -q "PLE ()" ~/."$shell"rc; then
    # Delete the existing PLE function
    sed -i '/PLE ()/,$d' ~/."$shell"rc
  fi

  # Get the current working directory of the script
  pwd=$(pwd)

  # Append the function definition to the end of the file
  cat >>~/."$shell"rc <<EOF
PLE () {
  # Go to the saved directory
  cd "$pwd"

  # Check if autobuild.sh exists
  if [ -f autobuild.sh ]; then
    git pull
    chmod +x autobuild.sh
    ./autobuild.sh
  else
    echo "PLE Builder is not available in your system"
  fi
}
EOF

else
  # Print an error message
  echo "."$shell"rc file not found"
fi

# Define temp directories making function
make_temp_dir() {
  mkdir system/product/etc/permissions/temp
  mkdir system/product/overlay/temp
  mkdir system/product/priv-app/NexusLauncherRelease/temp
  mkdir system/product/priv-app/temp
  mkdir system/system_ext/etc/permissions/temp
  mkdir system/system_ext/priv-app/WallpaperPickerGoogleRelease/temp
  mkdir temp
}

# Define recover files & folders function
recover_ple() {
  # Move temp files & folders back to original location
  for file in system/product/priv-app/NexusLauncherRelease/temp/*; do
    mv -f "$file" "system/product/priv-app/NexusLauncherRelease/$(basename $file)" 2>/dev/null || true
  done
  for file in system/product/etc/permissions/temp/*; do
    mv -f "$file" "system/product/etc/permissions/$(basename $file)" 2>/dev/null || true
  done
  for file in temp/*; do
    mv -f "$file" "$(basename $file)" 2>/dev/null || true
  done
  for file in system/product/overlay/temp/*; do
    mv -f "$file" "system/product/overlay/$(basename $file)" 2>/dev/null || true
  done
  for file in system/system_ext/priv-app/WallpaperPickerGoogleRelease/temp/*; do
    mv -f "$file" "system/system_ext/priv-app/WallpaperPickerGoogleRelease/$(basename $file)" 2>/dev/null || true
  done
  for file in system/system_ext/etc/permissions/temp/*; do
    mv -f "$file" "system/system_ext/etc/permissions/$(basename $file)" 2>/dev/null || true
  done
  mv "system/product/priv-app/temp/PixelLauncherDT2S" "system/product/priv-app/$folder" 2>/dev/null || true
  mv "system/product/priv-app/temp/PixelLauncherMods" "system/product/priv-app/$folder" 2>/dev/null || true
  mv "system/product/overlay/temp/PixelLauncherModsOverlay" "system/product/overlay/$folder" 2>/dev/null || true
  mv "system/product/overlay/temp/IconShape" "system/product/overlay/$folder" 2>/dev/null || true
  mv "system/product/priv-app/temp/ExtendedSettings" "system/product/priv-app/$folder" 2>/dev/null || true
  mv "system/product/priv-app/temp/IconShapeChanger" "system/product/priv-app/$folder" 2>/dev/null || true

  # Delete temp folders
  rm -rf system/product/priv-app/NexusLauncherRelease/temp
  rm -rf system/product/priv-app/temp
  rm -rf system/product/etc/permissions/temp
  rm -rf system/product/overlay/temp
  rm -rf system/system_ext/priv-app/WallpaperPickerGoogleRelease/temp
  rm -rf temp
  rm -rf system/system_ext/etc/permissions/temp

  # Delete temp files
  if [ -f "setup.sh" ]; then
    rm setup.sh
  fi

  if [ -f "system.prop" ]; then
    rm system.prop
  fi
}

# check if temp folders exist from an unexpected previous session
if [ -d "system/product/priv-app/NexusLauncherRelease/temp" ] || [ -d "system/product/priv-app/temp" ] || [ -d "system/product/etc/permissions/temp" ] || [ -d "system/product/overlay/temp" ] || [ -d "system/system_ext/priv-app/WallpaperPickerGoogleRelease/temp" ] || [ -d "temp" ] || [ -d "system/system_ext/etc/permissions/temp" ] || [ -f "setup.sh" ] || [ -f "system.prop" ]; then
  echo -e "${PURPLE}>> Recovering files & folders from a previous unexpected session.${NC}"
  recover_ple
  echo "Successfully recovered."
  echo "Run PLE Builder again."
  exit 1
fi

# Check for the Distro Type & Install necessary packages

PACKAGE_MANAGERS=("pkg" "apt" "yum" "dnf" "pacman" "zypper")
PACKAGES=("zip")

# Define a function to check if a package is installed
check_package() {
  if command -v "$1" >/dev/null; then
    return 0
  else
    return 1
  fi
}

# Loop through the packages and check if they are installed
for PKG in "${PACKAGES[@]}"; do
  check_package "$PKG"
  # If not installed, add it to a list of packages to install
  if [ $? -ne 0 ]; then
    TO_INSTALL+=("$PKG")
  fi
done

# If there are no packages to install then just print all packages are already installed
if [ ${#TO_INSTALL[@]} -eq 0 ]; then
  echo -e "${GREEN}zip is already installed.${NC}"
  echo -e "${GREEN}Starting PLE Builder.${NC}"
fi

# Loop through the package managers and find the one that is available
for PM in "${PACKAGE_MANAGERS[@]}"; do
  if command -v "$PM" >/dev/null; then
    # Use the appropriate command to install the packages
    case "$PM" in
    "pkg") pkg install "${TO_INSTALL[@]}" ;;
    "apt") sudo apt-get install "${TO_INSTALL[@]}" ;;
    "yum") sudo yum install "${TO_INSTALL[@]}" ;;
    "dnf") sudo dnf install "${TO_INSTALL[@]}" ;;
    "pacman") sudo pacman -S --needed "${TO_INSTALL[@]}" ;;
    "zypper") sudo zypper install "${TO_INSTALL[@]}" ;;
    esac
    break
  fi
done

# If the distribution is Fedora, use dnf to install the packages
if [ -f /etc/fedora-release ]; then
  sudo dnf install "${TO_INSTALL[@]}"
fi

# Install latest version of figlet, As most distros come with very old version
case "$PM" in
"pkg") pkg install figlet ;;
"apt") sudo apt-get install figlet ;;
"yum") sudo yum figlet ;;
"dnf") sudo dnf figlet ;;
"pacman") sudo pacman -S --needed figlet ;;
"zypper") sudo zypper install figlet ;;
esac

# If the distribution is Fedora, use dnf to install figlet
if [ -f /etc/fedora-release ]; then
  sudo dnf install figlet
fi

# Display "PLE Builder" in bigger fonts
clear
echo -e "${PURPLE}$(figlet "PLE Builder")${NC}"

# Check if zip is installed
if ! command -v zip >/dev/null; then
  echo "Error: zip is not installed. Please install it manually and try again."
  exit 1
fi

# Read version from module.prop file
version=$(grep "version=" module.prop | cut -d "=" -f 2)

# ask user if they want to build online installer or offline installer
echo -e "${ORANGE}Select Desired Installer:${NC}"
echo "1. Offline Installer"
echo "2. Online Installer"
echo "3. Customize Installer"
read -p "Enter your choice: " choice

if [ $choice -eq 1 ]; then

  # Delete already exists Offline Installer
  rm -rf Pixel\ Launcher\ Extended\ Offline*

  # Copy & Rename offline_setup.sh to setup.sh
  cp offline_setup.sh setup.sh

  # Check if the current directory has system folder and setup.sh to verify that current directory is valid
  if [ ! -d "system" ] || [ ! -f "setup.sh" ]; then
    echo "Error: Current directory is not valid. Make sure that you are in the right directory and try again."
    exit 1
  fi

  # Create zip file
  echo -e "${GREEN}>> Creating Magisk Module${NC}"
  echo ""                                                                                                                                                                                                                                                                                       # make the output look easier to read
  zip -r -q "Pixel Launcher Extended Offline Installer $version.zip" . -x .git/\* Modifications/\* screenshots/\* autobuild.sh autobuild.ps1 banner.jpg banner2.jpg changelog.md codename.txt logo.png online_setup.sh offline_setup.sh customize_setup.sh README.md Pixel\ Launcher\ Extended* # Ignore specified files and folders because they are not needed for the module
  echo ""                                                                                                                                                                                                                                                                                       # make the output look easier to read
  echo "Done! You can find the magisk module zip file in the current directory - '$(pwd)/Pixel Launcher Extended Offline Installer $version.zip'"
  # Delete temp file
  if [ -f "setup.sh" ]; then
    rm setup.sh
  fi
  echo -e "${PURPLE}You can run PLE Builder again by typing 'PLE' in your terminal.${NC}"
  echo -e "${PURPLE}Internet connection is required while running it. So, It could download latest updates if available.${NC}"

elif [ $choice -eq 2 ]; then

  # Delete already exists Online Installer
  rm -rf Pixel\ Launcher\ Extended\ Online*

  # Copy & Rename online_setup.sh to setup.sh
  cp online_setup.sh setup.sh

  # Check if the current directory has system folder and setup.sh to verify that current directory is valid
  if [ ! -d "system" ] || [ ! -f "setup.sh" ]; then
    echo "Error: Current directory is not valid. Make sure that you are in the right directory and try again."
    exit 1
  fi

  # Create zip file
  echo -e "${GREEN}>> Creating Magisk Module${NC}"
  echo ""                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             # make the output look easier to read
  zip -r -q "Pixel Launcher Extended Online Installer $version.zip" . -x .git/\* Modifications/\* screenshots/\* autobuild.sh autobuild.ps1 banner.jpg banner2.jpg changelog.md codename.txt logo.png offline_setup.sh customize_setup.sh online_setup.sh README.md system/product/priv-app/NexusLauncherRelease/*\* system/product/priv-app/PixelLauncherMods/PixelLauncherMods.apk system/product/overlay/ThemedIconsOverlay/*\* system/system_ext/priv-app/WallpaperPickerGoogleRelease/* system/product/overlay/TeamFiles* system/product/priv-app/ExtendedSettings/ExtendedSettings.apk system/product/priv-app/IconShapeChanger/IconShapeChanger.apk Pixel\ Launcher\ Extended* # Ignore specified files and folders because they are not needed for the module
  echo ""                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             # make the output look easier to read
  echo "Done! You can find the magisk module zip file in the current directory - '$(pwd)/Pixel Launcher Extended Online Installer $version.zip'"
  # Delete temp file
  if [ -f "setup.sh" ]; then
    rm setup.sh
  fi
  echo -e "${PURPLE}You can run PLE Builder again by typing 'PLE' in your terminal.${NC}"
  echo -e "${PURPLE}Internet connection is required while running it. So, It could download latest updates if available.${NC}"

elif [ $choice -eq 3 ]; then

  # Delete already exists Customize Installer
  rm -rf Pixel\ Launcher\ Extended\ Customize*

  # Copy & Rename customize_setup.sh to setup.sh
  cp customize_setup.sh setup.sh

  # Check if the current directory has system folder and setup.sh to verify that current directory is valid
  if [ ! -d "system" ] || [ ! -f "setup.sh" ]; then
    echo "Error: Current directory is not valid. Make sure that you are in the right directory and try again."
    exit 1
  fi

  # Dividers
  divider="------------------------------------------"

  while true; do
    echo $divider
    echo -e "${ORANGE}Which Android Version are you using?${NC}"
    echo "1. Android 13(November Security Patch or Below)"
    echo "2. Android 13 QPR(December Security Patch or Above)"
    echo "3. Android 13 QPR2(March Security Patch or Above)"
    echo $divider
    read -p "Enter your choice: " choice

    if [ $choice -eq 1 ]; then
      make_temp_dir
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease21.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease22.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
      mv -f "system/system_ext/priv-app/WallpaperPickerGoogleRelease/WallpaperPickerGoogleRelease.apk" "system/system_ext/priv-app/WallpaperPickerGoogleRelease/temp/$file"
      break

    elif [ $choice -eq 2 ]; then
      make_temp_dir
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease20.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease22.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
      mv -f "system/system_ext/priv-app/WallpaperPickerGoogleRelease/WallpaperPickerGoogleRelease.apk" "system/system_ext/priv-app/WallpaperPickerGoogleRelease/temp/$file"
      break

    elif [ $choice -eq 3 ]; then
      make_temp_dir
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease20.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease21.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
      mv -f "system/system_ext/priv-app/WallpaperPickerGoogleRelease/WallpaperPickerGoogleReleaseOld.apk" "system/system_ext/priv-app/WallpaperPickerGoogleRelease/temp/$file"
      break

    else
      echo -e "${PURPLE}Invalid choice. Please try again.${NC}"
    fi
  done

  while true; do
    echo $divider
    echo -e "${ORANGE}Do you wanna add 'Material You Greetings In At A Glance' & install Extended Settings app?${NC}"
    echo "1. Yes"
    echo "2. No"
    echo $divider
    read -p "Enter your choice: " choice

    if [ $choice -eq 1 ]; then
      while true; do
        mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
        mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
        mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
        echo $divider
        echo -e "${ORANGE}Do you want to install Glance Greetings Style 1 or Glance Greetings Style 2?${NC}"
        echo -e "${PURPLE}Example Example Example Example Example${NC}"
        echo "Example Of Glance Greetings Style 1-"
        echo "Line 1 - Material You Greetings,"
        echo "Line 2 - Day & Date"
        echo "Line 3 - Weather Information"
        echo -e "${PURPLE}Example Example Example Example Example${NC}"
        echo "Example Of Glance Greetings Style 2-"
        echo "Line 1 - Material You Greetings, Day & Date"
        echo "Line 2 - Weather Information"
        echo ""
        echo "1. Glance Greetings Style 1"
        echo "2. Glance Greetings Style 2"
        echo $divider
        read -p "Enter your choice: " choice

        if [ $choice -eq 1 ]; then
          mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease20.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
          mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease21.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
          mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease22.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
          break

        elif [ $choice -eq 2 ]; then
          mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
          mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
          mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
          break

        else
          echo -e "${PURPLE}Invalid choice. Please try again.${NC}"
        fi
      done
      break

    elif [ $choice -eq 2 ]; then
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease20.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease21.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease22.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
      mv -f "system/product/overlay/TeamFiles_Pill_Dark.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_Pill_Dark2.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_Pill_Empty.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_Pill_Empty2.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_Pill_Light.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_Pill_Light2.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_Pill_Light_Accent.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_Pill_Light_Accent2.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_UserChip.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_UserCL.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_UserLockscreen.apk" "system/product/overlay/temp/$file"
      mv "system/product/priv-app/ExtendedSettings" "system/product/priv-app/temp/$folder"
      mv -f "system/product/etc/permissions/privapp-permissions-com.domain.liranazuz5.extendedsettings.xml" "system/product/etc/permissions/temp/$file"
      break

    else
      echo -e "${PURPLE}Invalid choice. Please try again.${NC}"
    fi
  done

  while true; do
    echo $divider
    echo -e "${ORANGE}Do you want to enable DT2S in Launcher?${NC}"
    echo -e "${PURPLE}DT2S Means - Double Tap To Sleep Feature${NC}"
    echo -e "${PURPLE}Make sure you have LSPosed Installed in your rom${NC}"
    echo -e "${PURPLE}Without LSPosed it won't work${NC}"
    echo -e "${PURPLE}Read Documentation on GitHub to know more about activating it${NC}"
    echo "1. Yes"
    echo "2. No"
    echo $divider
    read -p "Enter your choice: " choice

    if [ $choice -eq 1 ]; then
      :
      break

    elif [ $choice -eq 2 ]; then
      mv "system/product/priv-app/PixelLauncherDT2S" "system/product/priv-app/temp/$folder"
      mv -f "system/product/etc/permissions/privapp-permissions-com.uragiristereo.pldt2s.xml" "system/product/etc/permissions/temp/$file"
      break

    else
      echo -e "${PURPLE}Invalid choice. Please try again.${NC}"
    fi
  done

  while true; do
    echo $divider
    echo -e "${ORANGE}Do you wanna install Pixel Launcher Mods app?${NC}"
    echo -e "${PURPLE}It's by Developer KieronQuinn${NC}"
    echo -e "${PURPLE}You will be able to apply Icon Packs using it${NC}"
    echo -e "${PURPLE}It will also enable some more functionality to pixel launcher${NC}"
    echo "1. Yes"
    echo "2. No"
    echo $divider
    read -p "Enter your choice: " choice

    if [ $choice -eq 1 ]; then
      :
      break

    elif [ $choice -eq 2 ]; then
      mv "system/product/priv-app/PixelLauncherMods" "system/product/priv-app/temp/$folder"
      mv -f "system/product/etc/permissions/privapp-permissions-com.kieronquinn.app.pixellaunchermods.xml" "system/product/etc/permissions/temp/$file"
      mv "system/product/overlay/PixelLauncherModsOverlay" "system/product/overlay/temp/$folder"
      break

    else
      echo -e "${PURPLE}Invalid choice. Please try again.${NC}"
    fi
  done

  while true; do
    echo $divider
    echo -e "${ORANGE}Do you want to install Icon Shape Changer app?${NC}"
    echo "1. Yes"
    echo "2. No"
    echo $divider
    read -p "Enter your choice: " choice

    if [ $choice -eq 1 ]; then
      :
      break

    elif [ $choice -eq 2 ]; then
      mv -f "system/product/overlay/TeamFiles_we_Cloudy.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_we_Cylinder.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_we_Flower.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_we_Hexagon.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_we_Leaf.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_we_Mallow.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_we_Pebble.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_we_RoundedHexagon.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_we_RoundedRectangle.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_we_Square.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_we_Squircle.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_we_Stretched.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_we_TaperedRectangular.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_we_Teardrops.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_we_Vessel.apk" "system/product/overlay/temp/$file"
      mv -f "system/product/overlay/TeamFiles_we_Samsung.apk" "system/product/overlay/temp/$file"
      mv "system/product/priv-app/IconShapeChanger" "system/product/priv-app/temp/$folder"
      mv -f "system/product/etc/permissions/privapp-permissions-com.saitama.iconshape.xml" "system/product/etc/permissions/temp/$file"
      break

    else
      echo -e "${PURPLE}Invalid choice. Please try again.${NC}"
    fi
  done

  while true; do
    echo $divider
    echo -e "${ORANGE}Do you want to enable Developer Opions in launcher?${NC}"
    echo -e "${PURPLE}WARNING: Your rom may cause Bootloop Issue if you enable this feature${NC}"
    echo -e "${PURPLE}It also may expose root in some banking apps in some custom roms${NC}"
    echo "1. Yes"
    echo "2. No"
    echo $divider
    read -p "Enter your choice: " choice

    if [ $choice -eq 1 ]; then
      cp system2.prop system.prop
      mv -f "system1.prop" "temp/$file"
      mv -f "system2.prop" "temp/$file"
      break

    elif [ $choice -eq 2 ]; then
      cp system1.prop system.prop
      mv -f "system1.prop" "temp/$file"
      mv -f "system2.prop" "temp/$file"
      mv -f "sepolicy.rule" "temp/$file"
      break

    else
      echo -e "${PURPLE}Invalid choice. Please try again.${NC}"
    fi
  done

  while true; do
    echo $divider
    echo -e "${ORANGE}Which Wallpaper & style app you want to install?${NC}"
    echo -e "${PURPLE}NOTE: AOSP Wallpaper Picker is still in beta${NC}"
    echo -e "${PURPLE}It comes with some features like font changer${NC}"
    echo -e "${PURPLE}It depends upon your rom that how many fonts are available in your rom${NC}"
    echo "1. Pixel Wallpaper Picker"
    echo "2. AOSP Wallpaper Picker"
    echo $divider
    read -p "Enter your choice: " choice

    if [ $choice -eq 1 ]; then
      mv -f "system/system_ext/priv-app/WallpaperPickerGoogleRelease/AOSPPicker.apk" "system/system_ext/priv-app/WallpaperPickerGoogleRelease/temp/$file"
      mv -f "system/system_ext/etc/permissions/AOSP_Picker.xml" "system/system_ext/etc/permissions/temp/$file"
      break

    elif [ $choice -eq 2 ]; then
      mv -f "system/system_ext/priv-app/WallpaperPickerGoogleRelease/WallpaperPickerGoogleRelease.apk" "system/system_ext/priv-app/WallpaperPickerGoogleRelease/temp/$file" 2>/dev/null || true
      mv -f "system/system_ext/priv-app/WallpaperPickerGoogleRelease/WallpaperPickerGoogleReleaseOld.apk" "system/system_ext/priv-app/WallpaperPickerGoogleRelease/temp/$file" 2>/dev/null || true
      mv -f "system/system_ext/etc/permissions/privapp-permissions-com.google.android.apps.wallpaper.xml" "system/system_ext/etc/permissions/temp/$file"
      break

    else
      echo -e "${PURPLE}Invalid choice. Please try again.${NC}"
    fi
  done

  # Create zip file
  echo -e "${GREEN}>> Creating Magisk Module${NC}"
  echo ""                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      # make the output look easier to read
  zip -r -q "Pixel Launcher Extended Customize Installer $version.zip" . -x .git/\* Modifications/\* screenshots/\* autobuild.sh autobuild.ps1 banner.jpg banner2.jpg changelog.md codename.txt logo.png online_setup.sh offline_setup.sh customize_setup.sh README.md Pixel\ Launcher\ Extended* system/product/priv-app/NexusLauncherRelease/temp/\* system/product/priv-app/temp/\* system/product/etc/permissions/temp/\* system/system_ext/etc/permissions/temp/\* system/product/overlay/temp/\* temp/\* system/system_ext/priv-app/WallpaperPickerGoogleRelease/temp/\* # Ignore specified files and folders because they are not needed for the module
  echo ""                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      # make the output look easier to read
  echo "Done! You can find the magisk module zip file in the current directory - '$(pwd)/Pixel Launcher Extended Customize Installer $version.zip'"
  echo -e "${PURPLE}You can run PLE Builder again by typing 'PLE' in your terminal.${NC}"
  echo -e "${PURPLE}Internet connection is required while running it. So, It could download latest updates if available.${NC}"

  # Move temp files & folders back to original location
  recover_ple

else
  # if user enters invalid choice
  echo -e "${PURPLE}Invalid choice. Run PLE Builder again.${NC}"
  exit 1
fi
