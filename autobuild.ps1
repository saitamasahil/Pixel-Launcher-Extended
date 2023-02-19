$host.UI.RawUI.WindowTitle = "PLE Builder for Windows"


# ----------------------------------------------------------------------------------
#
# PLE Builder for Windows
# Based on Powershell, made by Naoko Shoto
# PLE made by TeamFiles
#
# ----------------------------------------------------------------------------------
# IF YOU'RE REGULAR USER AND SEE THIS
# YOU PROBABLY NOT RUN THIS AS POWERSHELL SCRIPT
# RUN THIS FILE AS POWERSHELL TO USE THE BUILDER
# ----------------------------------------------------------------------------------

Write-Host "Checking Dependencies..."
Write-Host ""

Start-Sleep -Seconds 0.5


if ((Get-PackageProvider -Name NuGet).version -lt 2.8.5.201 ) {
  try {
      Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Confirm:$False -Force 
  }
  catch [Exception]{
      $_.message 
      exit
  }
}
else {
  Write-Host "Version of NuGet installed = " (Get-PackageProvider -Name NuGet).version
  Write-Host ""
}

Start-Sleep -Seconds 0.5

if (Get-Module -ListAvailable -Name PSMenu) {
  Write-Host "Menu Handler Already Installed, Skipping..."
  Write-Host ""
} 
else {
  Write-Host "Installing Menu Handler..."
  try {
    Install-Module -Name PSMenu -Scope CurrentUser -AllowClobber -Confirm:$False -Force
    Import-Module PSMenu 
    Write-Host "Successfully Install Menu Handler!"
    Write-Host ""
  }
  catch [Exception] {
      $_.message 
      exit
  }
}

Start-Sleep -Seconds 0.5

if ((Get-Module -ListAvailable -Name 7Zip4Powershell)) {
  Write-Host "7Zip Handler Already Installed, Skipping..."
  Write-Host ""
} 
else {
  Write-Host "Installing 7Zip Handler..."
  try {
    Install-Module -Name 7Zip4Powershell -Scope CurrentUser -Repository PSGallery -AllowClobber -Confirm:$False -Force  
    Write-Host "Successfully Install 7Zip Handler!"
    Write-Host ""
  }
  catch [Exception] {
      $_.message 
      exit
  }
}
Import-Module 7Zip4Powershell
if ((Test-Path -Path ".\ple_build\temp\7z\7za.exe")){
  Write-Host "7Zip Already Downloaded, Skipping..."
  Write-Host ""
}
else {
  mkdir ple_build\temp > $null
  Write-Host "Trying to Download 7Zip..."
  try {
    do {

    } while (Invoke-WebRequest -URI "https://www.7-zip.org/a/7z2201-extra.7z" -OutFile ".\ple_build\7z.7z")
    Expand-7Zip -ArchiveFileName ".\ple_build\7z.7z" -TargetPath ".\ple_build\temp\7z"
    Write-Host "Successfully Downloaded 7Zip!"
    Write-Host ""
  }
  catch [Exception] {
    $_.message 
    exit
  }
}
$CurrentDirectory = Get-Location
$propread = Get-Content -Raw .\module.prop | ConvertFrom-StringData
$version = $propread.version

Start-Sleep -Seconds 2.5



# ----------------------------------------------------------------------------------
#
# Fancy Title functions
#
# ----------------------------------------------------------------------------------
function MakeTop
{
    $string = '/='
    for($i = 0; $i -lt $Host.UI.RawUI.BufferSize.Width - 4; $i++)
    {
        $string = $string + '='
    }
    $string = $string + '=\'

    return $string
}
function MakeMiddel
{
    $string = '|='
    for($i = 0; $i -lt $Host.UI.RawUI.BufferSize.Width - 4; $i++)
    {
        $string = $string + '='
    }
    $string = $string + '=|'

    return $string
}
function MakeButtom
{
    $string = "\="
    for($i = 0; $i -lt $Host.UI.RawUI.BufferSize.Width - 4; $i++)
    {
        $string = $string + "="
    }
    $string = $string + "=/"

    return $string
}

function MakeSpaces
{
    $string = "| "
    for($i = 0; $i -lt $Host.UI.RawUI.BufferSize.Width - 4; $i++)
    {
        $string = $string + " "
    }
    $string = $string + " |"
    return $string
}

function CenterText
{
    param($Message)

    $string = "| "

    for($i = 0; $i -lt (([Math]::Max(0, $Host.UI.RawUI.BufferSize.Width / 2) - [Math]::Max(0, $Message.Length / 2))) - 4; $i++)
    {
        $string = $string + " "
    }

    $string = $string + $Message

    for($i = 0; $i -lt ($Host.UI.RawUI.BufferSize.Width - ((([Math]::Max(0, $Host.UI.RawUI.BufferSize.Width / 2) - [Math]::Max(0, $Message.Length / 2))) - 2 + $Message.Length)) - 2; $i++)
    {
        $string = $string + " "
    }

    $string = $string + " |"
    return $string

}

