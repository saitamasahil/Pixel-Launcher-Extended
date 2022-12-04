# External Tools
chmod -R 0777 $MODPATH/addon/Volume-Key-Selector/tools

chooseport_legacy() {
    # Keycheck binary by someone755 @Github, idea for code below by Zappo @xda-developers
    # Calling it first time detects previous input. Calling it second time will do what we want
    [ "$1" ] && local delay=$1 || local delay=60
    local error=false
    while true; do
        timeout 0 $MODPATH/addon/Volume-Key-Selector/tools/$ARCH32/keycheck
        timeout $delay $MODPATH/addon/Volume-Key-Selector/tools/$ARCH32/keycheck
        local sel=$?
        if [ $sel -eq 42 ]; then
            return 0
        elif [ $sel -eq 41 ]; then
            return 1
        elif $error; then
            abort "Error!"
        else
            error=true
            echo "Try again!"
        fi
    done
}

chooseport() {
    # Original idea by chainfire and ianmacd @xda-developers
    [ "$1" ] && local delay=$1 || local delay=60
    local error=false 
    while true; do
        local count=0
        while true; do
            timeout $delay /system/bin/getevent -lqc 1 2>&1 > $TMPDIR/events &
            sleep 0.5; count=$((count + 1))
            if (`grep -q 'KEY_VOLUMEUP *DOWN' $TMPDIR/events`); then
                return 0
            elif (`grep -q 'KEY_VOLUMEDOWN *DOWN' $TMPDIR/events`); then
                return 1
            fi
            [ $count -gt 60 ] && break
        done
        if $error; then
            echo "Trying keycheck method..."
            export chooseport=chooseport_legacy VKSEL=chooseport_legacy
            chooseport_legacy $delay
            return $?
        else
            error=true
            echo "Volume key not detected, try again!"
        fi
    done
}

VKSEL=chooseport
