#!/usr/bin/bash

######## FUNCTIONS ##########
# Error function
throw_error() {
  echo -e "\e[1;91mEncountered an error!:\n$1\e[;0m"
  exit 1
}
# This func below finds array index
##### USAGE: find_arr_index <Pattern> <Pattern to mat
find_arr_index() {
  # The base pattern
  local PATTERN="${1}"
  # The pattern to match against
  local VAR=(${@:2})
  # Check if Both Variables are empty
  if [[ -z "$PATTERN" ]]; then
    return
  elif [[ -z "${VAR[@]}" ]]; then
    return
  fi
  ## End - Check ##
  for i in ${!VAR[@]}; do
    if [ "${VAR[i]}" == "$PATTERN" ]; then
      echo "$i"
      return
    fi
  done
}
# This function below restores excluded files when using the customized zip option
restore_content_ple() {
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

  # Remove two files
  if [ -f "setup.sh" ]; then
    rm setup.sh
  fi

  if [ -f "system.prop" ]; then
    rm system.prop
  fi
}
# Make a function that only gets triggered on exit
clean_exit() {
  if [ "$CUSTOMIZED_INSTALLER" = "true" ]; then
    restore_content_ple
  fi
}
###################
############ Main ##############
# Invoke trap command
trap clean_exit EXIT
# Check for the Distro Type & Install necessary packages

PACKAGE_MANAGERS=("pkg" "apt" "yum" "dnf" "pacman" "zypper")
PACKAGES=("zip" "figlet")
for PM in "${PACKAGE_MANAGERS[@]}"; do
  if [[ "$(command -v "$PM")" ]] || [[ "$(which "$PM")" ]]; then
    case "$PM" in
    "pkg")
      pkg install "${PACKAGES[@]}" || throw_error "Failed to install required packages: ${PACKAGES[@]} ; Using $PM"
      break
      ;;
    "apt")
      sudo apt-get install "${PACKAGES[@]}" || throw_error "Failed to install required packages: ${PACKAGES[@]} ; Using $PM"
      break
      ;;
    "yum")
      sudo yum install "${PACKAGES[@]}" || throw_error "Failed to install required packages: ${PACKAGES[@]} ; Using $PM"
      break
      ;;
    "dnf")
      sudo dnf install "${PACKAGES[@]}" || throw_error "Failed to install required packages: ${PACKAGES[@]} ; Using $PM"
      break
      ;;
    "pacman")
      sudo pacman -S "${PACKAGES[@]}" || throw_error "Failed to install required packages: ${PACKAGES[@]} ; Using $PM"
      break
      ;;
    "zypper")
      sudo zypper install "${PACKAGES[@]}" || throw_error "Failed to install required packages: ${PACKAGES[@]} ; Using $PM"
      break
      ;;
    esac
  elif [ "$(find_arr_index "$PM" ${PACKAGE_MANAGERS[@]})" -eq "${#PACKAGE_MANAGERS[@]}" ]; then
    throw_error "There are no available package managers to install required packages: ${PACKAGES[@]}"
  fi
done
# Display "PLE Builder" in bigger fonts
figlet "PLE Builder"

# Check if zip is installed
if [ ! "$(command -v zip)" ] || [ ! "$(which zip)" ]; then
  throw_error "Zip is not installed. Please install it manually and try again."
fi

# Read version from module.prop file
version=$(grep "version=" module.prop | cut -d "=" -f 2)
# ask user if they want to build online installer or offline installer
echo -e "\033[38;5;208mDo you want to build Offline Installer, Online Installer or Customize Installer?\033[0m
1. Offline Installer
2. Online Installer
3. Customize Installer"
read -ep "Enter your choice: " choice
###### Case statement 1 - START
case $choice in
1)
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
  echo ">> Creating Magisk Module"
  echo ""                                                                                                                                                                                                                                                                                       # make the output look easier to read
  zip -r -q "Pixel Launcher Extended Offline Installer $version.zip" . -x .git/\* Modifications/\* screenshots/\* autobuild.sh autobuild.ps1 banner.jpg banner2.jpg changelog.md codename.txt logo.png online_setup.sh offline_setup.sh customize_setup.sh README.md Pixel\ Launcher\ Extended* # Ignore specified files and folders because they are not needed for the module
  echo ""                                                                                                                                                                                                                                                                                       # make the output look easier to read
  echo ">> Done! You can find the module zip file in the current directory - '$(pwd)/Pixel Launcher Extended Offline Installer $version.zip'"
  ;;
