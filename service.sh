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

pref_patch() {
    file=$4
    name=$1
    value=$2
    type=$3
    if [ -f $file ]; then
        exist="$(grep "\"$name\"" $file | grep $type)"
        if [ ! -z "$exist" ]; then
            old_value=$(echo "$exist" | cut -d\" -f4)
            if [ ! -z "$old_value" ]; then
                sed -i -e "s/\"$name\" value=\"$old_value\"/\"$name\" value=\"$value\"/g" $file
            else
                old_value="$(echo "$exist" | cut -d\> -f2 | cut -d\< -f1)"
                if [ ! -z "$old_value" ]; then
                    sed -i -e "s/\"$name\">$old_value</\"$name\">$value</g" $file
                fi
            fi
        else
            if [ $type != "string" ]; then
                sed -i -e "/<\/map>/i\
<$type name=\"$name\" value=\"$value\" \/>" $file
            else
                sed -i -e "/<\/map>/i\
<$type name=\"$name\">$value<\/$type>" $file
            fi
        fi
    fi
}

PL_PREF=/data/data/com.google.android.apps.nexuslauncher/shared_prefs/com.android.launcher3.prefs.xml

if [ -f $MODDIR/first ]; then
    if [ -d /data/data/com.google.android.apps.nexuslauncher ]; then
        pm install $MODDIR/system/**/priv-app/WallpaperPickerGoogleRelease/WallpaperPickerGoogleRelease.apk
        if [ ! -f $PL_PREF ]; then
            echo "<?xml version='1.0' encoding='utf-8' standalone='yes' ?>" >>$PL_PREF
            echo '<map>
    <int name="launcher.home_bounce_count" value="3" />
    <boolean name="launcher.apps_view_shown" value="true" />
    <boolean name="pref_allowChromeTabResult" value="false" />
    <boolean name="pref_allowWebResultAga" value="true" />
    <int name="ALL_APPS_SEARCH_CORPUS_PREFERENCE" value="206719" />
    <boolean name="pref_allowWidgetsResult" value="false" />
    <int name="migration_src_device_type" value="0" />
    <boolean name="pref_search_show_keyboard" value="false" />
    <boolean name="pref_allowPeopleResult" value="true" />
    <boolean name="pref_enable_minus_one" value="true" />
    <string name="migration_src_workspace_size">5,5</string>
    <boolean name="pref_search_show_hidden_targets" value="false" />
    <boolean name="pref_allowWebSuggestChrome" value="false" />
    <boolean name="pref_allowPixelTipsResult" value="true" />
    <string name="idp_grid_name">normal</string>
    <boolean name="pref_allowScreenshotResult" value="true" />
    <boolean name="pref_allowMemoryResult" value="true" />
    <boolean name="pref_allowShortcutResult" value="true" />
    <boolean name="pref_allowRotation" value="false" />
    <boolean name="launcher.select_tip_seen" value="true" />
    <boolean name="pref_allowWebResult" value="true" />
    <boolean name="pref_allowSettingsResult" value="true" />
    <int name="migration_src_hotseat_count" value="5" />
    <int name="launcher.hotseat_discovery_tip_count" value="5" />
    <boolean name="pref_add_icon_to_home" value="true" />
    <string name="migration_src_db_file">launcher.db</string>
    <boolean name="pref_overview_action_suggestions" value="false" />
    <boolean name="pref_allowPlayResult" value="true" />
    <int name="launcher.all_apps_visited_count" value="10" />
</map>' >>$PL_PREF
        else
            pref_patch pref_overview_action_suggestions false boolean $PL_PREF
        fi
        am force-stop com.google.android.apps.nexuslauncher
    fi
    rm -rf $MODDIR/first
fi
