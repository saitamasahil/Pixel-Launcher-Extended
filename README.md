## Pixel Launcher Extended Documentation

[![Telegram URL](https://img.shields.io/twitter/url?label=Telegram&logo=telegram&style=social&url=https%3A%2F%2Ft.me%2)](https://telegram.me/modulesrepo)
![Header Image](https://raw.githubusercontent.com/saitamasahil/Pixel-Launcher-Extended/main/banner.jpg)

**Pixel Launcher Extended** is a Magisk module with many cool features compared to original Pixel Launcher by Google.

### Features
- Extra themed icons support. Total of 1200+ themed icons for your favourite apps and games
- More grids options, total of 14 grids. You can select these extra grids by going to **Wallpaper & style** > **App grid**
- Double tap to sleep *(LSPosed required)*
- You can choose different icons shapes while installing.
- Material You At A Glance greetings
- [Pixel Launcher Mods](https://github.com/KieronQuinn/PixelLauncherMods) by KieronQuinn. It has many cool features such as icon pack changer, recent section blur, etc.
- Add-ons, which can enhance and add more functionality

### Compatibility
This module is expected to work on ROMs which are based on fairly unmodified Android source code.
- Android 13 AOSP-based ROMs

> WARNING: It may not work on some LOS-based ROMs like RiceDroid. If you face any crashes on these ROMs, please look thru the [troubleshooting section](#troubleshooting).

### Prerequisites
- Compatible ROMs (**AOSP-based custom ROMs** or **Google Pixel stock ROM**) based on Android 13.
- Device rooted by [Magisk latest stable](https://github.com/topjohnwu/Magisk/releases/latest).
- [LSPosed](https://github.com/LSPosed/LSPosed) *(optional, if you want to use double tap to sleep feature)*

**Disclaimer**
- Make sure you flashed the **Bootloop saver** module before flashing **Pixel Launcher Extended**. We **WON'T** be responsible if anything happens with your device. Bootloops are not expected, but you should always be prepared for the worst!

### Installation
- Uninstall any other launcher if you're using one. Only keep the default launcher
- Download the module installation file from [download links](#download-links) available
- Flash the file in Magisk and select your desired modifications using volume keys
- Reboot your device and go to **Settings** > **Apps** > **Default apps** > **Home app** and make sure **Pixel Launcher Extended** is selected

#### Variants
**Offline installer**  
It doesn't require internet while flashing, but it's 60+ MB in size.

**Online installer**  
It requires internet while flashing and downloads selected files by user during installation. It's less in size.

### Activating Double Tap to Sleep
- Make sure you installed DT2S while flashing the module
- After rebooting device, open LSPosed and enable **Pixel Launcher DT2S**
- Force-stop Pixel Launcher from Settings (or reboot device again)
- Double-tap once on home screen. Grant superuser permissions and enjoy

### Add-ons
These add-ons are optional & add extra functionality to Pixel Launcher Extended.

#### At A Glance Enhancer
This addon will enhance **At A Glance** and will enable new settings such as Doorbell, Timer, Stopwatch, Bedtime, Fitness tracker, Torch suggestion, Connected devices and much more.  
Made by [Pixelify](https://github.com/Kingsman44/Pixelify) developer, Kingsmanz. It also fixes the select feature, At A Glance weather if your ROM doesn't have proper GApps or due to some other reasons if you faced these issues.
- [Download](https://www.pling.com/p/1938895/)
- Flash in Magisk
- Reboot device
- Check out the new At A Glance settings. In most ROMs this will be the final step
  * If you didn't get the new settings, then force-stop the Google app and reboot your device
  * If you still didn't get those settings, uninstall updates of Google app and update from Play Store and reboot your device

**Credits**
- Made by [Kingsmanz](https://github.com/Kingsman44)
- [GitHub](https://github.com/Kingsman44/At-A-Glance-Enhancer)
- [Video showcase](https://graph.org/file/5cd90b41ec3563e69c62f.mp4)
- [Screenshots](https://graph.org/At-A-Glance-Enhancer-Screenshots-11-16)

#### Auto Universal Search Bar Enabler
If you don't get unified & universal search bar in Pixel Launcher Extended shown in these screenshots ([this](https://graph.org/file/ee8e311942af77de891c8.jpg) and [this](https://graph.org/file/dfe907c4aa1283a535aee.jpg)) then flash this module in Magisk. It will permanently enable universal search bar.  
> NOTICE: You will get this feature by default after flashing **Pixel Launcher Extended**.  
> Only in some ROMs, you won't get it. Flash only, **AND ONLY** if you don't get this feature.
- [Download](https://pling.com/p/1898907/)
- Flash in Magisk
- Reboot device

**Credits**
- [Looper](https://github.com/iamlooper)

## Download Links
- Mirror 1
- Mirror 2
- Mirror 3

**Download links will be available soon!**


### Troubleshooting
If you face any issues while using Pixel Launcher Extended then look into this section first before asking in support group at telegram.
- Weather widget on "At A Glance" or "Select Feature" of Pixel Launcher is not working? Then try updating Google App, Google Play Services, Android System Intelligence (ASI), Android System Webview, Google Calendar, Google Lens and all other Google apps from PlayStore. I will suggest you to use those roms that have pixel gapps by default.
- After trying above solution if it still doesn't work or if you are facing random crashes in launcher then download Add-On At [A Glance Enhancer](#Add-ons). It contains Android System Intelligence(Which will fix all these issues).
- If your rom has their own implementation of Monet/"Material You" and it's interfering with Pixel Launcher's Monet/Material You & due to it Material You isn't working properly & it's not changing color according to wallpaper then follow this:
  - [Download Termux](https://f-droid.org/en/packages/com.termux/). Open it & type the command given below & press enter. Give root access. After finishing this process, reboot the device once.
```bash
su -c settings delete secure theme_customization_overlay_packages
``` 
- You enabled “Hide Clock” from the Pixel Launcher Mods app? And now the clock isn't returning after disabling it. [Check this video](https://index.teamfiles.workers.dev/0:/clock%20fix.mp4) to fix this issue.
- If pixel launcher mods app stucked at loading screen or it's saying root not found even if you gave it root permission then force stop this app once to fix this issue.
- If pixel launcher crashes while going to recent tab then turn off Overview suggestions from pixel launcher's settings.
- If you don't see Pixel Launcher Extended in default home settings & only launcher showing there is Original pixel launcher then uninstall updates of original pixel launcher.
