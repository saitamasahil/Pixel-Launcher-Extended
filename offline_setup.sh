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
    /system/product/overlay/ThemedIconsOverlay.apk
    /system/product/overlay/PixelLauncherIconsOverlay.apk
    /system/product/overlay/CustomPixelLauncherOverlay.apk
    "
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00z.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01z.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02z.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10z.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11z.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12z.apk"

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
    /system/product/overlay/ThemedIconsOverlay.apk
    /system/product/overlay/PixelLauncherIconsOverlay.apk
    /system/product/overlay/CustomPixelLauncherOverlay.apk
    "
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk"
  fi

  ui_print ""
  ui_print "[*] Do you want to install Extra Grids in Launcher?"
  ui_print "[*] Extra Grids will enable more Grids Options in App Grid"
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
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00z.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01z.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02z.apk"

  elif [[ "$FCTEXTAD1" == "No" ]]; then
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10z.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11z.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12z.apk"
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
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease00z.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease10z.apk"
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
    ui_print "You can check preview of these two styles"
    ui_print "in Pixel Launcher Extended post on GitHub Repo"

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
      rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk"
      rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02.apk"
      rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12z.apk"
      rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02z.apk"

    elif [[ "$FCTEXTAD1" == "Glance Greetings Style 2" ]]; then
      rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk"
      rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01.apk"
      rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11z.apk"
      rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01z.apk"
    fi

  elif [[ "$FCTEXTAD1" == "No" ]]; then
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease01z.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease02z.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease11z.apk"
    rm -rf "$MODPATH/system/product/priv-app/NexusLauncherRelease/NexusLauncherRelease12z.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_Pill_Dark.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_Pill_Dark2.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_Pill_Empty.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_Pill_Empty2.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_Pill_Light.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_Pill_Light2.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_Pill_Light_Accent.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_Pill_Light_Accent2.apk"
    rm -rf "$MODPATH/system/product/overlay/TeamFiles_UserChip.apk"
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
    mv -f "$MODPATH/system/product/priv-app/PixelLauncherDT2S/PixelLauncherDT2S.apk" "$MODPATH/system/product/priv-app/PixelLauncherDT2S/PixelLauncherDT2S.apk"

  elif [[ "$FCTEXTAD1" == "No" ]]; then
    rm -rf "$MODPATH/system/product/priv-app/PixelLauncherDT2S"
    rm -rf "$MODPATH/system/product/etc/permissions/privapp-permissions-com.uragiristereo.pldt2s.xml"
  fi

  ui_print ""
  ui_print "[*] Which of the following themed icons you want to install?"
  ui_print "[*] This feature is currently in beta due to Android 13 restrictions"
  ui_print "[*] Press volume up to switch to another icons version"
  ui_print "[*] Press volume down to install those icons"
  ui_print ""

  sleep 0.5

  ui_print "--------------------------------"
  ui_print "[1] Lawnicons"
  ui_print "--------------------------------"
  ui_print "[2] TeamFiles Icons(Recommended)"
  ui_print "--------------------------------"
  ui_print "[3] RK Icons"
  ui_print "--------------------------------"
  ui_print "[4] DG Icons"
  ui_print "--------------------------------"
  ui_print "[5] ACons"
  ui_print "--------------------------------"
  ui_print "[6] Cayicons"
  ui_print "--------------------------------"
  ui_print "[7] None Of The Above"
  ui_print "--------------------------------"

  ui_print ""
  ui_print "[*] Select which of the themed icons you want:"

  SM=1
  while true; do
    ui_print "  $SM"
    "$VKSEL" && SM="$((SM + 1))" || break
    [[ "$SM" -gt "7" ]] && SM=1
  done

  case "$SM" in
  "1") FCTEXTAD1="Lawnicons" ;;
  "2") FCTEXTAD1="TeamFiles Icons" ;;
  "3") FCTEXTAD1="RK Icons" ;;
  "4") FCTEXTAD1="DG Icons" ;;
  "5") FCTEXTAD1="ACons" ;;
  "6") FCTEXTAD1="Cayicons" ;;
  "7") FCTEXTAD1="None Of The Above" ;;
  esac

  ui_print "[*] Selected: $FCTEXTAD1"
  ui_print ""

  if [[ "$FCTEXTAD1" == "Lawnicons" ]]; then
    mv -f "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayLawnicons.apk" "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlay.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayRKIcons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayTeamFilesIcons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayDGIcons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayACons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayCayicons.apk"

  elif [[ "$FCTEXTAD1" == "TeamFiles Icons" ]]; then
    mv -f "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayTeamFilesIcons.apk" "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlay.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayRKIcons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayLawnicons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayDGIcons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayACons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayCayicons.apk"

  elif [[ "$FCTEXTAD1" == "RK Icons" ]]; then
    mv -f "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayRKIcons.apk" "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlay.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayLawnicons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayTeamFilesIcons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayDGIcons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayACons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayCayicons.apk"

  elif [[ "$FCTEXTAD1" == "DG Icons" ]]; then
    mv -f "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayDGIcons.apk" "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlay.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayLawnicons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayTeamFilesIcons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayRKIcons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayACons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayCayicons.apk"

  elif [[ "$FCTEXTAD1" == "ACons" ]]; then
    mv -f "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayACons.apk" "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlay.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayLawnicons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayTeamFilesIcons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayRKIcons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayDGIcons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayCayicons.apk"

  elif [[ "$FCTEXTAD1" == "Cayicons" ]]; then
    mv -f "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayCayicons.apk" "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlay.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayLawnicons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayTeamFilesIcons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayRKIcons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayDGIcons.apk"
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay/ThemedIconsOverlayACons.apk"

  elif [[ "$FCTEXTAD1" == "None Of The Above" ]]; then
    rm -rf "$MODPATH/system/product/overlay/ThemedIconsOverlay"
  fi

  ui_print ""
  ui_print "[*] Do you wanna install Pixel Launcher Mods App?"
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
    mv -f "$MODPATH/system/product/priv-app/PixelLauncherMods/PixelLauncherMods.apk" "$MODPATH/system/product/priv-app/PixelLauncherMods/PixelLauncherMods.apk"

  elif [[ "$FCTEXTAD1" == "No" ]]; then
    rm -rf "$MODPATH/system/product/priv-app/PixelLauncherMods"
    rm -rf "$MODPATH/system/product/etc/permissions/privapp-permissions-com.kieronquinn.app.pixellaunchermods.xml"
    rm -rf "$MODPATH/system/product/overlay/PixelLauncherModsOverlay"
  fi

  ui_print ""
  ui_print "[*] Which of the following icon shape you want to use with launcher?"
  ui_print "[*] Press volume up to switch to another icon shape"
  ui_print "[*] Press volume down to install that icon shape"
  ui_print ""

  sleep 0.5

  ui_print "--------------------------------"
  ui_print "[1] Circle(Default)"
  ui_print "--------------------------------"
  ui_print "[2] Cloudy"
  ui_print "--------------------------------"
  ui_print "[3] Cylinder"
  ui_print "--------------------------------"
  ui_print "[4] Flower"
  ui_print "--------------------------------"
  ui_print "[5] Heart"
  ui_print "--------------------------------"
  ui_print "[6] Hexagon"
  ui_print "--------------------------------"
  ui_print "[7] Leaf"
  ui_print "--------------------------------"
  ui_print "[8] Mallow"
  ui_print "--------------------------------"
  ui_print "[9] Pebble"
  ui_print "--------------------------------"
  ui_print "[10] Rounded Hexagon"
  ui_print "--------------------------------"
  ui_print "[11] Rounded Rectangle"
  ui_print "--------------------------------"
  ui_print "[12] Square"
  ui_print "--------------------------------"
  ui_print "[13] Squircle"
  ui_print "--------------------------------"
  ui_print "[14] Stretched"
  ui_print "--------------------------------"
  ui_print "[15] Tapered Rectangular"
  ui_print "--------------------------------"
  ui_print "[16] Teardrops"
  ui_print "--------------------------------"
  ui_print "[17] Vessel"
  ui_print "--------------------------------"
  ui_print "[18] Samsung(One UI Like)"
  ui_print "--------------------------------"

  ui_print ""
  ui_print "[*] Select which of the icon shape you want:"

  SM=1
  while true; do
    ui_print "  $SM"
    "$VKSEL" && SM="$((SM + 1))" || break
    [[ "$SM" -gt "18" ]] && SM=1
  done

  case "$SM" in
  "1") FCTEXTAD1="Circle(Default)" ;;
  "2") FCTEXTAD1="Cloudy" ;;
  "3") FCTEXTAD1="Cylinder" ;;
  "4") FCTEXTAD1="Flower" ;;
  "5") FCTEXTAD1="Heart" ;;
  "6") FCTEXTAD1="Hexagon" ;;
  "7") FCTEXTAD1="Leaf" ;;
  "8") FCTEXTAD1="Mallow" ;;
  "9") FCTEXTAD1="Pebble" ;;
  "10") FCTEXTAD1="Rounded Hexagon" ;;
  "11") FCTEXTAD1="Rounded Rectangle" ;;
  "12") FCTEXTAD1="Square" ;;
  "13") FCTEXTAD1="Squircle" ;;
  "14") FCTEXTAD1="Stretched" ;;
  "15") FCTEXTAD1="Tapered Rectangular" ;;
  "16") FCTEXTAD1="Teardrops" ;;
  "17") FCTEXTAD1="Vessel" ;;
  "18") FCTEXTAD1="Samsung" ;;
  esac

  ui_print "[*] Selected: $FCTEXTAD1"
  ui_print ""

  if [[ "$FCTEXTAD1" == "Circle(Default)" ]]; then
    rm -rf "$MODPATH/system/product/overlay/IconShape"

  elif [[ "$FCTEXTAD1" == "Cloudy" ]]; then
    mv -f "$MODPATH/system/product/overlay/IconShape/Cloudy.apk" "$MODPATH/system/product/overlay/IconShape/IconShape.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cylinder.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Flower.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Heart.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Hexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Leaf.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Mallow.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Pebble.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedHexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedRectangle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Square.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Squircle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Stretched.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/TaperedRectangular.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Teardrops.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Vessel.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Samsung.apk"

  elif [[ "$FCTEXTAD1" == "Cylinder" ]]; then
    mv -f "$MODPATH/system/product/overlay/IconShape/Cylinder.apk" "$MODPATH/system/product/overlay/IconShape/IconShape.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cloudy.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Flower.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Heart.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Hexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Leaf.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Mallow.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Pebble.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedHexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedRectangle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Square.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Squircle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Stretched.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/TaperedRectangular.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Teardrops.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Vessel.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Samsung.apk"

  elif [[ "$FCTEXTAD1" == "Flower" ]]; then
    mv -f "$MODPATH/system/product/overlay/IconShape/Flower.apk" "$MODPATH/system/product/overlay/IconShape/IconShape.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cloudy.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cylinder.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Heart.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Hexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Leaf.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Mallow.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Pebble.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedHexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedRectangle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Square.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Squircle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Stretched.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/TaperedRectangular.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Teardrops.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Vessel.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Samsung.apk"

  elif [[ "$FCTEXTAD1" == "Heart" ]]; then
    mv -f "$MODPATH/system/product/overlay/IconShape/Heart.apk" "$MODPATH/system/product/overlay/IconShape/IconShape.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cloudy.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cylinder.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Flower.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Hexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Leaf.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Mallow.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Pebble.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedHexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedRectangle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Square.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Squircle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Stretched.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/TaperedRectangular.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Teardrops.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Vessel.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Samsung.apk"

  elif [[ "$FCTEXTAD1" == "Hexagon" ]]; then
    mv -f "$MODPATH/system/product/overlay/IconShape/Hexagon.apk" "$MODPATH/system/product/overlay/IconShape/IconShape.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cloudy.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cylinder.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Flower.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Heart.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Leaf.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Mallow.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Pebble.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedHexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedRectangle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Square.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Squircle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Stretched.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/TaperedRectangular.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Teardrops.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Vessel.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Samsung.apk"

  elif [[ "$FCTEXTAD1" == "Leaf" ]]; then
    mv -f "$MODPATH/system/product/overlay/IconShape/Leaf.apk" "$MODPATH/system/product/overlay/IconShape/IconShape.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cloudy.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cylinder.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Flower.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Heart.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Hexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Mallow.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Pebble.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedHexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedRectangle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Square.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Squircle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Stretched.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/TaperedRectangular.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Teardrops.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Vessel.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Samsung.apk"

  elif [[ "$FCTEXTAD1" == "Mallow" ]]; then
    mv -f "$MODPATH/system/product/overlay/IconShape/Mallow.apk" "$MODPATH/system/product/overlay/IconShape/IconShape.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cloudy.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cylinder.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Flower.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Heart.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Hexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Leaf.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Pebble.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedHexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedRectangle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Square.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Squircle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Stretched.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/TaperedRectangular.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Teardrops.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Vessel.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Samsung.apk"

  elif [[ "$FCTEXTAD1" == "Pebble" ]]; then
    mv -f "$MODPATH/system/product/overlay/IconShape/Pebble.apk" "$MODPATH/system/product/overlay/IconShape/IconShape.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cloudy.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cylinder.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Flower.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Heart.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Hexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Leaf.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Mallow.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedHexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedRectangle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Square.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Squircle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Stretched.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/TaperedRectangular.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Teardrops.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Vessel.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Samsung.apk"

  elif [[ "$FCTEXTAD1" == "Rounded Hexagon" ]]; then
    mv -f "$MODPATH/system/product/overlay/IconShape/RoundedHexagon.apk" "$MODPATH/system/product/overlay/IconShape/IconShape.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cloudy.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cylinder.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Flower.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Heart.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Hexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Leaf.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Mallow.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Pebble.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedRectangle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Square.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Squircle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Stretched.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/TaperedRectangular.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Teardrops.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Vessel.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Samsung.apk"

  elif [[ "$FCTEXTAD1" == "Rounded Rectangle" ]]; then
    mv -f "$MODPATH/system/product/overlay/IconShape/RoundedRectangle.apk" "$MODPATH/system/product/overlay/IconShape/IconShape.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cloudy.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cylinder.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Flower.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Heart.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Hexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Leaf.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Mallow.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Pebble.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedHexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Square.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Squircle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Stretched.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/TaperedRectangular.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Teardrops.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Vessel.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Samsung.apk"

  elif [[ "$FCTEXTAD1" == "Square" ]]; then
    mv -f "$MODPATH/system/product/overlay/IconShape/Square.apk" "$MODPATH/system/product/overlay/IconShape/IconShape.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cloudy.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cylinder.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Flower.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Heart.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Hexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Leaf.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Mallow.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Pebble.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedHexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedRectangle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Squircle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Stretched.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/TaperedRectangular.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Teardrops.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Vessel.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Samsung.apk"

  elif [[ "$FCTEXTAD1" == "Squircle" ]]; then
    mv -f "$MODPATH/system/product/overlay/IconShape/Squircle.apk" "$MODPATH/system/product/overlay/IconShape/IconShape.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cloudy.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cylinder.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Flower.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Heart.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Hexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Leaf.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Mallow.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Pebble.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedHexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedRectangle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Square.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Stretched.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/TaperedRectangular.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Teardrops.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Vessel.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Samsung.apk"

  elif [[ "$FCTEXTAD1" == "Stretched" ]]; then
    mv -f "$MODPATH/system/product/overlay/IconShape/Stretched.apk" "$MODPATH/system/product/overlay/IconShape/IconShape.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cloudy.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cylinder.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Flower.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Heart.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Hexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Leaf.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Mallow.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Pebble.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedHexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedRectangle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Square.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Squircle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/TaperedRectangular.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Teardrops.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Vessel.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Samsung.apk"

  elif [[ "$FCTEXTAD1" == "Tapered Rectangular" ]]; then
    mv -f "$MODPATH/system/product/overlay/IconShape/TaperedRectangular.apk" "$MODPATH/system/product/overlay/IconShape/IconShape.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cloudy.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cylinder.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Flower.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Heart.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Hexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Leaf.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Mallow.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Pebble.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedHexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedRectangle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Square.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Squircle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Stretched.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Teardrops.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Vessel.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Samsung.apk"

  elif [[ "$FCTEXTAD1" == "Teardrops" ]]; then
    mv -f "$MODPATH/system/product/overlay/IconShape/Teardrops.apk" "$MODPATH/system/product/overlay/IconShape/IconShape.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cloudy.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cylinder.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Flower.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Heart.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Hexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Leaf.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Mallow.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Pebble.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedHexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedRectangle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Square.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Squircle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Stretched.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/TaperedRectangular.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Vessel.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Samsung.apk"

  elif [[ "$FCTEXTAD1" == "Vessel" ]]; then
    mv -f "$MODPATH/system/product/overlay/IconShape/Vessel.apk" "$MODPATH/system/product/overlay/IconShape/IconShape.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cloudy.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cylinder.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Flower.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Heart.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Hexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Leaf.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Mallow.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Pebble.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedHexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedRectangle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Square.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Squircle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Stretched.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/TaperedRectangular.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Teardrops.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Samsung.apk"

  elif [[ "$FCTEXTAD1" == "Samsung" ]]; then
    mv -f "$MODPATH/system/product/overlay/IconShape/Samsung.apk" "$MODPATH/system/product/overlay/IconShape/IconShape.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cloudy.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Cylinder.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Flower.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Heart.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Hexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Leaf.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Mallow.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Pebble.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedHexagon.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/RoundedRectangle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Square.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Squircle.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Stretched.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/TaperedRectangular.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Teardrops.apk"
    rm -rf "$MODPATH/system/product/overlay/IconShape/Vessel.apk"
  fi

  ui_print ""
  ui_print "[*] Do you want to enable push notification service?"
  ui_print "[*] We will send notifications for quick support"
  ui_print "or if there is any new update available"
  ui_print "[*] This feature uses very little internet"
  ui_print "[*] Check ReadMe on GitHub to know more about it"
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
    mv -f "$MODPATH/system/product/priv-app/OnePunchNotifier/OnePunchNotifier.apk" "$MODPATH/system/product/priv-app/OnePunchNotifier/OnePunchNotifier.apk"

  elif [[ "$FCTEXTAD1" == "No" ]]; then
    rm -rf "$MODPATH/system/lib64"
    rm -rf "$MODPATH/cns"
    rm -rf "$MODPATH/system/product/priv-app/OnePunchNotifier"
    rm -rf "$MODPATH/system/product/etc/permissions/privapp-permissions-com.looper.notifier.xml"
  fi

  ui_print ""
  ui_print "[*] Do you want to enable Developer Opions in launcher?"
  ui_print "[*] WARNING: Your rom may cause Bootloop Issue if you enable this feature"
  ui_print "[*] Enable at your own risk"
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
    mv -f "$MODPATH/system2.prop" "$MODPATH/system.prop"
    rm -rf "$MODPATH/system1.prop"

  elif [[ "$FCTEXTAD1" == "No" ]]; then
    mv -f "$MODPATH/system1.prop" "$MODPATH/system.prop"
    rm -rf "$MODPATH/system2.prop"
    rm -rf "$MODPATH/sepolicy.rule"
  fi

  ui_print ""
  ui_print "[*] Do you install new Wallpaper & style app?"
  ui_print "[*] WARNING: It's still in beta"
  ui_print "[*] It's features like font changer may not even work"
  ui_print "depending upon your rom"
  ui_print "[*] Press volume up to switch to another choice"
  ui_print "[*] Press volume down to continue with that choice"
  ui_print ""

  sleep 0.5

  ui_print "--------------------------------"
  ui_print "[1] Yes"
  ui_print "--------------------------------"
  ui_print "[2] No(Recommended)"
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
    rm -rf "$MODPATH/system/system_ext/priv-app/WallpaperPickerGoogleRelease/WallpaperPickerGoogleRelease.apk"

  elif [[ "$FCTEXTAD1" == "No" ]]; then
    rm -rf "$MODPATH/system/system_ext/priv-app/WallpaperPickerGoogleRelease/WallpaperPickerGoogleReleaseNew.apk"
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

  # Don't add libc++_shared.so if it already exists
  [[ -e "/system/lib64/libc++_shared.so" ]] && {
    rm -rf "$MODPATH/system/lib64/libc++_shared.so"
  }
}
