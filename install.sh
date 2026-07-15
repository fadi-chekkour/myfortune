#!/bin/bash

# Exit on any error, undefined variables, and pipe failures
set -euo pipefail

# Configuration
APP_NAME="myfortune"
INSTALL_PATH="/usr/local/bin/$APP_NAME"
REPO_URL="https://raw.githubusercontent.com/fadi-chekkour/myfortune/main/myfortune"

log() { echo -e "\e[32m[INFO]\e[0m $1"; }
error() { echo -e "\e[31m[ERROR]\e[0m $1" >&2; exit 1; }

install_dependencies() {
    log "Detecting package manager..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y fortune-mod cowsay
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y fortune-mod cowsay
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm fortune-mod cowsay
    elif command -v brew &> /dev/null; then
        brew install fortune cowsay
    else
        error "No supported package manager found."
    fi
}

install_app() {
    log "Downloading $APP_NAME..."
    sudo curl -s -L "$REPO_URL" -o "$INSTALL_PATH"
    sudo chmod +x "$INSTALL_PATH"
    log "Successfully installed to $INSTALL_PATH"
}

# Main Execution
main() {
    install_dependencies
    install_app
    log "Installation complete! Run '$APP_NAME' to start."
}

main
