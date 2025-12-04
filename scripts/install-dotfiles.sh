#!/bin/bash

# Dotfiles Installation Script
# Clones dotfiles repository and uses stow to symlink configuration files

set -e  # Exit on any error

# Color definitions
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

DOTFILES_REPO="git@github.com:mathmoi/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}Dotfiles Installation${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# Check if dotfiles directory already exists
if [ -d "$DOTFILES_DIR" ]; then
    echo -e "${YELLOW}Dotfiles directory already exists at $DOTFILES_DIR${NC}"
    echo -e "${YELLOW}Updating dotfiles repository...${NC}"

    cd "$DOTFILES_DIR"
    if git pull; then
        echo -e "${GREEN}Dotfiles updated successfully${NC}"
    else
        echo -e "${RED}Failed to update dotfiles repository${NC}"
        echo -e "${YELLOW}Continuing with existing dotfiles...${NC}"
    fi
    echo ""
else
    # Clone dotfiles repository
    echo -e "${YELLOW}Cloning dotfiles repository...${NC}"

    if ! git clone "$DOTFILES_REPO" "$DOTFILES_DIR" 2>&1; then
        echo ""
        echo -e "${RED}Failed to clone dotfiles repository${NC}"
        echo -e "${YELLOW}This is likely because GitHub SSH authentication is not set up.${NC}"
        echo -e "${YELLOW}Please run the configure-git.sh script and add your SSH key to GitHub.${NC}"
        echo ""
        exit 1
    fi

    echo -e "${GREEN}Dotfiles cloned successfully${NC}"
    echo ""
fi

# Use stow on all directories in dotfiles
cd "$DOTFILES_DIR"

echo -e "${YELLOW}Installing dotfiles with stow...${NC}"

# Loop through all directories in dotfiles (excluding hidden directories and .git)
for dir in */; do
    # Remove trailing slash
    dir="${dir%/}"

    # Skip if not a directory
    [ -d "$dir" ] || continue

    echo -e "${YELLOW}  Stowing $dir...${NC}"

    # Run stow with --restow to handle both new and existing symlinks
    if stow --restow --verbose=1 --target="$HOME" "$dir" 2>&1 | grep -v "^LINK:"; then
        :  # Suppress verbose output except errors
    fi
done

echo ""
echo -e "${GREEN}Dotfiles installation completed!${NC}"
echo ""
