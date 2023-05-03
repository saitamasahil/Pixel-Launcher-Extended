# Volume Key Selector - Addon that allows the use of the volume keys to select option in the installer

## Instructions:
* Call chooseport whenever you want to call to use volume key check. The function returns true if user selected vol up and false if vol down. It'll wait 3 seconds for input by default
Ex: 
    ```
    if chooseport; then
      echo "true"
    else
      echo "false"
    fi
    ```
* You can customize how many settings you want to wait for input. For example:
  * ```
    if chooseport 5; then
      echo "true"
    fi
    ```
    Will wait 5 seconds rather than the default of 3
* If you want to use the bixby button on samsung galaxy devices, [check out this post here](https://forum.xda-developers.com/showpost.php?p=77908805&postcount=16) and modify the install.sh functions accordingly

## Notes:
* Each volume key selector method will timeout after 3 seconds in the event of incompatibility or error

## Included Binaries/Credits:
* [keycheck binary](https://github.com/sonyxperiadev/device-sony-common-init/tree/master/keycheck) compiled by me [here](https://github.com/Zackptg5/Keycheck)
