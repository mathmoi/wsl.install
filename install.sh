#!/bin/bash

# WSL2 Installation and Configuration Script
# This script updates the system and configures the environment

set -e  # Exit on any error

# Color definitions
CYAN='\033[0;36m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${CYAN}================================================${NC}"
echo -e "${CYAN}WSL2 System Configuration Script${NC}"
echo -e "${CYAN}================================================${NC}"
echo ""

# Run system update script
"${SCRIPT_DIR}/scripts/update-system.sh"

# Install packages from packages.txt
"${SCRIPT_DIR}/scripts/install-packages.sh"

# Install Rust/Cargo
"${SCRIPT_DIR}/scripts/install-rust.sh"

# Install fastfetch
"${SCRIPT_DIR}/scripts/install-fastfetch.sh"

# Install Starship prompt
"${SCRIPT_DIR}/scripts/install-starship.sh"

# Configure Git (interactive)
"${SCRIPT_DIR}/scripts/configure-git.sh"

# Install dotfiles
"${SCRIPT_DIR}/scripts/install-dotfiles.sh"

echo -e "${GREEN}================================================${NC}"
echo -e "${GREEN}Configuration completed successfully!${NC}"
echo -e "${GREEN}================================================${NC}"
