## Pixel Launcher Extended Documentation

![Header Image](https://raw.githubusercontent.com/saitamasahil/Pixel-Launcher-Extended/main/banner.jpg)

**Pixel Launcher Extended** is a Magisk module by **TeamFiles** with many cool features compared to original Pixel Launcher by Google.

### Features
- Extra themed icon packs support. Total of 6 icon packs for your favourite apps and games. This feature is currently in beta due to Android 13 restrictions. Android 13 prefers themed icons made by apps and then it looks for themed icons overlay(which we use). TeamFiles icons are very closed to stock themed icons. So, we recommend using them.
- More grids options, total of 14 grids. You can select these extra grids by going to **Wallpaper & style** > **App grid**.
- Double tap to sleep *(LSPosed required)*.
- You can choose different icons shapes while installing. Total of 16 icons shapes.
- Material You At A Glance greetings.
- [Pixel Launcher Mods](https://github.com/KieronQuinn/PixelLauncherMods) by KieronQuinn. It has many cool features such as icon pack changer, recent section blur, etc.
- Add-ons, which can enhance and add more functionality.

### Compatibility
This module is expected to work on ROMs which are based on fairly unmodified Android source code.
- Android 13 AOSP-based ROMs

> WARNING: It may not work on some LOS-based ROMs like RiceDroid. If you face any crashes on these ROMs, please look through the [troubleshooting section](#troubleshooting).

### Prerequisites
- Compatible ROMs (**AOSP-based custom ROMs** or **Google Pixel stock ROM**) based on Android 13.
- Device rooted by [Magisk latest stable](https://github.com/topjohnwu/Magisk/releases/latest).
- [LSPosed](https://github.com/LSPosed/LSPosed) *(optional, if you want to use double tap to sleep feature)*
##### Note
- The module isn't compatiable with **Android 13 QPR Beta Builds** yet. Soon we will add support for it.

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

### Uninstallation
- Simply uninstall module from magisk

### How to update
- When there is new update available simply flash new version in magisk without removing previous version.
- If you have flashed latest version already & now wanna select different choices while flashing. You can flash module again without removing/uninstalling existed module.

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

#### Enable App Hide Feature
You can enable the app hide feature in Pixel Launcher by using a third party app called **Pixel Mods**. **LSPosed** is required for this add-on.
- Install [Pixel Mods App](https://play.google.com/store/apps/details?id=com.metris.xposed.pmods) from here
- Open LSPosed and click **Pixel Mods** from modules section. Toggle **Enable Module** & make sure **Pixel Launcher** has ticked
- Reboot Device
- You can access  **Hide Apps Feature** by pressing hold on empty space on Homescreen

#### Wallpaper Zoom Effect Enabler & Disabler
If you want to enable or disable wallpaer zoom effect then use this add-on.
- [Download](https://index.teamfiles.workers.dev/0:/WallZoomAddon/)
- Flash in Magisk
- Reboot device

**Credits**
- [xdsolraC](https://telegram.me/xdsolraC)

## Download Links
- Mirror 1
- Mirror 2
- Mirror 3

**Download links will be available soon!**

### How To Build

If you don't wanna download direct module zip from above links then you can make your own module zip.

#### For Windows
- Make sure 7-Zip is installed in your windows pc. [Download 7-Zip](https://www.7-zip.org/) from here if you haven't already.
- Clone Repo.
- Run autobuild.bat.

#### For Ubuntu, Debian & Other Linux Based Operating Systems
- First install zip tool. On Ubuntu & Debian you can use following command to install it.
```sh
sudo apt-get install zip
```
- Now clone the repo using git.
```sh
git clone https://github.com/saitamasahil/Pixel-Launcher-Extended
```
- Now go to **Pixel-Launcher-Extended** folder.
```sh
cd Pixel-Launcher-Extended
```
- Run autobuild.sh.
```sh
bash autobuild.sh
```

#### For Termux
If you are using Termux on Android then
- Open Termux. Copy paste this command
```sh
pkg upgrade 
pkg update
pkg install zip git
git clone https://github.com/saitamasahil/Pixel-Launcher-Extended
cd Pixel-Launcher-Extended
bash autobuild.sh
mv PixelLauncherExtended.zip /storage/emulated/0
```
- You will get magisk module in internal storage.

## Troubleshooting
If you face any issues while using Pixel Launcher Extended then look into this section first before asking in support group on Telegram.

### Weather widget in At A Glance or Select feature in recent tabs not working
Try updating Google App, Google Play Services, Android System Intelligence (ASI), Android System Webview, Google Calendar, Google Lens and all other Google apps from Play Store. We suggest you to use ROMs that have stock Pixel GApps by default.
After trying above solution if it still doesn't work or if you are facing random crashes in launcher then download [At A Glance Enhancer add-on](#at-a-glance-enhancer). It contains Android System Intelligence (which may fix all these issues).

### Material You isn't working properly, it's not changing color according to wallpaper
Your ROM may have its own implementation of Material You and that may be interfering with Pixel Launcher Extended.

To fix this issue, please follow these steps:
- [Download Termux](https://f-droid.org/en/packages/com.termux/)
- Open it and type the command given below and press enter
```sh
su -c settings delete secure theme_customization_overlay_packages
``` 
- Grant superuser permissions
- Reboot your device

### Enabled “Hide Clock” from the Pixel Launcher Mods app and now the clock isn't returning
[Watch this video](https://index.teamfiles.workers.dev/0:/clock%20fix.mp4) for instructions to fix this issue.

### Pixel Launcher Mods stuck at loading screen or showing error
Force-stop the app and relaunch.

### Pixel Launcher Extended crashes while going to recent tab
Turn off **Overview suggestions** from Pixel Launcher's settings.

### Pixel Launcher Extended not showing in default home settings
Uninstall updates of the Pixel Launcher app and reboot your device.

### Credits/Thanks
- Google
- [LiArch55](http://telegram.me/LiArch55)
- [saitamasahil](https://github.com/saitamasahil)
- [iamlooper](https://github.com/iamlooper/)
- [KieronQuinn](https://github.com/KieronQuinn)
- [uragiristereo](https://github.com/uragiristereo)
- [Monet Icons Team](https://teamfiles.net/about_monet-team.html)
- [siavash79](https://github.com/siavash79)
- [Kingsman44](https://github.com/Kingsman44)
- [anarchist22](https://telegram.me/anarchist22)
- [WaifuPX-DG](https://github.com/WaifuPX-DG)
- [LawnchairLauncher](https://github.com/LawnchairLauncher)
- [RadekBledowski](https://github.com/RadekBledowski)
- [PalmDevs](https://github.com/PalmDevs)
- [agam778](https://github.com/agam778)
- [atharvap8](https://github.com/atharvap8)
- [jaaat4u](https://github.com/jaaat4u)

Brought to you by [TeamFiles](https://github.com/TeamFiles)


### Contact us
[![TeamFiles Telegram](https://img.shields.io/badge/Telegram-TeamFiles-%2326A5E4?logo=Telegram)](https://telegram.me/filesfederation)

[![Modules Repository](https://img.shields.io/badge/Telegram-Modules%20Repository-%2326A5E4?logo=Telegram)](https://telegram.me/modulesrepo)

[![Support Group](https://img.shields.io/badge/Telegram-Support%20Group-%2326A5E4?logo=Telegram)](https://telegram.me/fileschat)