$MakeTop = MakeTop
$MakeMiddel = MakeMiddel
$MakeButtom = MakeButtom
$MakeSpaces = MakeSpaces

# ----------------------------------------------------------------------------------
#
# Fancy Title functions
#
# ----------------------------------------------------------------------------------
function MakeTitle {
  Clear-Host
  $MakeTop
  $MakeSpaces 
  CenterText "  ___ _    ___   ___      _ _    _         "
  CenterText " | _ | |  | __| | _ )_  _(_| |__| |___ _ _ "
  CenterText " |  _| |__| _|  | _ | || | | / _\` / -_| '_|"
  CenterText " |_| |____|___| |___/\_,_|_|_\__,_\___|_|  "
  CenterText "                                           "
  CenterText "Pixel Launcher Extended $($version)"
  $MakeSpaces 
  $MakeButtom
  Write-Host ""
}

# ----------------------------------------------------------------------------------
#
# Fancy Menu functions
#
# ----------------------------------------------------------------------------------

class MyMenuOption {
  [String]$DisplayName
  [ScriptBlock]$Script

  [String]ToString() {
      Return $This.DisplayName
  }
}

function New-MenuItem([String]$DisplayName, [ScriptBlock]$Script) {
  $MenuItem = [MyMenuOption]::new()
  $MenuItem.DisplayName = $DisplayName
  $MenuItem.Script = $Script
  Return $MenuItem
}

# ----------------------------------------------------------------------------------
#
# Handle input
#
# ----------------------------------------------------------------------------------
function offlineBuild ()
{
  MakeTitle
  Write-Host "You selected Offline Installer!"
  Write-Host ""
  if(Test-Path -Path ".\Pixel Launcher Extended *.zip" -PathType Leaf) { Remove-Item ".\Pixel Launcher Extended *.zip" }
  if(Test-Path -Path ".\setup.sh" -PathType Leaf) { Remove-Item ".\setup.sh" }
  Start-Sleep -Seconds 0.5
  Copy-Item ".\offline_setup.sh" ".\setup.sh"
  Start-Sleep -Seconds 0.5
  if((Test-Path -Path ".\system" -PathType Leaf) -OR (Test-Path -Path ".\setup.sh" -PathType Leaf))
  {
    Write-Host "Building..."
    try {
      Invoke-Command -ScriptBlock { 
        .\ple_build\temp\7z\7za.exe a -tzip "Pixel Launcher Extended Offline Installer $version.zip" ./* -xr!'.*' -xr!'Modifications' -xr!'ThemedIcons' -xr!'screenshots' -xr!'Pixel Launcher Extended*' -xr!'autobuild.*' -xr!'banner*' -xr!'changelog.md' -xr!'codename.txt' -xr!'logo.*' -xr!'*_setup.sh' -xr!'README.md' -xr!'ple_build' -m'm=deflate' -m'x=1' -aoa -bsp1 -bso0
      } | out-string -stream | Select-String -Pattern "\d{1,3}%" -AllMatches | ForEach-Object { $_.Matches.Value } | foreach {
        [System.Console]::SetCursorPosition(0, [System.Console]::CursorTop) 
        Write-Host "> Progress:" $_ -NoNewLine
        }
        [System.Console]::SetCursorPosition(0, [System.Console]::CursorTop) 
        Write-Host "> Progress:" 100%
      Write-Host ""
      Start-Sleep -Seconds 0.5
      MakeTitle
      Write-Host "Building success!" 
      Write-Host ""
      Write-Host "  You can see at $CurrentDirectory\Pixel Launcher Extended Offline Installer $version.zip"
    }
    catch [Exception]{
      $_.message 
      exit
    }
    Write-Host ""
    Write-Host "Press any key to exit..." -NoNewline -ForegroundColor Green
    Read-Host 
    Remove-Item '.\setup.sh'
  } else {
    Write-Host "Error: Current directory is not valid. Make sure that you are in the right directory and try again."
    exit
  }
}
function onlineBuild()
{
  MakeTitle
  Write-Host "You selected Online Installer!"
  Write-Host ""
  if(Test-Path -Path ".\Pixel Launcher Extended *.zip" -PathType Leaf) { Remove-Item ".\Pixel Launcher Extended *.zip" }
  if(Test-Path -Path ".\setup.sh" -PathType Leaf) { Remove-Item ".\setup.sh" }
  Start-Sleep -Seconds 0.5
  Copy-Item ".\online_setup.sh" ".\setup.sh"
  Start-Sleep -Seconds 0.5
  if((Test-Path -Path ".\system" -PathType Leaf) -OR (Test-Path -Path ".\setup.sh" -PathType Leaf))
  {
    Write-Host "Building..."
    try {
      Invoke-Command -ScriptBlock { 
        .\ple_build\temp\7z\7za.exe a -tzip "Pixel Launcher Extended Online Installer $version.zip" ./* -xr!'.*' -xr!'Addons'  -xr!'Modifications' -xr!'ThemedIcons' -xr!'screenshots' -x!'system\product\priv-app\NexusLauncherRelease\*' -x!'system\product\priv-app\PixelLauncherMods\PixelLauncherMods.apk' -x!'system\product\overlay\ThemedIconsOverlay\*' -x!'system\system_ext\priv-app\WallpaperPickerGoogleRelease\WallpaperPickerGoogleRelease.apk' -x!'system\system_ext\priv-app\WallpaperPickerGoogleRelease\WallpaperPickerGoogleReleaseNew.apk' -x!'system\product\overlay\TeamFiles*' -x!'system\product\priv-app\ExtendedSettings\ExtendedSettings.apk' -xr!'Pixel Launcher Extended*' -xr!'autobuild.*' -xr!'banner*' -xr!'changelog.md' -xr!'codename.txt' -xr!'logo.*' -xr!'*_setup.sh' -xr!'README.md' -xr!'ple_build' -m'm=deflate' -m'x=1' -aoa -bsp1 -bso0
      } | out-string -stream | Select-String -Pattern "\d{1,3}%" -AllMatches | ForEach-Object { $_.Matches.Value } | foreach {
        [System.Console]::SetCursorPosition(0, [System.Console]::CursorTop) 
        Write-Host "> Progress:" $_ -NoNewLine
        }
        [System.Console]::SetCursorPosition(0, [System.Console]::CursorTop) 
        Write-Host "> Progress:" 100%
      Write-Host ""
      Write-Host "Building success!" 
      Write-Host ""
      Write-Host "  You can see at $CurrentDirectory\Pixel Launcher Extended Online Installer $version.zip"
    }
    catch [Exception]{
      $_.message 
      exit
    }
    Write-Host ""
    Write-Host "Press any key to exit..." -NoNewline -ForegroundColor Green
    Read-Host 
    Remove-Item '.\setup.sh'

  } else {
    Write-Host "Error: Current directory is not valid. Make sure that you are in the right directory and try again."
    exit
  }
}
function customBuild( $args )
{
  MakeTitle
  Write-Host "You selected Customized Installer!"
  Write-Host ""
  Write-Host "    Customized Installer is not ready yet and will be coming soon!" -ForegroundColor Red
  Write-Host ""
  Write-Host "Press any key to continue..." -NoNewline -ForegroundColor Green
  Read-Host 
  mainmenu
  # Write-Host "    WARNING!!! This feature is experimental, things may not work properly as intended." -ForegroundColor Red
  # Write-Host "Press any key to continue..." -NoNewline -ForegroundColor Green
  # Read-Host 
  # Write-Host ""
  # Copy-Item ".\customize_setup.sh" ".\setup.sh"
  # if((Test-Path -Path ".\system" -PathType Leaf) -OR (Test-Path -Path ".\setup.sh" -PathType Leaf))
  # {
  #   MakeTitle
  #   Write-Host "    Which Android Version that you use?"
  #   $Opts = @(
  #       $(New-MenuItem -DisplayName "Android 13 (November Security Patch or below)" -Script { $android="13n" }),
  #       $(New-MenuItem -DisplayName "Android 13 (December Security Patch or higher)" -Script { $android="13d" })

  #   )

  #   $UserInput = Show-Menu -MenuItems $Opts

  #   & $UserInput.Script

  #   MakeTitle
  #   Write-Host "    Do you want to install Extra Grids in Launcher?"
  #   $Opts = @(
  #       $(New-MenuItem -DisplayName "Yes" -Script { $xg="1" }),
  #       $(New-MenuItem -DisplayName "No" -Script { $xg="0" })

  #   )

  #   $UserInput = Show-Menu -MenuItems $Opts

  #   & $UserInput.Script

  #   Write-Host "Building..."

  #   Write-Host "Press any key to exit..." -NoNewline -ForegroundColor Green | Read-Host 

  # } else {
  #   Write-Host "Error: Current directory is not valid. Make sure that you are in the right directory and try again."
  #   exit
  # }

  # Write-Host "Press any key to exit..." -NoNewline -ForegroundColor Green | Read-Host 

}

# ----------------------------------------------------------------------------------
#
# Run
#
# ----------------------------------------------------------------------------------


function mainmenu( ) {
  MakeTitle
  Write-Host "Choose installer that you wanted to build:"
  Write-Host ""
  $Opts = @(
      $(New-MenuItem -DisplayName "Offline Installer" -Script { offlineBuild }),
      $(New-MenuItem -DisplayName "Online Installer" -Script { onlineBuild }),
      $(New-MenuItem -DisplayName "Customized Installer | Coming Soon" -Script { customBuild }),
      $(Get-MenuSeparator),
      $(New-MenuItem -DisplayName "Exit" -Script { exit })

  )

  $UserInput = Show-Menu -MenuItems $Opts

  & $UserInput.Script
}

mainmenu