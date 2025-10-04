#!/bin/bash

# Final Privacy Bundle Fix Script
# This script ensures privacy bundles are copied to all necessary build locations

set -e
set -u
set -o pipefail

echo "=== Running Final Privacy Bundle Fix Script ==="

# Debug: Show build variables
echo "SRCROOT: ${SRCROOT:-/workspace/ios}"
echo "BUILT_PRODUCTS_DIR: ${BUILT_PRODUCTS_DIR:-}"
echo "CONFIGURATION_BUILD_DIR: ${CONFIGURATION_BUILD_DIR:-}"
echo "EFFECTIVE_PLATFORM_NAME: ${EFFECTIVE_PLATFORM_NAME:-}"
echo "PWD: $(pwd)"

# Set default SRCROOT if not provided
if [ -z "${SRCROOT:-}" ]; then
    SRCROOT="/workspace/ios"
fi

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

# Function to copy privacy bundle to build locations
copy_privacy_bundle_to_build() {
    local plugin_name="$1"
    local source_bundle="${SRCROOT}/${plugin_name}_privacy.bundle"
    local source_file="${source_bundle}/${plugin_name}_privacy"
    
    echo "Processing privacy bundle for: $plugin_name"
    echo "Source bundle: $source_bundle"
    echo "Source file: $source_file"
    
    if [ ! -d "$source_bundle" ] || [ ! -f "$source_file" ]; then
        echo "⚠️ $plugin_name privacy bundle not found at: $source_bundle"
        return 1
    fi
    
    # Define build destination paths based on available variables
    local build_dest_paths=()
    
    if [ -n "${BUILT_PRODUCTS_DIR:-}" ]; then
        build_dest_paths+=("${BUILT_PRODUCTS_DIR}/${plugin_name}/${plugin_name}_privacy.bundle")
    fi
    
    if [ -n "${CONFIGURATION_BUILD_DIR:-}" ]; then
        build_dest_paths+=("${CONFIGURATION_BUILD_DIR}/${plugin_name}/${plugin_name}_privacy.bundle")
    fi
    
    # Add common Flutter build paths
    build_dest_paths+=(
        "${SRCROOT}/../build/ios/Debug-dev-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
        "${SRCROOT}/../build/ios/Release-dev-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
        "${SRCROOT}/../build/ios/Debug-prod-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
        "${SRCROOT}/../build/ios/Release-prod-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
    )
    
    # Copy to all build locations
    for dest_dir in "${build_dest_paths[@]}"; do
        echo "Copying to build location: $dest_dir"
        mkdir -p "$dest_dir"
        cp -R "$source_bundle"/* "$dest_dir/"
        
        # Verify the copy
        local dest_file="${dest_dir}/${plugin_name}_privacy"
        if [ -f "$dest_file" ]; then
            echo "✅ Verified $plugin_name privacy bundle at: $dest_file"
        else
            echo "❌ Failed to verify $plugin_name privacy bundle at: $dest_file"
        fi
    done
}

# Copy privacy bundles for all plugins
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    copy_privacy_bundle_to_build "$plugin"
done

# Handle AWS Core bundle
echo "Processing AWS Core bundle..."
AWS_CORE_SRC_SIMULATOR="${SRCROOT}/vendor/openpath/AWSCore.xcframework/ios-arm64_x86_64-simulator/AWSCore.framework/AWSCore.bundle"
AWS_CORE_SRC_DEVICE="${SRCROOT}/vendor/openpath/AWSCore.xcframework/ios-arm64/AWSCore.framework/AWSCore.bundle"

# Define AWS Core destination paths
AWS_CORE_DEST_PATHS=()

if [ -n "${BUILT_PRODUCTS_DIR:-}" ]; then
    AWS_CORE_DEST_PATHS+=("${BUILT_PRODUCTS_DIR}/AWSCore/AWSCore.bundle")
fi

if [ -n "${CONFIGURATION_BUILD_DIR:-}" ]; then
    AWS_CORE_DEST_PATHS+=("${CONFIGURATION_BUILD_DIR}/AWSCore/AWSCore.bundle")
fi

# Add common Flutter build paths
AWS_CORE_DEST_PATHS+=(
    "${SRCROOT}/../build/ios/Debug-dev-iphonesimulator/AWSCore/AWSCore.bundle"
    "${SRCROOT}/../build/ios/Release-dev-iphonesimulator/AWSCore/AWSCore.bundle"
    "${SRCROOT}/../build/ios/Debug-prod-iphonesimulator/AWSCore/AWSCore.bundle"
    "${SRCROOT}/../build/ios/Release-prod-iphonesimulator/AWSCore/AWSCore.bundle"
)

# Determine source based on platform
if [[ "${EFFECTIVE_PLATFORM_NAME:-}" == "-iphonesimulator" ]]; then
    AWS_CORE_SRC="$AWS_CORE_SRC_SIMULATOR"
    echo "Building for simulator"
else
    AWS_CORE_SRC="$AWS_CORE_SRC_DEVICE"
    echo "Building for device"
fi

if [ -d "${AWS_CORE_SRC}" ]; then
    for dest_path in "${AWS_CORE_DEST_PATHS[@]}"; do
        echo "Copying AWS Core bundle to: $dest_path"
        mkdir -p "$(dirname "$dest_path")"
        cp -R "${AWS_CORE_SRC}" "${dest_path}"
        echo "✅ Copied AWS Core bundle to: $dest_path"
    done
else
    echo "⚠️ AWS Core bundle not found, creating minimal ones"
    for dest_path in "${AWS_CORE_DEST_PATHS[@]}"; do
        mkdir -p "$(dirname "$dest_path")"
        cat > "${dest_path}/AWSCore" << 'AWS_EOF'
# AWS Core Bundle Resource File (Fallback)
AWS_CORE_VERSION=2.37.2
AWS_CORE_BUNDLE_ID=org.cocoapods.AWSCore
AWS_CORE_PLATFORM=${EFFECTIVE_PLATFORM_NAME}
AWS_EOF
        echo "✅ Created fallback AWS Core bundle at: $dest_path"
    done
fi

echo "=== Final Privacy Bundle Fix Script Complete ==="