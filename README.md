# WSL2 Installation Scripts

This repository contains scripts to automatically configure my WSL2 environment.

## Quick Start

```bash
git clone https://github.com/mathmoi/wsl.install.git "$HOME/wsl.install" && cd "$HOME/wsl.install" && ./install.sh
```

### Git and GitHub SSH Setup

The installation script will pause during Git configuration and wait for you to add your SSH key to GitHub:

1. The script will display your public SSH key
2. Copy the entire key (starts with `ssh-ed25519`)
3. Go to [GitHub SSH Settings](https://github.com/settings/keys)
4. Click **"New SSH key"**
5. Give it a descriptive title (e.g., "WSL2")
6. Paste your public key into the "Key" field
7. Click **"Add SSH key"**
8. Press Enter in the terminal to continue

The script will automatically test the connection and continue once the key is successfully added. You can also type 'skip' to bypass this step if needed.

To view your public key again later:

```bash
cat ~/.ssh/id_ed25519.pub
```

## Adding More Packages

Edit `packages.txt` and add one package name per line