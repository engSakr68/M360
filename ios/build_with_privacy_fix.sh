#!/bin/bash
set -e
set -u
set -o pipefail

echo "🏗️ Building iOS with privacy bundle fix..."

# Set build environment variables
export SRCROOT="$(pwd)"
export BUILT_PRODUCTS_DIR="$(pwd)/build/Debug-dev-iphonesimulator"
export FRAMEWORKS_FOLDER_PATH="Frameworks"

# Create necessary directories
mkdir -p "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"
mkdir -p "${BUILT_PRODUCTS_DIR}/url_launcher_ios"

# Copy privacy bundle to all possible locations
PRIVACY_BUNDLE_SRC="${SRCROOT}/url_launcher_ios_privacy.bundle"

if [ -d "${PRIVACY_BUNDLE_SRC}" ]; then
    echo "📋 Copying privacy bundle to build directories..."
    
    # Copy to frameworks folder
    cp -R "${PRIVACY_BUNDLE_SRC}" "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/"
    echo "✅ Copied to frameworks folder: ${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/url_launcher_ios_privacy.bundle"
    
    # Copy to target-specific directory
    cp -R "${PRIVACY_BUNDLE_SRC}" "${BUILT_PRODUCTS_DIR}/url_launcher_ios/"
    echo "✅ Copied to target directory: ${BUILT_PRODUCTS_DIR}/url_launcher_ios/url_launcher_ios_privacy.bundle"
    
    # Also copy to other possible build configurations
    for config in "Debug-iphonesimulator" "Release-iphonesimulator" "Profile-iphonesimulator"; do
        CONFIG_DIR="$(pwd)/build/${config}"
        if [ -d "${CONFIG_DIR}" ]; then
            mkdir -p "${CONFIG_DIR}/${FRAMEWORKS_FOLDER_PATH}"
            mkdir -p "${CONFIG_DIR}/url_launcher_ios"
            cp -R "${PRIVACY_BUNDLE_SRC}" "${CONFIG_DIR}/${FRAMEWORKS_FOLDER_PATH}/"
            cp -R "${PRIVACY_BUNDLE_SRC}" "${CONFIG_DIR}/url_launcher_ios/"
            echo "✅ Copied to ${config} directories"
        fi
    done
    
    echo "✅ Privacy bundle copied successfully to all build directories"
else
    echo "❌ Privacy bundle not found at ${PRIVACY_BUNDLE_SRC}"
    exit 1
fi

echo "🏗️ Privacy bundle fix complete!"
