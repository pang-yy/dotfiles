#!/bin/bash

set -e

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt update
    sudo apt install -y wireshark

    sudo usermod -a -G wireshark "$USER"

    echo "Finished installing wireshark."
    echo "Please restart computer."
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi
