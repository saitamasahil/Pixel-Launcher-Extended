@echo off
setlocal

rem Read the version details from the module.prop file
for /f "usebackq tokens=3" %%a in (`findstr /r "^version=.*" module.prop`) do (
  set version=%%a
)

echo ^>^> Creating zip file

if exist "C:\Program Files\7-Zip\7z.exe" (
  "C:\Program Files\7-Zip\7z.exe" a -tzip "Pixel Launcher Extended %version%.zip" * -x!.git\* -x!ThemedIcons\* -x!screenshots\* -x!autobuild.bat -x!banner.jpg -x!banner2.jpg -x!codename.txt -x!logo.png -x!online_installer_setup.sh -x!README.md
) else if exist "C:\Program Files (x86)\7-Zip\7z.exe" (
  "C:\Tools\7z.exe" a -tzip "Pixel Launcher Extended %version%.zip" * -x!.git\* -x!ThemedIcons\* -x!screenshots\* -x!autobuild.bat -x!banner.jpg -x!banner2.jpg -x!codename.txt -x!logo.png -x!online_installer_setup.sh -x!README.md
) else (
  echo ERROR^: 7zip executable not found! Please install it from https://www.7-zip.org/download.html
  exit /b 1
)

echo.
echo ^>^> Done! You can find the zip file in the current directory - '%CD%\Pixel Launcher Extended %version%.zip'
