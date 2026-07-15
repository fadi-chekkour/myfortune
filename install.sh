#!/bin/bash

# Exit on any error
set -euo pipefail

# Configuration
APP_NAME="myfortune"
INSTALL_PATH="/usr/local/bin/$APP_NAME"
REPO_URL="https://raw.githubusercontent.com/fadi-chekkour/myfortune/main/myfortune"

# Helper functions
log() { echo -e "\e[32m[INFO]\e[0m $1"; }

# 1. Install Dependencies
log "Installing dependencies..."
if command -v apt-get &> /dev/null; then
    sudo apt-get update && sudo apt-get install -y fortune-mod cowsay
elif command -v dnf &> /dev/null; then
    sudo dnf install -y fortune-mod cowsay
elif command -v pacman &> /dev/null; then
    sudo pacman -S --noconfirm fortune-mod cowsay
fi

# 2. Download and install
log "Downloading $APP_NAME..."
sudo curl -s -L "$REPO_URL" -o "$INSTALL_PATH"
sudo chmod +x "$INSTALL_PATH"

log "Installation complete!"
echo "------------------------------------------"
echo "To finish, please run: source ~/.bashrc"
echo "Or simply open a new terminal window."
