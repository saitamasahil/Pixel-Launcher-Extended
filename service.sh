#!/system/bin/sh
# Do NOT assume where your module will be located.
# ALWAYS use $MODDIR if you need to know where this script
# and module is placed.
# This will make sure your module will still work
# if Magisk change its mount point in the future
MODDIR=${0%/*}

loop_count=0

# Wait for the boot
while true; do
  boot=$(getprop sys.boot_completed)
  if [ "$boot" -eq 1 ] && [ -d /data/data ]; then
    sleep 5
    break
  fi
  if [ $loop_count -gt 30 ]; then
    break
  fi
  sleep 5
  loop_count=$((loop_count + 1))
done

if [ -f $MODDIR/first ]; then
  # Get the Android SDK version
  sdk_version=$(getprop ro.build.version.sdk)

  if [ "$sdk_version" -eq 33 ]; then
    su -c "settings delete secure theme_customization_overlay_packages"
  fi
  rm -rf $MODDIR/first
fi

# Execute
"$MODDIR/flags"
