#!/bin/bash
set -e

echo "Starting installation..."

# 1. Detect Package Manager and Install Dependencies
if [ -x "$(command -v apt-get)" ]; then
    sudo apt-get update
    sudo apt-get install -y fortune-mod cowsay
elif [ -x "$(command -v dnf)" ]; then
    sudo dnf install -y fortune-mod cowsay
elif [ -x "$(command -v pacman)" ]; then
    sudo pacman -S --noconfirm fortune-mod cowsay
elif [ -x "$(command -v brew)" ]; then
    brew install fortune cowsay
else
    echo "Error: Could not detect a supported package manager."
    exit 1
fi

# 2. Download 'myfortune' directly to the destination
echo "Downloading 'myfortune' from GitHub..."
sudo curl -s -L https://raw.githubusercontent.com/fadi-chekkour/myfortune/main/myfortune -o /usr/local/bin/myfortune

# 3. Ensure it is executable
sudo chmod +x /usr/local/bin/myfortune

echo "------------------------------------------"
echo "Installation complete!"
echo "You can now run the command by typing: myfortune"
