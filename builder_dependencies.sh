#!/usr/bin/bash

# Check for the Distro Type & Install necessary packages

PACKAGE_MANAGERS=("pkg" "apt" "yum" "dnf" "pacman" "zypper")
PACKAGES=("zip" "git")

# Define a function to check if a package is installed
check_package() {
  if command -v "$1" >/dev/null; then
    return 0
  else
    return 1
  fi
}

# Loop through the packages and check if they are installed
for PKG in "${PACKAGES[@]}"; do
  check_package "$PKG"
  # If not installed, add it to a list of packages to install
  if [ $? -ne 0 ]; then
    TO_INSTALL+=("$PKG")
  fi
done

# If there are no packages to install then just print all packages are already installed
if [ ${#TO_INSTALL[@]} -eq 0 ]; then
  echo "Required packages are already installed."
fi

# Loop through the package managers and find the one that is available
for PM in "${PACKAGE_MANAGERS[@]}"; do
  if command -v "$PM" >/dev/null; then
    # Use the appropriate command to install the packages
    case "$PM" in
    "pkg") pkg install "${TO_INSTALL[@]}" ;;
    "apt") sudo apt-get install "${TO_INSTALL[@]}" ;;
    "yum") sudo yum install "${TO_INSTALL[@]}" ;;
    "dnf") sudo dnf install "${TO_INSTALL[@]}" ;;
    "pacman") sudo pacman -S --needed "${TO_INSTALL[@]}" ;;
    "zypper") sudo zypper install "${TO_INSTALL[@]}" ;;
    esac
    break
  fi
done

# If the distribution is Fedora, use dnf to install the packages
if [ -f /etc/fedora-release ]; then
  sudo dnf install "${TO_INSTALL[@]}"
fi

# Install latest version of figlet, As most distros come with very old version
echo "Checking updates for figlet..."
case "$PM" in
"pkg") pkg install figlet ;;
"apt") sudo apt-get install figlet ;;
"yum") sudo yum figlet ;;
"dnf") sudo dnf figlet ;;
"pacman") sudo pacman -S --needed figlet ;;
"zypper") sudo zypper install figlet ;;
esac

# If the distribution is Fedora, use dnf to install figlet
if [ -f /etc/fedora-release ]; then
  sudo dnf install figlet
fi
