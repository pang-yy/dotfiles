#!/bin/bash

set -e

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
NC="\033[0m"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt update
    sudo apt install -y wireshark

    sudo usermod -a -G wireshark "$USER"

    echo -e "${GREEN}Finished installing wireshark.${NC}"
    echo -e "${GREEN}Please restart computer.${NC}"
else
    echo "${RED}Unsupported OS: $OSTYPE${NC}"
    exit 1
fi
