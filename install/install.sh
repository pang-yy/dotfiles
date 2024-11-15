#!/bin/bash

# Exit on error
set -e

DOTFILES_DIR="$HOME/dotfiles"

LINUX_PACKAGES=("build-essential" "software-properties-common")
COMMON_PACKAGES=("python3" "python3-launchpadlib" "gcc")
USEFUL_TOOLS=("tmux" "vim" "vim-gui-common" "vim-runtime" "git")
INFOSEC_TOOLS=("gdb")
PROG_TOOLS=()
EXTERNAL_INSTALL=("wireshark")

install_packages() {
    local packages=("$@")
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        for package in "${packages[@]}"; do
            echo "Installing $package"
            sudo apt install -y "$package"
        done
    else
        echo "Unsupported OS: $OSTYPE"
        exit 1
    fi
}

echo "Part 0: Updating OS..."
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt update && sudo apt upgrade -y
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi

echo "Part 1: Installing essential and common packages..."
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    install_packages "${LINUX_PACKAGES[@]}"
fi
install_packages "${COMMON_PACKAGES[@]}"

echo "Part 2: Installing extra tools..."
install_packages "${USEFUL_TOOLS[@]}"
install_packages "${INFOSEC_TOOLS[@]}"
install_packages "${PROG_TOOLS[@]}"

echo "Part 3: Installing tools with other scripts..."
for script in "${EXTERNAL_INSTALL[@]}"; do
    echo "Running $script.sh"
    chmod u+x ./"$script.sh"
    ./"$script.sh" || echo "$script.sh exited with error"
done

echo                       