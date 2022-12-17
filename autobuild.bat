@echo off
setlocal

@REM Read the version details from the module.prop file
for /f "tokens=2 delims=<> " %%a in ('find "version=Version" ^< "module.prop" ') do set version=%%a

echo ^>^> Renaming offline_setup.sh to setup.sh
ren offline_setup.sh setup.sh

echo ^>^> Creating zip file

if exist "C:\Program Files\7-Zip\7z.exe" (
  "C:\Program Files\7-Zip\7z.exe" a -tzip "Pixel Launcher Extended Version %version%.zip" * -x!.git\* -x!ThemedIcons\* -x!screenshots\* -x!autobuild.bat -x!banner.jpg -x!banner2.jpg -x!changelog.md -x!codename.txt -x!logo.png -x!online_setup.sh -x!README.md
) else if exist "C:\Program Files (x86)\7-Zip\7z.exe" (
  "C:\Tools\7z.exe" a -tzip "Pixel Launcher Extended Version %version%.zip" * -x!.git\* -x!ThemedIcons\* -x!screenshots\* -x!autobuild.bat -x!banner.jpg -x!banner2.jpg -x!changelog.md -x!codename.txt -x!logo.png -x!online_setup.sh -x!README.md
) else (
  echo ERROR^: 7zip executable not found! Please install it from https://www.7-zip.org/download.html
  exit /b 1
)

echo.
echo ^>^> Done! You can find the zip file in the current directory - '%CD%\Pixel Launcher Extended Version %version%.zip'
