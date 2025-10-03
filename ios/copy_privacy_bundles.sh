#!/bin/bash
set -e

echo "=== Manual Privacy Bundle Copy ==="

# Source and destination paths
SRCROOT="${SRCROOT:-$(pwd)}"
BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR:-build/Debug-iphonesimulator}"
FRAMEWORKS_FOLDER_PATH="${FRAMEWORKS_FOLDER_PATH:-Frameworks}"

# Create directories
mkdir -p "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"
mkdir -p "${BUILT_PRODUCTS_DIR}/url_launcher_ios"

# Copy url_launcher_ios privacy bundle
if [ -d "${SRCROOT}/url_launcher_ios_privacy.bundle" ]; then
    echo "Copying url_launcher_ios privacy bundle..."
    cp -R "${SRCROOT}/url_launcher_ios_privacy.bundle" "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/"
    cp -R "${SRCROOT}/url_launcher_ios_privacy.bundle" "${BUILT_PRODUCTS_DIR}/url_launcher_ios/"
    echo "✅ Privacy bundle copied successfully"
else
    echo "❌ Privacy bundle not found at ${SRCROOT}/url_launcher_ios_privacy.bundle"
fi

echo "=== Privacy Bundle Copy Complete ==="
