#!/bin/bash

# Starship Prompt Installation Script
# Installs Starship, a fast and customizable shell prompt

set -e  # Exit on any error

# Color definitions
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}Starship Prompt Installation${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# Check if Starship is already installed
if command -v starship &> /dev/null; then
    echo -e "${YELLOW}Starship is already installed (version $(starship --version))${NC}"
    echo -e "${YELLOW}Skipping installation...${NC}"
else
    echo -e "${YELLOW}Installing Starship...${NC}"

    # Install Starship using the official install script
    curl -sS https://starship.rs/install.sh | sh -s -- -y

    echo -e "${GREEN}Starship installed successfully (version $(starship --version))${NC}"
fi

echo ""
echo -e "${GREEN}Starship installation completed!${NC}"
echo ""
