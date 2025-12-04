#!/bin/bash
set -e

echo "Installing fastfetch from GitHub releases..."

# Detect architecture
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        PACKAGE_ARCH="amd64"
        ;;
    aarch64|arm64)
        PACKAGE_ARCH="arm64"
        ;;
    armv7l)
        PACKAGE_ARCH="armhf"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# Get latest release version
echo "Fetching latest release information..."
LATEST_VERSION=$(curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

if [ -z "$LATEST_VERSION" ]; then
    echo "Failed to fetch latest version"
    exit 1
fi

echo "Latest version: $LATEST_VERSION"

# Construct download URL
PACKAGE_NAME="fastfetch-linux-${PACKAGE_ARCH}.deb"
DOWNLOAD_URL="https://github.com/fastfetch-cli/fastfetch/releases/download/${LATEST_VERSION}/${PACKAGE_NAME}"

# Download package
echo "Downloading $PACKAGE_NAME..."
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

if ! curl -L -o "$PACKAGE_NAME" "$DOWNLOAD_URL"; then
    echo "Failed to download fastfetch"
    rm -rf "$TMP_DIR"
    exit 1
fi

# Install package
echo "Installing fastfetch..."
sudo dpkg -i "$PACKAGE_NAME"

# Fix any dependency issues
sudo apt-get install -f -y

# Cleanup
cd - > /dev/null
rm -rf "$TMP_DIR"

# Verify installation
if command -v fastfetch &> /dev/null; then
    echo "✓ fastfetch installed successfully!"
    fastfetch --version
else
    echo "✗ Installation failed"
    exit 1
fi
