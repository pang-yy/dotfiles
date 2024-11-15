#!/bin/bash

# Exit on error
set -e

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
NC="\033[0m"

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
            echo -e "${GREEN}Installing $package${NC}"
            sudo apt install -y "$package"
        done
    else
        echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
        exit 1
    fi
}

echo -e "${GREEN}Part 0: Updating OS...${NC}"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt update && sudo apt upgrade -y
else
    echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
    exit 1
fi

echo -e "${GREEN}Part 1: Installing essential and common packages...${NC}"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    install_packages "${LINUX_PACKAGES[@]}"
fi
install_packages "${COMMON_PACKAGES[@]}"

echo -e "${GREEN}Part 2: Installing extra tools...${NC}"
install_packages "${USEFUL_TOOLS[@]}"
install_packages "${INFOSEC_TOOLS[@]}"
install_packages "${PROG_TOOLS[@]}"

echo -e "${GREEN}Part 3: Installing tools with other scripts...${NC}"
for script in "${EXTERNAL_INSTALL[@]}"; do
    echo -e "${GREEN}Running $script.sh${NC}"
    chmod u+x ./"$script.sh"
    ./"$script.sh" || echo -e "${RED}$script.sh exited with error${NC}"
done

