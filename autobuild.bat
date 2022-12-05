@echo off
setlocal

echo ^>^> Creating zip file

if exist "C:\Program Files\7-Zip\7z.exe" (
  "C:\Program Files\7-Zip\7z.exe" a -tzip PixelLauncherExtended.zip * -x!.git\*
) else if exist "C:\Program Files (x86)\7-Zip\7z.exe" (
  "C:\Tools\7z.exe" a -tzip PixelLauncherExtended.zip * -x!.git\*
) else (
  echo ERROR^: 7zip executable not found! Please install it from https://www.7-zip.org/download.html
  exit /b 1
)

echo.
echo ^>^> Done! You can find the zip file in the current directory - '%CD%\PixelLauncherExtended.zip'
