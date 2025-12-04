#!/bin/bash

# Package Installation Script
# Installs packages listed in packages.txt

set -e  # Exit on any error

# Color definitions
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES_FILE="${SCRIPT_DIR}/../packages.txt"

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}Package Installation${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# Check if packages file exists
if [ ! -f "$PACKAGES_FILE" ]; then
    echo -e "${YELLOW}Warning: packages.txt not found${NC}"
    exit 0
fi

# Read packages from file (skip empty lines and comments)
PACKAGES=$(grep -v '^#' "$PACKAGES_FILE" | grep -v '^[[:space:]]*$' | tr '\n' ' ')

if [ -z "$PACKAGES" ]; then
    echo -e "${YELLOW}No packages to install${NC}"
    exit 0
fi

echo -e "${YELLOW}Installing packages: $PACKAGES${NC}"
sudo apt-get install -y $PACKAGES

echo ""
echo -e "${GREEN}Package installation completed!${NC}"
echo ""
