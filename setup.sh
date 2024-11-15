#!/bin/bash

# Exit on error
set -e

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
NC="\033[0m"

# ------------------------------
# 1. Basic Installation
# -----------------------------
echo -e "${GREEN}Running install.sh...${NC}"
chmod u+x ./install/install.sh
(cd install && ./install.sh) || echo -e "${RED}install.sh exited with error${NC}"

# ------------------------------
# 2. Vim Setup
# -----------------------------
echo -e "${GREEN}Setting up Vim...${NC}"
if [[ -e "$HOME/.vimrc" ]]; then
    echo -e "${YELLOW}.vimrc already exist in home directory${NC}"
else
    echo -e "${GREEN}Copying .vimrc to home directory${NC}"
    cp ./vim/.vimrc "$HOME/"
fi
if [[ -e "$HOME/.vim/" ]]; then
    echo -e "${YELLOW}.vim/ already exist in home directory${NC}"
else
    echo -e "${GREEN}Copying .vim/ to home directory${NC}"
    mkdir "$HOME/.vim"
    cp -r ./vim/.vim/* "$HOME/.vim/"
fi

# ------------------------------
# 3. Git Setup
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
