#!/bin/bash

# Exit on error
set -e

echo "Running install.sh..."
chmod u+x ./install/install.sh
(cd install && ./install.sh) || echo "install.sh exited with error"

# TODO: Setup vim

# TODO: Setup git

echo "Setup done!"
