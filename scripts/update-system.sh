#!/bin/bash

# System Update Script
# Updates all packages and cleans up the system

set -e  # Exit on any error

# Color definitions
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}System Update${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# Update package lists
echo -e "${YELLOW}Updating package lists...${NC}"
sudo apt-get update

# Upgrade installed packages
echo -e "${YELLOW}Upgrading installed packages...${NC}"
sudo apt-get upgrade -y

# Remove unnecessary packages
echo -e "${YELLOW}Cleaning up unnecessary packages...${NC}"
sudo apt-get autoremove -y
sudo apt-get autoclean -y

echo ""
echo -e "${GREEN}System update completed successfully!${NC}"
echo ""
