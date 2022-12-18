# Pixel Launcher Extended

![Header Image](https://raw.githubusercontent.com/saitamasahil/Pixel-Launcher-Extended/main/banner2.jpg)

**Pixel Launcher Extended** is a Magisk module by **TeamFiles** with many cool features compared to original Pixel Launcher by Google.

### Features
- Extra themed icon packs support. Total of 6 icon packs for your favourite apps and games **(BETA)**.
> **This feature is currently in beta due to Android 13 restrictions**  
> Android 13 prefers themed icons made by apps, it looks through the apps first, only then it looks for themed icons overlay (which we use).  
> TeamFiles icons are very closed to stock themed icons, so we recommend using them.
- More grids options, total of 14 grids. You can select these extra grids by going to **Wallpaper & style** > **App grid**. These are available for **Phones** only. Not available for **Tablets**.
- Double tap to sleep *(LSPosed required)*.
- You can choose different icons shapes while installing. Total of 17 icons shapes.
- Material You At A Glance greetings.
- [Pixel Launcher Mods](https://github.com/KieronQuinn/PixelLauncherMods) by KieronQuinn. It has many cool features such as icon pack changer, recent section blur, etc.
- Add-ons, which can enhance and add more functionality.

### Compatibility
This module is expected to work on ROMs which are based on fairly unmodified Android source code.
- Android 13 AOSP-based ROMs
- Android 13 QPR AOSP-based ROMs

> WARNING: It may not work on some LOS-based ROMs like RiceDroid. If you face any crashes on these ROMs, please look through the [troubleshooting section](#troubleshooting).

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
It doesn't require internet while flashing, but it's 100+ MB in size.

**Online installer**  
It requires internet while flashing and downloads only selected files by user during installation. It's less than 5 MB in size. Depending upon your internet this variant may take more time in flashing compared to offline installer.

### Activating Double Tap to Sleep
- Make sure you installed DT2S while flashing the module
- After rebooting device, open LSPosed and enable **Pixel Launcher DT2S**
- Force-stop Pixel Launcher from Settings (or reboot device again)
- Double-tap once on home screen. Grant superuser permissions and enjoy

### Uninstallation
- Simply uninstall module from Magisk

### Updating
- When there is new update available, simply flash newer version in Magisk without removing previous version
- If you have flashed latest version already and want to select different choices while flashing, you can always flash module again without removing/uninstalling existing module

### Add-ons
These are optional add-ons, they add extra functionality to Pixel Launcher Extended.

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

#### Hide Apps Feature
You can enable the hide app feature in Pixel Launcher by using a third-party app called **Pixel Mods**. *(**LSPosed** is required for this add-on)*.
- Install the [Pixel Mods App](https://play.google.com/store/apps/details?id=com.metris.xposed.pmods)
- Open LSPosed and click **Pixel Mods** from modules section. Toggle **Enable Module** and make sure **Pixel Launcher** has ticked
- Reboot device
- Check out the **Hide Apps Feature** by pressing hold on empty space on home screen

#### Wallpaper Zoom Effect Enabler & Disabler
If you want to enable or disable wallpaer zoom effect then use this add-on.
- [Download](https://index.teamfiles.workers.dev/0:/WallZoomAddon/)
- Flash in Magisk
- Reboot device

**Credits**
- [xdsolraC](https://telegram.me/xdsolraC)

## Download Links
- [Mirror 1](https://www.pling.com/p/1952604)
- [Mirror 2](https://store.kde.org/p/1952604)
- [Mirror 3](https://www.opendesktop.org/p/1952604)

## Building from source

If you don't want to download built module from mirrors above, then you can build magisk module yourself.

### For Windows
- Make sure 7-Zip is installed in your Windows PC. Download [7-Zip](https://www.7-zip.org/) from here
- Clone the repository with [GitHub Desktop](https://desktop.github.com) or using git clone on WSL 2
```bat
:: ONLY RUN THIS IF YOU USE GIT AND HAVE IT INSTALLED
git clone https://github.com/saitamasahil/Pixel-Launcher-Extended
```
- Run `autobuild.bat`
- Don't use git in command-line or powershell to clone repo. Some users reported that it's corrupting contents.
- Currently it supports making of **offline installer**. Making of **online installer** will be added later.

### For Ubuntu, Debian, and other Linux distributions
- Required **zip** package install command is in the script itself. Still, If you face any error then install **zip** manually. On Ubuntu or Debian you can use the following command to install it.
```sh
sudo apt install zip
```
- Now clone the repo using git.
```sh
git clone https://github.com/saitamasahil/Pixel-Launcher-Extended
```
- Navigate to the **Pixel-Launcher-Extended** folder.
```sh
cd Pixel-Launcher-Extended
```
- Run autobuild.sh for making offline installer.
```sh
bash autobuild.sh
```
- Run autobuild_online.sh for making online installer.
```sh
bash autobuild_online.sh
```

### For Termux
- Open Termux, copy & paste this command to make offline installer
```sh
pkg upgrade || true
pkg install -y zip git
git clone https://github.com/saitamasahil/Pixel-Launcher-Extended
cd Pixel-Launcher-Extended
bash autobuild.sh
termux-setup-storage
mv Pixel\ Launcher\ Extended* /sdcard
```
- To make online installer, copy & paste this command
```sh
pkg upgrade || true
pkg install -y zip git
git clone https://github.com/saitamasahil/Pixel-Launcher-Extended
cd Pixel-Launcher-Extended
bash autobuild_online.sh
termux-setup-storage
mv Pixel\ Launcher\ Extended* /sdcard
```
- Please make sure to grant storage permissions, if Termux asks you to do so
- You will get Magisk module in your internal storage
- Use [Termux From F-Droid](https://f-droid.org/en/packages/com.termux/) to perform these tasks.
- If you get this warning "It appears that directory '~/storage' already exists.
This script is going to rebuild its structure from
scratch, wiping all dangling files. The actual storage
content IS NOT going to be deleted" then just do press "y". It won't do any harm to your device.

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
- Don't reboot as after reboot you will have to apply these changes again(blame your rom)

### Enabled “Hide Clock” from the Pixel Launcher Mods app and now the clock isn't returning
[Watch this video](https://index.teamfiles.workers.dev/0:/clock%20fix.mp4) for instructions to fix this issue.

### Pixel Launcher Mods stuck at loading screen or showing error
Force-stop the app and relaunch.

### Pixel Launcher Extended crashes while going to recent tab
Turn off **Overview suggestions** from Pixel Launcher's settings.

### Pixel Launcher Extended not showing in default home settings
Uninstall updates of the Pixel Launcher app and reboot your device.

## Credits/Thanks
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
- [selfmusing](https://github.com/selfmusing)

Brought to you by [TeamFiles](https://github.com/TeamFiles)!


## Contact us
[![TeamFiles Telegram](https://img.shields.io/badge/Telegram-TeamFiles-%2326A5E4?logo=Telegram)](https://telegram.me/filesfederation)

[![Modules Repository](https://img.shields.io/badge/Telegram-Modules%20Repository-%2326A5E4?logo=Telegram)](https://telegram.me/modulesrepo)

[![Support Group](https://img.shields.io/badge/Telegram-Support%20Group-%2326A5E4?logo=Telegram)](https://telegram.me/fileschat)
