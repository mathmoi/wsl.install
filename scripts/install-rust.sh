#!/bin/bash

# Rust/Cargo Installation Script
# Installs Rust programming language and Cargo package manager

set -e  # Exit on any error

# Color definitions
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}Rust/Cargo Installation${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# Check if Rust is already installed
if command -v rustc &> /dev/null; then
    echo -e "${YELLOW}Rust is already installed (version $(rustc --version))${NC}"
    echo -e "${YELLOW}Updating Rust...${NC}"
    rustup update
else
    echo -e "${YELLOW}Installing Rust...${NC}"
    # Install Rust using rustup (official installer)
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    # Source the cargo environment
    source "$HOME/.cargo/env"

    echo -e "${GREEN}Rust installed successfully (version $(rustc --version))${NC}"
fi

echo ""
echo -e "${GREEN}Rust/Cargo installation completed!${NC}"
echo ""
