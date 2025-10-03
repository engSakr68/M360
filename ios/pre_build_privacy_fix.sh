#!/bin/bash
set -e
set -u
set -o pipefail

echo "🔧 Pre-build privacy bundle fix..."

# Get the current working directory (should be ios/)
SRCROOT="${SRCROOT:-$(pwd)}"
BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR:-$(pwd)/build/Debug-dev-iphonesimulator}"
FRAMEWORKS_FOLDER_PATH="${FRAMEWORKS_FOLDER_PATH:-Frameworks}"

echo "SRCROOT: ${SRCROOT}"
echo "BUILT_PRODUCTS_DIR: ${BUILT_PRODUCTS_DIR}"
echo "FRAMEWORKS_FOLDER_PATH: ${FRAMEWORKS_FOLDER_PATH}"

# Create directories
mkdir -p "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"
mkdir -p "${BUILT_PRODUCTS_DIR}/url_launcher_ios"

# Copy privacy bundle
PRIVACY_BUNDLE_SRC="${SRCROOT}/url_launcher_ios_privacy.bundle"
PRIVACY_BUNDLE_DST_FRAMEWORKS="${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/url_launcher_ios_privacy.bundle"
PRIVACY_BUNDLE_DST_TARGET="${BUILT_PRODUCTS_DIR}/url_launcher_ios/url_launcher_ios_privacy.bundle"

if [ -d "${PRIVACY_BUNDLE_SRC}" ]; then
    echo "Copying privacy bundle from ${PRIVACY_BUNDLE_SRC}"
    
    # Copy to frameworks folder
    cp -R "${PRIVACY_BUNDLE_SRC}" "${PRIVACY_BUNDLE_DST_FRAMEWORKS}"
    echo "✅ Copied to frameworks: ${PRIVACY_BUNDLE_DST_FRAMEWORKS}"
    
    # Copy to target-specific directory
    cp -R "${PRIVACY_BUNDLE_SRC}" "${PRIVACY_BUNDLE_DST_TARGET}"
    echo "✅ Copied to target: ${PRIVACY_BUNDLE_DST_TARGET}"
    
    echo "✅ Privacy bundle copied successfully"
else
    echo "❌ Privacy bundle not found at ${PRIVACY_BUNDLE_SRC}"
    exit 1
fi

echo "🔧 Pre-build privacy bundle fix complete!"
