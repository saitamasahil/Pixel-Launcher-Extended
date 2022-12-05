@echo off
setlocal

echo ">> Creating zip file"

7za a -tzip PixelLauncherExtended.zip * -x!.git\*

echo ""
echo ">> Done! You can find the zip file in the current directory - '%CD%/PixelLauncherExtended.zip'"
