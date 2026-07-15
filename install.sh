#!/bin/bash

# Exit immediately if any command exits with a non-zero status
set -e

echo "Starting installation..."

# 1. Detect Package Manager and Install Dependencies
if [ -x "$(command -v apt-get)" ]; then
    echo "Detected Debian/Ubuntu system..."
    sudo apt-get update
    sudo apt-get install -y fortune cowsay
elif [ -x "$(command -v dnf)" ]; then
    echo "Detected Fedora/RHEL system..."
    sudo dnf install -y fortune-mod cowsay
elif [ -x "$(command -v pacman)" ]; then
    echo "Detected Arch Linux system..."
    sudo pacman -S --noconfirm fortune-mod cowsay
elif [ -x "$(command -v brew)" ]; then
    echo "Detected macOS system..."
    brew install fortune cowsay
else
    echo "Error: Could not detect a supported package manager."
    exit 1
fi

# 2. Check for the existence of the source file
if [ ! -f "myfortune" ]; then
    echo "Error: 'myfortune' file not found in the current directory."
    exit 1
fi

# 3. Install the 'myfortune' command
echo "Installing 'myfortune' to /usr/local/bin..."
sudo cp myfortune /usr/local/bin/
sudo chmod +x /usr/local/bin/myfortune

echo "------------------------------------------"
echo "Installation complete!"
echo "You can now run the command by typing: myfortune"
