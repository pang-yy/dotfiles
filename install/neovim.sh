#!/bin/bash

set -e

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
NC="\033[0m"

CURRENT_DIR=$(cd "$(dirname "$0")" && pwd)

if which nvim >/dev/null; then
    echo -e "${YELLOW}Neovim already installed${NC}"
    read -r -p "do you want to proceed with installation? [y/n]: " response
    if [[ "$response" != "y" ]]; then
        echo -e "${YELLOW}will exit Neovim installation now${NC}"
        exit 0
    fi
fi

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Reference: https://github.com/neovim/neovim/blob/38838fb00ab3d2ebaefc820cebcc5990ea98ea03/BUILD.md
    echo -e "${GREEN}Removing old neovim and neovim-runtime${NC}"
    sudo apt remove neovim
    sudo apt remove neovim-runtime

    echo -e "${GREEN}Cloning and installing Neovim${NC}"
    if [[ -e "${CURRENT_DIR}/temp/neovim" ]]; then
        echo -e "${YELLOW}temp/neovim already exists, skipping git clone${NC}"
    else
        git clone "https://github.com/neovim/neovim" "${CURRENT_DIR}/temp/neovim"
    fi
    cd "${CURRENT_DIR}/temp/neovim" && make CMAKE_BUILD_TYPE=RelWithDebInfo
    cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb


else
    echo "${RED}Unsupported OS: $OSTYPE${NC}"
    exit 1
fi
