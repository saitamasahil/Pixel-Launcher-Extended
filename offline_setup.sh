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
DEBUG="false"

############
# Permissions
############

# Set permissions
set_permissions() {
  set_perm_recursive "$MODPATH" 0 0 0777 0755
  set_perm_recursive "$MODPATH/system/product/app/PixelThemesStub2022_and_newer" 0 0 0777 0755
  set_perm_recursive "$MODPATH/system/product/app/ThemesStub" 0 0 0777 0755
  set_perm_recursive "$MODPATH/system/product/etc/default-permissions" 0 0 0777 0755
  set_perm_recursive "$MODPATH/system/product/etc/permissions" 0 0 0777 0755
  set_perm_recursive "$MODPATH/system/product/etc/sysconfig" 0 0 0777 0755
  set_perm_recursive "$MODPATH/system/product/overlay" 0 0 0777 0755
  set_perm_recursive "$MODPATH/system/product/overlay/PixelLauncherModsOverlay" 0 0 0777 0755
  set_perm_recursive "$MODPATH/system/product/overlay/PixelRecentsProvider" 0 0 0777 0755
  set_perm_recursive "$MODPATH/system/product/overlay/ThemedIconsOverlay" 0 0 0777 0755
  set_perm_recursive "$MODPATH/system/product/priv-app/ExtendedSettings" 0 0 0777 0755
  set_perm_recursive "$MODPATH/system/product/priv-app/IconShapeChanger" 0 0 0777 0755
  set_perm_recursive "$MODPATH/system/product/priv-app/NexusLauncherRelease" 0 0 0777 0755
  set_perm_recursive "$MODPATH/system/product/priv-app/PixelLauncherDT2S" 0 0 0777 0755
  set_perm_recursive "$MODPATH/system/product/priv-app/PixelLauncherMods" 0 0 0777 0755
  set_perm_recursive "$MODPATH/system/product/priv-app/PixelLauncherMods/lib/arm64" 0 0 0777 0755
  set_perm_recursive "$MODPATH/system/system_ext/etc/permissions" 0 0 0777 0755
  set_perm_recursive "$MODPATH/system/system_ext/priv-app/QuickAccessWallet" 0 0 0777 0755
  set_perm_recursive "$MODPATH/system/system_ext/priv-app/WallpaperPickerGoogleRelease" 0 0 0777 0755
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
/system/system_ext/priv-app/WallpaperPickerGoogleRelease
/system/product/overlay/ThemedIconsOverlay.apk
/system/product/overlay/PixelLauncherIconsOverlay.apk
/system/product/overlay/CustomPixelLauncherOverlay.apk
/system/product/overlay/MiuiCameraOverlay/MiuiCameraOverlay.apk
/system/product/overlay/MiuiGalleryOverlay/MiuiGalleryOverlay.apk
"

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

  # Get the security patch date from build.prop
  PATCH_DATE=$(getprop ro.build.version.security_patch)

  # Convert it to YYYYMM format
  PATCH_YEAR=${PATCH_DATE:0:4}
  PATCH_MONTH=${PATCH_DATE:5:2}
  PATCH_LEVEL=$PATCH_YEAR$PATCH_MONTH

  if [ $PATCH_LEVEL -le 202211 ]; then
    ui_print "Android 13 detected!"
    ui_print "Security Patch - $PATCH_DATE"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease21.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease22.apk"
    rm -rf "$MODPATH/system/system_ext/priv-app/WallpaperPickerGoogleRelease/WallpaperPickerGoogleRelease.apk"

  elif [ $PATCH_LEVEL -le 202302 ]; then
    ui_print "Android 13 QPR detected!"
    ui_print "Security Patch - $PATCH_DATE"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease20.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease22.apk"
    rm -rf "$MODPATH/system/system_ext/priv-app/WallpaperPickerGoogleRelease/WallpaperPickerGoogleRelease.apk"

  elif [ $PATCH_LEVEL -ge 202303 ]; then
    ui_print "Android 13 QPR2 detected!"
    ui_print "Security Patch - $PATCH_DATE"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease20.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease21.apk"
    rm -rf "$MODPATH/system/system_ext/priv-app/WallpaperPickerGoogleRelease/WallpaperPickerGoogleReleaseOld.apk"
  fi

  ui_print ""
  ui_print "[*] If the information displayed above is accurate?"
  ui_print "[*] Press volume up to switch to another choice"
  ui_print "[*] Press volume down to continue with that choice"
  ui_print ""

  sleep 0.5

  ui_print "--------------------------------"
  ui_print "[1] Yes"
  ui_print "--------------------------------"
  ui_print "[2] No"
  ui_print "--------------------------------"

  ui_print ""
  ui_print "[*] Select your desired option:"

  SM=1
  while true; do
    ui_print "  $SM"
    "$VKSEL" && SM="$((SM + 1))" || break
    [[ "$SM" -gt "2" ]] && SM=1
  done

  case "$SM" in
  "1") FCTEXTAD1="Yes" ;;
  "2") FCTEXTAD1="No" ;;
  esac

  ui_print "[*] Selected: $FCTEXTAD1"
  ui_print ""

  if [[ "$FCTEXTAD1" == "Yes" ]]; then
    ui_print "The installation process of Pixel Launcher Extended has been started!!"

  elif [[ "$FCTEXTAD1" == "No" ]]; then
    ui_print "Tell your rom maintainer to fix"
    ui_print "'getprop ro.build.version.security_patch - $PATCH_DATE' value"
    ui_print "or make Customize Installer from GitHub"
    exit 1
  fi

  ui_print ""
  ui_print "[*] Do you wanna add 'Material You Greetings In At A Glance'"
  ui_print "& install Extended Settings app?"
  ui_print "[*] Press volume up to switch to another choice"
  ui_print "[*] Press volume down to continue with that choice"
  ui_print ""

  sleep 0.5

  ui_print "--------------------------------"
  ui_print "[1] Yes"
  ui_print "--------------------------------"
  ui_print "[2] No"
  ui_print "--------------------------------"

  ui_print ""
  ui_print "[*] Select your desired option:"

  SM=1
  while true; do
    ui_print "  $SM"
    "$VKSEL" && SM="$((SM + 1))" || break
    [[ "$SM" -gt "2" ]] && SM=1
  done

  case "$SM" in
  "1") FCTEXTAD1="Yes" ;;
  "2") FCTEXTAD1="No" ;;
  esac

  ui_print "[*] Selected: $FCTEXTAD1"
  ui_print ""

  if [[ "$FCTEXTAD1" == "Yes" ]]; then
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02.apk"
    ui_print "[*] Do you want to install Glance Greetings Style 1 or Glance Greetings Style 2?"
    ui_print "[*] Press volume up to switch to another choice"
    ui_print "[*] Press volume down to continue with that choice"
    ui_print ""

    sleep 0.5

    ui_print "--------------------------------"
    ui_print "[1] Glance Greetings Style 1"
    ui_print "Example Of Style 1-"
    ui_print "Line 1 - Material You Greetings,"
    ui_print "Line 2 - Day & Date"
    ui_print "Line 3 - Weather Information"
    ui_print "--------------------------------"
    ui_print "[2] Glance Greetings Style 2"
    ui_print "Example Of Style 2-"
    ui_print "Line 1 - Material You Greetings, Day & Date"
    ui_print "Line 2 - Weather Information"
    ui_print "--------------------------------"

    ui_print ""
    ui_print "[*] Select your desired option:"

    SM="1"
    while true; do
      ui_print "  $SM"
      "$VKSEL" && SM="$((SM + 1))" || break
      [[ "$SM" -gt "2" ]] && SM="1"
    done

    case "$SM" in
    "1") FCTEXTAD1="Glance Greetings Style 1" ;;
    "2") FCTEXTAD1="Glance Greetings Style 2" ;;
    esac

    ui_print "[*] Selected: $FCTEXTAD1"
    ui_print ""

    if [[ "$FCTEXTAD1" == "Glance Greetings Style 1" ]]; then
      rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease20.apk"
      rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease21.apk"
      rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease22.apk"

    elif [[ "$FCTEXTAD1" == "Glance Greetings Style 2" ]]; then
      rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10.apk"
      rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk"
      rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk"
    fi

  elif [[ "$FCTEXTAD1" == "No" ]]; then
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease20.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease21.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease22.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_Pill_Dark.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_Pill_Dark2.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_Pill_Empty.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_Pill_Empty2.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_Pill_Light.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_Pill_Light2.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_Pill_Light_Accent.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_Pill_Light_Accent2.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_UserChip.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_UserCL.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_UserLockscreen.apk"
    rm -rf "$MODPATH/system/product/priv-app/ExtendedSettings"
    rm -rf "$MODPATH/system/product/etc/permissions/privapp-permissions-com.domain.liranazuz5.extendedsettings.xml"
  fi

  ui_print ""
  ui_print "[*] Do you want to enable DT2S in Launcher?"
  ui_print "[*] DT2S Means - Double Tap To Sleep Feature"
  ui_print "[*] Make sure you have LSPosed Installed in your rom"
  ui_print "[*] Without LSPosed it won't work"
  ui_print "[*] Read Documentation on GitHub"
  ui_print "to know more about activating it"
  ui_print "[*] Press volume up to switch to another choice"
  ui_print "[*] Press volume down to continue with that choice"
  ui_print ""

  sleep 0.5

  ui_print "--------------------------------"
  ui_print "[1] Yes"
  ui_print "--------------------------------"
  ui_print "[2] No"
  ui_print "--------------------------------"

  ui_print ""
  ui_print "[*] Select your desired option:"

  SM=1
  while true; do
    ui_print "  $SM"
    "$VKSEL" && SM="$((SM + 1))" || break
    [[ "$SM" -gt "2" ]] && SM=1
  done

  case "$SM" in
  "1") FCTEXTAD1="Yes" ;;
  "2") FCTEXTAD1="No" ;;
  esac

  ui_print "[*] Selected: $FCTEXTAD1"
  ui_print ""

  if [[ "$FCTEXTAD1" == "Yes" ]]; then
    :

  elif [[ "$FCTEXTAD1" == "No" ]]; then
    rm -rf "$MODPATH/system/product/priv-app/PixelLauncherDT2S"
    rm -rf "$MODPATH/system/product/etc/permissions/privapp-permissions-com.uragiristereo.pldt2s.xml"
  fi

  ui_print ""
  ui_print "[*] Do you wanna install Pixel Launcher Mods app?"
  ui_print "[*] It's by Developer KieronQuinn"
  ui_print "[*] You will be able to apply Icon Packs using it"
  ui_print "[*] It will also enable some more functionality to pixel launcher"
  ui_print "[*] Press volume up to switch to another choice"
  ui_print "[*] Press volume down to continue with that choice"
  ui_print ""

  sleep 0.5

  ui_print "--------------------------------"
  ui_print "[1] Yes"
  ui_print "--------------------------------"
  ui_print "[2] No"
  ui_print "--------------------------------"

  ui_print ""
  ui_print "[*] Select your desired option:"

  SM=1
  while true; do
    ui_print "  $SM"
    "$VKSEL" && SM="$((SM + 1))" || break
    [[ "$SM" -gt "2" ]] && SM=1
  done

  case "$SM" in
  "1") FCTEXTAD1="Yes" ;;
  "2") FCTEXTAD1="No" ;;
  esac

  ui_print "[*] Selected: $FCTEXTAD1"
  ui_print ""

  if [[ "$FCTEXTAD1" == "Yes" ]]; then
    :

  elif [[ "$FCTEXTAD1" == "No" ]]; then
    rm -rf "$MODPATH/system/product/priv-app/PixelLauncherMods"
    rm -rf "$MODPATH/system/product/etc/permissions/privapp-permissions-com.kieronquinn.app.pixellaunchermods.xml"
    rm -rf "$MODPATH/system/product/overlay/PixelLauncherModsOverlay"
  fi

  ui_print ""
  ui_print "[*] Do you want to install Icon Shape Changer app?"
  ui_print "[*] Press volume up to switch to another choice"
  ui_print "[*] Press volume down to continue with that choice"
  ui_print ""

  sleep 0.5

  ui_print "--------------------------------"
  ui_print "[1] Yes"
  ui_print "--------------------------------"
  ui_print "[2] No"
  ui_print "--------------------------------"

  ui_print ""
  ui_print "[*] Select your desired option:"

  SM=1
  while true; do
    ui_print "  $SM"
    "$VKSEL" && SM="$((SM + 1))" || break
    [[ "$SM" -gt "2" ]] && SM=1
  done

  case "$SM" in
  "1") FCTEXTAD1="Yes" ;;
  "2") FCTEXTAD1="No" ;;
  esac

  ui_print "[*] Selected: $FCTEXTAD1"
  ui_print ""

  if [[ "$FCTEXTAD1" == "Yes" ]]; then
    :

  elif [[ "$FCTEXTAD1" == "No" ]]; then
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_we_Cloudy.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_we_Cylinder.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_we_Flower.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_we_Hexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_we_Leaf.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_we_Mallow.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_we_Pebble.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_we_RoundedHexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_we_RoundedRectangle.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_we_Square.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_we_Squircle.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_we_Stretched.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_we_TaperedRectangular.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_we_Teardrops.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_we_Vessel.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_we_Samsung.apk"
    rm -rf "$MODPATH/system/product/priv-app/IconShapeChanger"
    rm -rf "$MODPATH/system/product/etc/permissions/privapp-permissions-com.saitama.iconshape.xml"
  fi

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

}