2)
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
  echo ">> Creating Magisk Module"
  echo ""                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             # make the output look easier to read
  zip -r -q "Pixel Launcher Extended Online Installer $version.zip" . -x .git/\* Modifications/\* screenshots/\* autobuild.sh autobuild.ps1 banner.jpg banner2.jpg changelog.md codename.txt logo.png offline_setup.sh customize_setup.sh online_setup.sh README.md system/product/priv-app/NexusLauncherRelease/*\* system/product/priv-app/PixelLauncherMods/PixelLauncherMods.apk system/product/overlay/ThemedIconsOverlay/*\* system/system_ext/priv-app/WallpaperPickerGoogleRelease/* system/product/overlay/TeamFiles* system/product/priv-app/ExtendedSettings/ExtendedSettings.apk system/product/priv-app/IconShapeChanger/IconShapeChanger.apk Pixel\ Launcher\ Extended* # Ignore specified files and folders because they are not needed for the module
  echo ""                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             # make the output look easier to read
  echo ">> Done! You can find the module zip file in the current directory - '$(pwd)/Pixel Launcher Extended Online Installer $version.zip'"
  ;;
3)
  # Set customized installee variable to true since 3rd option
  CUSTOMIZED_INSTALLER="true"
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
  echo -e "$divider
\033[38;5;208mWhich Android Version are you using?\033[0m
1. Android 13(November Security Patch or Below)
2. Android 13 QPR(December Security Patch or Above)
3. Android 13 QPR2(March Security Patch or Above)
$divider"
  read -ep "Enter your choice: " choice
  ####### Case statement 2 - START
  case $choice in
  1)
    mkdir system/product/priv-app/NexusLauncherRelease/temp
    mkdir system/product/priv-app/temp
    mkdir system/product/etc/permissions/temp
    mkdir system/product/overlay/temp
    mkdir system/system_ext/priv-app/WallpaperPickerGoogleRelease/temp
    mkdir temp
    mkdir system/system_ext/etc/permissions/temp
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease21.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease22.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    ;;
  2)
    mkdir system/product/priv-app/NexusLauncherRelease/temp
    mkdir system/product/priv-app/temp
    mkdir system/product/etc/permissions/temp
    mkdir system/product/overlay/temp
    mkdir system/system_ext/priv-app/WallpaperPickerGoogleRelease/temp
    mkdir temp
    mkdir system/system_ext/etc/permissions/temp
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease20.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease22.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    ;;
  3)
    mkdir system/product/priv-app/NexusLauncherRelease/temp
    mkdir system/product/priv-app/temp
    mkdir system/product/etc/permissions/temp
    mkdir system/product/overlay/temp
    mkdir system/system_ext/priv-app/WallpaperPickerGoogleRelease/temp
    mkdir temp
    mkdir system/system_ext/etc/permissions/temp
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease20.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease21.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file"
    ;;
  *)
    throw_error "Invalid choice."
    ;;
  esac
  ######### Case statement 2 - END
  echo -e "$divider
\033[38;5;208mDo you wanna add 'Material You Greetings In At A Glance' & install Extended Settings app?\033[0m
1. Yes
2. No
$divider"
  # Ask user if they want to add MD3 Style
  read -ep "Enter your choice: " choice
  ######## Case statement 3 - START
  case $choice in
  1)
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
    echo -e "$divider
\033[38;5;208mDo you want to install Glance Greetings Style 1 or Glance Greetings Style 2?\033[0m
\033[38;5;2mExample Example Example Example Example\033[0m
Example Of Glance Greetings Style 1-
Line 1 - Material You Greetings,
Line 2 - Day & Date
Line 3 - Weather Information
\033[38;5;2mExample Example Example Example Example\033[0m
Example Of Glance Greetings Style 2-
Line 1 - Material You Greetings, Day & Date
Line 2 - Weather Information

1. Glance Greetings Style 1
2. Glance Greetings Style 2
$divider"
    ##### Ask for choice
    read -ep "Enter your choice: " choice
    ###### Case statement (NESTED-1) --- START
    case $choice in
    1)
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease20.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease21.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease22.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
      ;;
    2)
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
      mv -f "system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk" "system/product/priv-app/NexusLauncherRelease/temp/$file" 2>/dev/null || true
      ;;
    *)
      throw_error "Invalid choice."
      ;;
    esac
    ###### Case statement (NESTED-1) --- END
    ;;
  ###########
  2)
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
    ;;
  *)
    throw_error "Invalid choice."
    ;;
  esac
  ###### Case statement 3 - END
  echo -e "$divider
\033[38;5;208mDo you want to enable DT2S in Launcher?\033[0m
\033[38;5;208mDT2S Means - Double Tap To Sleep Feature\033[0m
\033[38;5;208mMake sure you have LSPosed Installed in your rom\033[0m
\033[38;5;208mWithout LSPosed it won't work\033[0m
\033[38;5;208mRead Documentation on GitHub to know more about activating it\033[0m
1. Yes
2. No
$divider"
  read -ep "Enter your choice: " choice
  ####### Case statement 4 - START
  case $choice in
  1)
    # Execute null command
    :
    ;;
  2)
    mv "system/product/priv-app/PixelLauncherDT2S" "system/product/priv-app/temp/$folder"
    mv -f "system/product/etc/permissions/privapp-permissions-com.uragiristereo.pldt2s.xml" "system/product/etc/permissions/temp/$file"
    ;;
  *)
    throw_error "Invalid choice."
    ;;
  esac
  ####### Case statement 4 - END
  echo -e "$divider
\033[38;5;208mDo you wanna install Pixel Launcher Mods app?\033[0m
\033[38;5;208mIt's by Developer KieronQuinn\033[0m
\033[38;5;208mYou will be able to apply Icon Packs using it\033[0m
\033[38;5;208mIt will also enable some more functionality to pixel launcher\033[0m
1. Yes
2. No
$divider"
  read -ep "Enter your choice: " choice
  ####### Case statement 5 - START
  case $choice in
  1)
    :
    ;;
  2)
    mv "system/product/priv-app/PixelLauncherMods" "system/product/priv-app/temp/$folder"
    mv -f "system/product/etc/permissions/privapp-permissions-com.kieronquinn.app.pixellaunchermods.xml" "system/product/etc/permissions/temp/$file"
    mv "system/product/overlay/PixelLauncherModsOverlay" "system/product/overlay/temp/$folder"
    ;;
  *)
    throw_error "Invalid choice."
    ;;
  esac
  ####### Case statement 5 - END
  echo -e "$divider
\033[38;5;208mDo you want to install Icon Shape Changer app?\033[0m
1. Yes
2. No
$divider"
  read -ep "Enter your choice: " choice
  ####### Case statement 6 - START
  case $choice in
  1)
    :
    ;;
  2)
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
    ;;
  *)
    throw_error "Invalid choice."
    ;;
  esac
  ####### Case statement 6 - END
  echo -e "$divider
\033[38;5;208mDo you want to enable Developer Opions in launcher?\033[0m
\033[31;1mWARNING: Your rom may cause Bootloop Issue if you enable this feature\033[0m
\033[31;1mEnable at your own risk\033[0m
1. Yes
2. No
$divider"
  read -ep "Enter your choice: " choice
  ####### Case statement 7 - START
  case $choice in
  1)
    cp system2.prop system.prop
    mv -f "system1.prop" "temp/$file"
    mv -f "system2.prop" "temp/$file"
    ;;
  2)
    cp system1.prop system.prop
    mv -f "system1.prop" "temp/$file"
    mv -f "system2.prop" "temp/$file"
    mv -f "sepolicy.rule" "temp/$file"
    ;;
  *)
    throw_error "Invalid choice."
    ;;
  esac
  ####### Case statement 7 - END
  echo -e "$divider
\033[38;5;208mWhich Wallpaper & style app you want to install?\033[0m
\033[31;1mNOTE: AOSP Wallpaper Picker is still in beta\033[0m
\033[31;1mIt comes with some features like font changer\033[0m
\033[31;1mIt depends upon your rom that how many fonts are available in your rom\033[0m
1. Pixel Wallpaper Picker
2. AOSP Wallpaper Picker
$divider"
  read -ep "Enter your choice: " choice
  ####### Case statement 8 - START
  case $choice in
  1)
    mv -f "system/system_ext/priv-app/WallpaperPickerGoogleRelease/AOSPPicker.apk" "system/system_ext/priv-app/WallpaperPickerGoogleRelease/temp/$file"
    mv -f "system/system_ext/etc/permissions/AOSP_Picker.xml" "system/system_ext/etc/permissions/temp/$file"
    ;;
  2)
    mv -f "system/system_ext/priv-app/WallpaperPickerGoogleRelease/WallpaperPickerGoogleRelease.apk" "system/system_ext/priv-app/WallpaperPickerGoogleRelease/temp/$file"
    mv -f "system/system_ext/etc/permissions/privapp-permissions-com.google.android.apps.wallpaper.xml" "system/system_ext/etc/permissions/temp/$file"
    ;;
  *)
    throw_error "Invalid choice."
    ;;
  esac
  ####### Case statement 8 - END
  # Create zip file
  echo -e ">> Creating Magisk Module\n"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        # make the output look easier to read
  zip -r -q "Pixel Launcher Extended Customize Installer $version.zip" . -x .git/\* Modifications/\* screenshots/\* autobuild.sh autobuild.ps1 banner.jpg banner2.jpg changelog.md codename.txt logo.png online_setup.sh offline_setup.sh customize_setup.sh README.md Pixel\ Launcher\ Extended* system/product/priv-app/NexusLauncherRelease/temp/\* system/product/priv-app/temp/\* system/product/etc/permissions/temp/\* system/system_ext/etc/permissions/temp/\* system/product/overlay/temp/\* temp/\* system/system_ext/priv-app/WallpaperPickerGoogleRelease/temp/\* # Ignore specified files and folders because they are not needed for the module                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    # make the output look easier to read
  echo -e "\n>> Done! You can find the module zip file in the current directory - '$(pwd)/Pixel Launcher Extended Customize Installer $version.zip'"
  ;;
*)
  throw_error "Invalid choice."
  ;;
######## Case statement 1 - END
esac
# invoke restore content ple function to move temp files & folders back to original location
restore_content_ple
