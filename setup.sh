#!/bin/bash

# Exit on error
set -e

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
NC="\033[0m"

CURRENT_DIR=$(cd "$(dirname "$0")" && pwd)

# ------------------------------
# 1. Basic Installation
# -----------------------------
echo -e "${GREEN}Running install.sh...${NC}"
chmod u+x "${CURRENT_DIR}/install/install.sh"
(cd "${CURRENT_DIR}/install" && ./install.sh) || echo -e "${RED}install.sh exited with error${NC}"

# ------------------------------
# 2. Vim Setup
# -----------------------------
echo -e "${GREEN}Setting up Vim...${NC}"
if [[ -e "$HOME/.vimrc" ]]; then
    echo -e "${YELLOW}.vimrc already exist in home directory${NC}"
else
    echo -e "${GREEN}Linking .vimrc to home directory${NC}"
    # cp ./vim/.vimrc "$HOME/"
    ln -s "${CURRENT_DIR}/vim/.vimrc" "$HOME/.vimrc"
fi
if [[ -e "$HOME/.vim/" ]]; then
    echo -e "${YELLOW}.vim/ already exist in home directory${NC}"
else
    echo -e "${GREEN}Linking .vim/ to home directory${NC}"
    # mkdir "$HOME/.vim"
    # cp -r ./vim/.vim/* "$HOME/.vim/"
    ln -s "${CURRENT_DIR}/vim/.vim" "$HOME/.vim"
fi

# ------------------------------
# 3. Neovim Setup
# -----------------------------
echo -e "${GREEN}Setting up Neovim...${NC}"
if [[ -e "$HOME/.config/nvim" ]]; then
    echo -e "${YELLOW}neovim/ already exist in ~/.config directory${NC}"
else
    echo -e "${GREEN}Linking nvim/ to ~/.config${NC}"
    ln -s "${CURRENT_DIR}/nvim" "$HOME/.config/nvim"
fi
read -r -p "Install luarocks for Neovim? [y/n]: " luarocks_response
if [[ "$luarocks_response" == "y" ]]; then
    if ! which luarocks >/dev/null; then
        echo -e "${GREEN}Installing luarocks for Neovim...${NC}"
        wget "https://luarocks.org/releases/luarocks-3.11.1.tar.gz"
        tar zxpf "luarocks-3.11.1.tar.gz"
        (cd "${CURRENT_DIR}/luarocks-3.11.1" && ./configure && make && sudo make install)
        sudo luarocks install luasocket
        rm "luarocks-3.11.1.tar.gz"
        rm -r "luarocks-3.11.1"
    else
        echo -e "${YELLOW}luarocks already installed${NC}"
        echo -e "${YELLOW}will skip installing luarocks${NC}"
    fi
else
    echo -e "${YELLOW}will skip installing luarocks${NC}"
fi

# ------------------------------
# 4. Git Setup
# -----------------------------
echo -e "${GREEN}Setting up Git...${NC}"
if  ! git config --global user.name >/dev/null; then
    echo -e "${GREEN}Enter Git Username: ${NC}"
    read -r GIT_NAME
    git config --global user.name "$GIT_NAME"
fi
if ! git config --global user.email >/dev/null; then
    echo -e "${GREEN}Enter Git Email: ${NC}"
    read -r GIT_EMAIL
    git config --global user.email "$GIT_EMAIL"
fi

echo -e "${GREEN}Setup done!${NC}"
