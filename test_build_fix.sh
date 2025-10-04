#!/bin/bash

# Test Build Fix Script
# This script simulates the Xcode build environment and tests the fix

set -e
set -u
set -o pipefail

echo "=== Test Build Fix Script ==="

# Simulate Xcode build environment variables
export SRCROOT="/workspace/ios"
export BUILT_PRODUCTS_DIR="/tmp/test_build/BuiltProducts"
export CONFIGURATION_BUILD_DIR="/tmp/test_build/ConfigurationBuild"
export TARGET_BUILD_DIR="/tmp/test_build/TargetBuild"
export EFFECTIVE_PLATFORM_NAME="-iphonesimulator"

echo "Simulated build environment:"
echo "SRCROOT: $SRCROOT"
echo "BUILT_PRODUCTS_DIR: $BUILT_PRODUCTS_DIR"
echo "CONFIGURATION_BUILD_DIR: $CONFIGURATION_BUILD_DIR"
echo "TARGET_BUILD_DIR: $TARGET_BUILD_DIR"
echo "EFFECTIVE_PLATFORM_NAME: $EFFECTIVE_PLATFORM_NAME"

# Create test build directories
mkdir -p "$BUILT_PRODUCTS_DIR"
mkdir -p "$CONFIGURATION_BUILD_DIR"
mkdir -p "$TARGET_BUILD_DIR"

# Run the dynamic fix script
echo "Running dynamic build path fix script..."
"$SRCROOT/dynamic_build_path_fix.sh"

# Verify the results
echo "=== Verification Results ==="

# Check privacy bundles
PRIVACY_PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
    "shared_preferences_foundation"
    "share_plus"
    "device_info_plus"
    "permission_handler_apple"
    "path_provider_foundation"
    "package_info_plus"
    "file_picker"
    "flutter_local_notifications"
    "image_picker_ios"
)

for plugin in "${PRIVACY_PLUGINS[@]}"; do
    echo "Checking $plugin privacy bundle..."
    
    # Check BUILT_PRODUCTS_DIR
    if [ -f "${BUILT_PRODUCTS_DIR}/${plugin}/${plugin}_privacy.bundle/${plugin}_privacy" ]; then
        echo "✅ $plugin bundle found in BUILT_PRODUCTS_DIR"
    else
        echo "❌ $plugin bundle NOT found in BUILT_PRODUCTS_DIR"
    fi
    
    # Check CONFIGURATION_BUILD_DIR
    if [ -f "${CONFIGURATION_BUILD_DIR}/${plugin}/${plugin}_privacy.bundle/${plugin}_privacy" ]; then
        echo "✅ $plugin bundle found in CONFIGURATION_BUILD_DIR"
    else
        echo "❌ $plugin bundle NOT found in CONFIGURATION_BUILD_DIR"
    fi
    
    # Check TARGET_BUILD_DIR
    if [ -f "${TARGET_BUILD_DIR}/${plugin}/${plugin}_privacy.bundle/${plugin}_privacy" ]; then
        echo "✅ $plugin bundle found in TARGET_BUILD_DIR"
    else
        echo "❌ $plugin bundle NOT found in TARGET_BUILD_DIR"
    fi
done

# Check AWS Core bundle
echo "Checking AWS Core bundle..."
if [ -f "${BUILT_PRODUCTS_DIR}/AWSCore/AWSCore.bundle/AWSCore" ]; then
    echo "✅ AWS Core bundle found in BUILT_PRODUCTS_DIR"
else
    echo "❌ AWS Core bundle NOT found in BUILT_PRODUCTS_DIR"
fi

if [ -f "${CONFIGURATION_BUILD_DIR}/AWSCore/AWSCore.bundle/AWSCore" ]; then
    echo "✅ AWS Core bundle found in CONFIGURATION_BUILD_DIR"
else
    echo "❌ AWS Core bundle NOT found in CONFIGURATION_BUILD_DIR"
fi

if [ -f "${TARGET_BUILD_DIR}/AWSCore/AWSCore.bundle/AWSCore" ]; then
    echo "✅ AWS Core bundle found in TARGET_BUILD_DIR"
else
    echo "❌ AWS Core bundle NOT found in TARGET_BUILD_DIR"
fi

echo "=== Test Complete ==="

# Clean up test directories
echo "Cleaning up test directories..."
rm -rf "/tmp/test_build"

echo "✅ Test build fix script completed successfully"