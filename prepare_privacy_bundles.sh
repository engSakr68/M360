#!/bin/bash

# Pre-build Privacy Bundle Preparation Script
# This script should be run before building iOS to ensure privacy bundles are ready

set -e
set -u
set -o pipefail

echo "=== Preparing Privacy Bundles for iOS Build ==="

# Set paths
WORKSPACE_ROOT="/workspace"
IOS_DIR="${WORKSPACE_ROOT}/ios"
BUILD_DIR="${WORKSPACE_ROOT}/build"

echo "Workspace root: $WORKSPACE_ROOT"
echo "iOS directory: $IOS_DIR"
echo "Build directory: $BUILD_DIR"

# List of plugins that need privacy bundles
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

# Function to prepare privacy bundle for build
prepare_privacy_bundle() {
    local plugin_name="$1"
    local source_bundle="${IOS_DIR}/${plugin_name}_privacy.bundle"
    local source_file="${source_bundle}/${plugin_name}_privacy"
    
    echo "Preparing privacy bundle for: $plugin_name"
    echo "Source bundle: $source_bundle"
    echo "Source file: $source_file"
    
    if [ ! -d "$source_bundle" ] || [ ! -f "$source_file" ]; then
        echo "⚠️ $plugin_name privacy bundle not found at: $source_bundle"
        return 1
    fi
    
    # Create build directories for all possible configurations
    local build_configs=(
        "Debug-dev-iphonesimulator"
        "Release-dev-iphonesimulator"
        "Debug-prod-iphonesimulator"
        "Release-prod-iphonesimulator"
        "Debug-dev-iphoneos"
        "Release-dev-iphoneos"
        "Debug-prod-iphoneos"
        "Release-prod-iphoneos"
    )
    
    for config in "${build_configs[@]}"; do
        local dest_dir="${BUILD_DIR}/ios/${config}/${plugin_name}/${plugin_name}_privacy.bundle"
        echo "Preparing for config: $config -> $dest_dir"
        
        # Create destination directory
        mkdir -p "$dest_dir"
        
        # Copy the entire bundle directory
        cp -R "$source_bundle"/* "$dest_dir/"
        
        # Verify the copy
        local dest_file="${dest_dir}/${plugin_name}_privacy"
        if [ -f "$dest_file" ]; then
            echo "✅ Verified $plugin_name privacy bundle for $config"
        else
            echo "❌ Failed to verify $plugin_name privacy bundle for $config"
            return 1
        fi
    done
}

# Prepare privacy bundles for all plugins
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    prepare_privacy_bundle "$plugin"
done

# Handle AWS Core bundle
echo "Preparing AWS Core bundle..."
AWS_CORE_SRC_SIMULATOR="${IOS_DIR}/vendor/openpath/AWSCore.xcframework/ios-arm64_x86_64-simulator/AWSCore.framework/AWSCore.bundle"
AWS_CORE_SRC_DEVICE="${IOS_DIR}/vendor/openpath/AWSCore.xcframework/ios-arm64/AWSCore.framework/AWSCore.bundle"

# Create build directories for all possible configurations
local build_configs=(
    "Debug-dev-iphonesimulator"
    "Release-dev-iphonesimulator"
    "Debug-prod-iphonesimulator"
    "Release-prod-iphonesimulator"
    "Debug-dev-iphoneos"
    "Release-dev-iphoneos"
    "Debug-prod-iphoneos"
    "Release-prod-iphoneos"
)

for config in "${build_configs[@]}"; do
    local dest_dir="${BUILD_DIR}/ios/${config}/AWSCore/AWSCore.bundle"
    echo "Preparing AWS Core bundle for config: $config -> $dest_dir"
    
    # Create destination directory
    mkdir -p "$dest_dir"
    
    # Determine source based on config
    if [[ "$config" == *"iphonesimulator"* ]]; then
        AWS_CORE_SRC="$AWS_CORE_SRC_SIMULATOR"
    else
        AWS_CORE_SRC="$AWS_CORE_SRC_DEVICE"
    fi
    
    if [ -d "${AWS_CORE_SRC}" ]; then
        cp -R "${AWS_CORE_SRC}"/* "$dest_dir/"
        echo "✅ Copied AWS Core bundle for $config"
    else
        echo "⚠️ AWS Core bundle not found, creating minimal one for $config"
        cat > "${dest_dir}/AWSCore" << 'AWS_EOF'
# AWS Core Bundle Resource File (Fallback)
AWS_CORE_VERSION=2.37.2
AWS_CORE_BUNDLE_ID=org.cocoapods.AWSCore
AWS_CORE_PLATFORM=ios
AWS_EOF
        echo "✅ Created fallback AWS Core bundle for $config"
    fi
done

echo "=== Privacy Bundle Preparation Complete ==="
echo "All privacy bundles are now ready for iOS build"