# How To Use & Flash Manual Installer

- After making/downloading manual installer zip keep it in your phone's internal storage or sdcard.
- [Download MT Manager](https://m.apkpure.com/mt-manager/bin.mt.plus) & install it.
> It is recommended to use MT Manager only. You can use other file managers or zip utilities too but with MT Manager, you don't need to unpack zip file to edit it.
- Open the zip file using MT Manager & Click **config.txt** file to open it in text editor.
- In the text editor config.txt file will look like this:
```sh
1. LAUNCHER=
2. DT2S=
3. Pixel_Launcher_Mods_App=
4. Icon_Shape_Changer_App=
5. # Don't modify anything after this
```
- In lines 1-4 you can see variables with the name of **LAUNCHER**, **DT2S**, **Pixel_Launcher_Mods_App** & **Icon_Shape_Changer_App**. We need to add some values of these variables in order to modify the installer & get desired modifications in PLE. The following are the instructions for editing config.txt.

### Editing config.txt

#### Line 1: LAUNCHER Variable
We need to keep this variable like this: `LAUNCHER=xy`, where each different values of x & y define something.

Value of x:
- If x=0, then launcher doesn't have any material you glance greetings.
- If x=1, then launcher contains material you glance greetings style 1.
- If x=2, then launcher contains material you glance greetings style 2.
  - Example Of Glance Greetings Style 1:
    ```ss
    Line 1 - Material You Greetings
    Line 2 - Day & Date
    Line 3 - Weather Information
    ```
  - Example Of Glance Greetings Style 2:
    ```ss
    Line 1 - Material You Greetings, Day & Date
    Line 2 - Weather Information
    ```

Value of y:
- If y=0, then launcher is for Android 13. Android 13 - November security patch or below.
- If y=1, then launcher is for Android 13 QPR. Android 13 QPR - December to February security patch.
- If y=2, then launcher is for Android 13 QPR2. Android 13 QPR2 - March security patch or above.

So, now we have defined values of x & y. We need to put these values in config.txt. Suppose you want **glance greetings style 1**  and using **Android 13 QPR2** then `the value x will be 1` & `the value of y will be 2`. So, we will edit config.txt like this:
```sh
1. LAUNCHER=12
```

#### Line 2: DT2S Variable
DT2S Means - Double Tap To Sleep Feature. It requires LSPosed Installed in your rom. Without LSPosed it won't work. Read Documentation on GitHub to know more about activating it. Set this variable to 1 to enable it, or 0 to ignore it. Suppose you don't wanna enable DT2S feature in your rom then `the value of variable will be 0`. So, we will edit config.txt like this:
```sh
2. DT2S=0
```

#### Line 3: Pixel_Launcher_Mods_App Variable
It's an app made by Developer [KieronQuinn](https://github.com/KieronQuinn). You will be able to apply Icon Packs using it. It will also enable some more functionality to pixel launcher. Set this variable to 1 to install it, or 0 to ignore it. Suppose you want to install this app in your rom then `the value of variable will be 1`. So, we will edit config.txt like this:
```sh
3. Pixel_Launcher_Mods_App=1
```
#### Line 4: Icon_Shape_Changer_App Variable
This app can change shape of the icons in PLE. Set this variable to 1 to install it, or 0 to ignore it. Suppose you want to install this app in your rom then `the value of variable will be 1`. So, we will edit config.txt like this:
```sh
4. Icon_Shape_Changer_App=1
```

After editing all variables, config.txt will look like this:
```sh
1. LAUNCHER=12
2. DT2S=0
3. Pixel_Launcher_Mods_App=1
4. Icon_Shape_Changer_App=1
5. # Don't modify anything after this
```
Save it, go back. MT Manager will ask you to update the zip. Click OK & flash the zip in magisk.
> Note: You can edit config.txt file again to choose different modifications & installation options by editing variables and flash it again in magisk.
