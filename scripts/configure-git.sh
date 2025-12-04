#!/bin/bash

# Git Configuration Script
# Configures git user settings and sets up SSH authentication for GitHub

set -e  # Exit on any error

# Color definitions
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}Git Configuration${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# Git user configuration
GIT_USER_NAME="Mathieu Pagé"
GIT_USER_EMAIL="m@mathieupage.com"

echo -e "${YELLOW}Configuring git...${NC}"

# Configure git
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

# Enable credential caching
git config --global credential.helper cache

echo -e "${GREEN}Git configured successfully!${NC}"
echo ""

# Check if SSH key already exists
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ -f "$SSH_KEY" ]; then
    echo -e "${YELLOW}SSH key already exists at $SSH_KEY${NC}"
    echo -e "${CYAN}Using existing SSH key${NC}"
    echo ""
    echo -e "${YELLOW}Your public SSH key:${NC}"
    cat "${SSH_KEY}.pub"
    echo ""
else
    # Generate SSH key
    echo -e "${YELLOW}Generating SSH key...${NC}"
    ssh-keygen -t ed25519 -C "$GIT_USER_EMAIL" -f "$SSH_KEY" -N ""

    echo ""
    echo -e "${YELLOW}Your public SSH key:${NC}"
    echo ""
    cat "${SSH_KEY}.pub"
    echo ""
fi

# Start ssh-agent and add key
echo -e "${YELLOW}Starting ssh-agent and adding key...${NC}"
eval "$(ssh-agent -s)"
ssh-add "$SSH_KEY"

# Add SSH config for GitHub
SSH_CONFIG="$HOME/.ssh/config"
if [ ! -f "$SSH_CONFIG" ] || ! grep -q "Host github.com" "$SSH_CONFIG"; then
    echo -e "${YELLOW}Configuring SSH for GitHub...${NC}"
    mkdir -p "$HOME/.ssh"
    cat >> "$SSH_CONFIG" << 'EOF'

# GitHub configuration
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    AddKeysToAgent yes
EOF
    chmod 600 "$SSH_CONFIG"
fi

echo ""
echo -e "${GREEN}Git and SSH configuration completed!${NC}"
echo ""

# Test GitHub SSH connection and loop until successful or skipped
while true; do
    echo -e "${YELLOW}Testing GitHub SSH connection...${NC}"
    if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
        echo -e "${GREEN}GitHub SSH connection successful!${NC}"
        echo ""
        break
    fi

    echo -e "${YELLOW}GitHub SSH connection failed - SSH key not added to GitHub yet${NC}"
    echo ""
    echo -e "${CYAN}================================================${NC}"
    echo -e "${CYAN}Add SSH Key to GitHub${NC}"
    echo -e "${CYAN}================================================${NC}"
    echo ""
    echo -e "${YELLOW}Your public SSH key:${NC}"
    echo ""
    cat "${SSH_KEY}.pub"
    echo ""
    echo -e "${CYAN}Copy the key above and add it to GitHub:${NC}"
    echo -e "${CYAN}1. Go to https://github.com/settings/keys${NC}"
    echo -e "${CYAN}2. Click 'New SSH key'${NC}"
    echo -e "${CYAN}3. Give it a title (e.g., 'WSL2')${NC}"
    echo -e "${CYAN}4. Paste your key and save${NC}"
    echo ""

    read -p "Press Enter after you've added the key to GitHub (or type 'skip' to skip): " USER_INPUT

    if [[ "$USER_INPUT" == "skip" ]]; then
        echo -e "${CYAN}Skipping GitHub SSH configuration${NC}"
        echo ""
        exit 0
    fi
    echo ""
done

echo -e "${GREEN}================================================${NC}"
echo -e "${GREEN}Git and GitHub setup completed successfully!${NC}"
echo -e "${GREEN}================================================${NC}"
echo ""
