#!/usr/bin/bash

# Define some color variables
GREEN='\033[1m\033[32m'
PURPLE='\033[1m\033[38;5;140m'
NC='\033[0m' # No Color

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

# This script adds the PLE function definition to the appropriate shell configuration file
# Get the name of the current shell
shell=$(basename "$SHELL")

# Check if the configuration file exists
if [ -f ~/."$shell"rc ]; then
  # Check if the PLE function is already defined in the file
  if grep -q "PLE ()" ~/."$shell"rc; then
    # Delete the existing PLE function
    sed -i '/PLE ()/,/^}/d' ~/."$shell"rc
  fi
  echo -e "${GREEN}PLE Builder has been successfully installed on your system.${NC}"
  echo -e "${PURPLE}To run PLE Builder, exit the terminal/termux, reopen it & type 'PLE'.${NC}"

  # Get the current working directory of the script
  pwd=$(pwd)

  # Append the function definition to the end of the file
  tail -c1 ~/."$shell"rc | read -r _ || echo "" >>~/."$shell"rc && cat >>~/."$shell"rc <<EOF
PLE () {
  # Go to the saved directory
  cd "$pwd"

  # Check if builder.sh exists
  if [ -f builder.sh ]; then
    chmod +x builder.sh && ./builder.sh
  else
    echo "PLE Builder is not available in your system"
  fi
}
EOF

else
  # Print an error message & make ."$shell"rc file
  echo -e "${PURPLE}."$shell"rc file not found.${NC}"
  echo -e "${GREEN}Fixing this issue.${NC}"
  sleep 3
  touch ~/."$shell"rc
  chmod +x builder_dependencies.sh && ./builder_dependencies.sh
fi
