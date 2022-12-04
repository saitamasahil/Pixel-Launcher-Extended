# Volume Key Selector
Addon that allows using volume keys to select options in the magisk installer.

## Instructions
* Call `chooseport` whenever you want to call to use volume key check. The function returns true if user selected volume up and false if volume down. It will wait 60 seconds for input by default.
   * Example:
  ```sh
  if chooseport; then
      echo "true"
  else
      echo "false"
  fi
  ```
* You can customize how many settings you want to wait for input.
   * Example:
  ```sh
  if chooseport 15; then
      echo "true"
  fi
  ```
  > Will wait 15 seconds instead of the default 60 seconds.
* If you want to use the **bixby button** on samsung galaxy devices, [check out this post here](https://forum.xda-developers.com/showpost.php?p=77908805&postcount=16) and modify the `install.sh` functions accordingly.

## Notes
* Each volume key selector method will timeout after 60 seconds in the event of incompatibility or error.

## Credits
* [keycheck binary](https://github.com/sonyxperiadev/device-sony-common-init/tree/master/keycheck) compiled by [Zackptg5](https://github.com/Zackptg5/Keycheck).
