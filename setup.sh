#!/usr/bin/env bash

set -e

echo "🔍 Detecting OS..."

# Function to install on Debian/Ubuntu
install_debian() {
    echo "🟢 Debian/Ubuntu detected. Installing Neovim..."
    sudo apt update
    sudo apt install -y neovim curl git lazygit python3-pip python3-venv software-properties-common lazygitg
}

# Function to install on Fedora
install_fedora() {
    echo "🟠 Fedora detected. Installing Neovim..."
    sudo dnf install -y neovim curl git lazygit git-delta python3-pip python3-virtualenv
}

# Function to install on macOS
install_macos() {
    echo "🔵 macOS detected. Installing Neovim..."
    # Check for Homebrew
    if ! command -v brew &>/dev/null; then
        echo "🍺 Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    brew update
    brew install neovim git lazygit git-delta python
}

# Detect OS and call the appropriate install function
case "$(uname)" in
    "Linux")
        if [ -f /etc/debian_version ]; then
            install_debian
        elif [ -f /etc/fedora-release ]; then
            install_fedora
        else
            echo "❌ Unsupported Linux distribution."
            exit 1
        fi
        ;;
    "Darwin")
        install_macos
        ;;
    *)
        echo "❌ Unsupported operating system."
        exit 1
        ;;
esac

# Set up Python support
# echo "🐍 Setting up Python support for Neovim..."
# pip3 install --user --upgrade pynvim

echo "✅ Neovim and dependencies installed successfully!"


# Download the latest binary from GitHub
# LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' | cut -d'"' -f4)
# curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION#v}_Linux_x86_64.tar.gz"
# tar xf lazygit.tar.gz lazygit
# sudo install lazygit /usr/local/bin

