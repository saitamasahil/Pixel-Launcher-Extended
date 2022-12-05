@echo off
setlocal

echo ">> Creating zip file"

"C:\Program Files\7-Zip\7z.exe" a -tzip PixelLauncherExtended.zip * -x!.git\*

echo ""
echo ">> Done! You can find the zip file in the current directory - '%CD%/PixelLauncherExtended.zip'"
