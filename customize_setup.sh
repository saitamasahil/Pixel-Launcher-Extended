#!/sbin/sh

###########################
# MMT Reborn Logic
###########################

############
# Config Vars
############

# Set this to true if you want to skip mount for your module
SKIPMOUNT="false"
# Set this to true if you want to clean old files in module before injecting new module
CLEANSERVICE="false"
# Set this to true if you want to load vskel after module info print. If you want to manually load it, consider using load_vksel function
AUTOVKSEL="true"
# Set this to true if you want store debug logs of installation
DEBUG="true"

############
# Permissions
############

# Set permissions
set_permissions() {
  set_perm_recursive "$MODPATH" 0 0 0777 0777
  set_perm_recursive "$MODPATH/system/product/overlay" 0 0 0777 0777
}

############
# Info Print
############

# Set what you want to be displayed on header of installation process
info_print() {
  ui_print ""
  ui_print "**********************************************"
  ui_print "• Pixel Launcher Extended"
  ui_print "• By TeamFiles"
  ui_print "**********************************************"
  ui_print ""

  sleep 2
}

# Web fetch tool for files & media by iamlooper @ telegram
# curl: Silent mode (-fsS), redirect to STDOUT (-L) & contents to a file (-o)
# wget: Silent mode (-q), redirect to STDOUT (-O-) & contents to a file (-O)
web_fetch() {
  [[ ! -z "$(command -v wget)" ]] && tool="wget" || tool="curl"
  case "$1" in
  "-d" | "--download") [[ "$tool" == "wget" ]] && wget "$2" -qO "$3" || curl "$2" -fsSo "$3" ;;
  "-p" | "--print") [[ "$tool" == "wget" ]] && wget -qO- "$2" || curl -fsSL "$2" ;;
  esac
}

############
# Main
############

# Change the logic to whatever you want
init_main() {
  # Get the Android SDK version
  sdk_version=$(getprop ro.build.version.sdk)

  # Check if the SDK version is 32 or below
  if [[ $sdk_version -le 32 ]]; then
    # Fail the script immediately
    echo "Error: Unsupported SDK version ($sdk_version)"
    exit 1
  fi

  # Get the Android security patch level
  security_patch_level=$(getprop ro.build.version.security_patch)

  # Check if the security patch level is November 2022 or below
  if [[ $security_patch_level <= "2022-11-30" ]]; then
    ############
    # Replace List
    ############

    # List all directories you want to directly replace in the system
    # Construct your list in the following example format
    REPLACE_EXAMPLE="
    /system/app/Youtube
    /system/priv-app/SystemUI
    /system/priv-app/Settings
    /system/framework
    "
    # Construct your own list here
    REPLACE="
    /system/priv-app/AsusLauncherDev
    /system/priv-app/Lawnchair
    /system/priv-app/NexusLauncherPrebuilt
    /system/product/priv-app/ParanoidQuickStep
    /system/product/priv-app/ShadyQuickStep
    /system/product/priv-app/TrebuchetQuickStep
    /system/product/priv-app/NexusLauncherRelease
    /system/product/overlay/PixelLauncherIconsOverlay
    /system/product/overlay/CustomPixelLauncherOverlay
    /system/system_ext/priv-app/NexusLauncherRelease
    /system/system_ext/priv-app/DerpLauncherQuickStep
    /system/system_ext/priv-app/TrebuchetQuickStep
    /system/system_ext/priv-app/Lawnchair
    /system/system_ext/priv-app/PixelLauncherRelease
    /system/system_ext/priv-app/Launcher3QuickStep
    /system/system_ext/priv-app/ArrowLauncher
    /system/system_ext/priv-app/ThemePicker
    /system/system_ext/priv-app/WallpaperPickerGoogleRelease
    /system/product/overlay/ThemedIconsOverlay.apk
    /system/product/overlay/PixelLauncherIconsOverlay.apk
    /system/product/overlay/CustomPixelLauncherOverlay.apk
    "

  else
    ############
    # Replace List
    ############

    # List all directories you want to directly replace in the system
    # Construct your list in the following example format
    REPLACE_EXAMPLE="
    /system/app/Youtube
    /system/priv-app/SystemUI
    /system/priv-app/Settings
    /system/framework
    "
    # Construct your own list here
    REPLACE="
    /system/priv-app/AsusLauncherDev
    /system/priv-app/Lawnchair
    /system/priv-app/NexusLauncherPrebuilt
    /system/product/priv-app/ParanoidQuickStep
    /system/product/priv-app/ShadyQuickStep
    /system/product/priv-app/TrebuchetQuickStep
    /system/product/priv-app/NexusLauncherRelease
    /system/product/overlay/PixelLauncherIconsOverlay
    /system/product/overlay/CustomPixelLauncherOverlay
    /system/system_ext/priv-app/NexusLauncherRelease
    /system/system_ext/priv-app/TrebuchetQuickStep
    /system/system_ext/priv-app/Lawnchair
    /system/system_ext/priv-app/PixelLauncherRelease
    /system/system_ext/priv-app/Launcher3QuickStep
    /system/system_ext/priv-app/ArrowLauncher
    /system/system_ext/priv-app/ThemePicker
    /system/system_ext/priv-app/WallpaperPickerGoogleRelease
    /system/product/overlay/ThemedIconsOverlay.apk
    /system/product/overlay/PixelLauncherIconsOverlay.apk
    /system/product/overlay/CustomPixelLauncherOverlay.apk
    "
  fi

  ui_print ""
  ui_print "[*] Installing..."
  ui_print ""

  sleep 0.5

  ui_print ""
  ui_print "Finished Installing Pixel Launcher Extended"

  ui_print "[*] Clearing system cache to make it work properly..."
  ui_print ""

  rm -rf "/data/system/package_cache"

  sleep 0.5

  ui_print "[*] Done!"
  ui_print ""

  sleep 0.5

  ui_print " --- Notes --- "
  ui_print ""
  ui_print "[*] Reboot is required"
  ui_print ""
  ui_print "[*] Make sure to read Documentation Properly on Github"
  ui_print "if you wanna enable Double Tap To Sleep Feature"
  ui_print ""
  ui_print "[*] Report issues to @fileschat on Telegram"

  sleep 2

  touch "$MODPATH/first"

  # Don't add libc++_shared.so if it already exists
  [[ -e "/system/lib64/libc++_shared.so" ]] && {
    rm -rf "$MODPATH/system/lib64/libc++_shared.so"
  }
}
