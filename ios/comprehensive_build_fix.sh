#!/bin/bash
set -e
set -u
set -o pipefail

echo "🏗️ Comprehensive iOS build fix..."

# Set build environment variables
export SRCROOT="$(pwd)"
export BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR:-$(pwd)/build/Debug-dev-iphonesimulator}"
export FRAMEWORKS_FOLDER_PATH="${FRAMEWORKS_FOLDER_PATH:-Frameworks}"

echo "SRCROOT: ${SRCROOT}"
echo "BUILT_PRODUCTS_DIR: ${BUILT_PRODUCTS_DIR}"
echo "FRAMEWORKS_FOLDER_PATH: ${FRAMEWORKS_FOLDER_PATH}"

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

# Step 4: Fix new_version_plus plugin registration
echo ""
echo "🔧 Step 4: Fixing new_version_plus plugin registration..."

# Create a plugin registration override
cat > "${SRCROOT}/Flutter/Generated.xcconfig" << 'EOF'
// Generated file - do not edit
// This file overrides problematic plugin configurations

// Override new_version_plus plugin configuration
NEW_VERSION_PLUS_ANDROID_PACKAGE=com.codesfirst.new_version_plus
NEW_VERSION_PLUS_IOS_PACKAGE=com.codesfirst.new_version_plus

// Ensure proper plugin registration
FLUTTER_PLUGIN_REGISTRATION=1
