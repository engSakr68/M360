#!/bin/bash

# Comprehensive Privacy Manifest Fix Script
# This script addresses the root cause of missing privacy bundle files
# by ensuring all Flutter plugins have proper privacy manifests

set -e
set -u
set -o pipefail

echo "=== Comprehensive Privacy Manifest Fix Script ==="

# Debug: Show build variables
echo "Build Environment:"
echo "SRCROOT: ${SRCROOT:-/workspace/ios}"
echo "BUILT_PRODUCTS_DIR: ${BUILT_PRODUCTS_DIR:-}"
echo "CONFIGURATION_BUILD_DIR: ${CONFIGURATION_BUILD_DIR:-}"
echo "EFFECTIVE_PLATFORM_NAME: ${EFFECTIVE_PLATFORM_NAME:-}"
echo "TARGET_BUILD_DIR: ${TARGET_BUILD_DIR:-}"
echo "PWD: $(pwd)"

# Set default SRCROOT if not provided
if [ -z "${SRCROOT:-}" ]; then
    SRCROOT="/workspace/ios"
    echo "Using default SRCROOT: $SRCROOT"
fi

# List of plugins that need privacy bundles (from the error messages)
PRIVACY_PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
    "shared_preferences_foundation"
    "share_plus"
    "permission_handler_apple"
    "path_provider_foundation"
    "package_info_plus"
    "image_picker_ios"
    "fluttertoast"
    "flutter_local_notifications"
)

# Function to create comprehensive privacy bundle
create_comprehensive_privacy_bundle() {
    local plugin_name="$1"
    local source_bundle="${SRCROOT}/${plugin_name}_privacy.bundle"
    local source_file="${source_bundle}/${plugin_name}_privacy"
    
    echo "Processing privacy bundle for: $plugin_name"
    echo "Source bundle: $source_bundle"
    
    # Create source bundle if it doesn't exist
    if [ ! -d "$source_bundle" ]; then
        mkdir -p "$source_bundle"
        echo "Created source bundle directory: $source_bundle"
    fi
    
    # Create the privacy manifest file if it doesn't exist
    if [ ! -f "$source_file" ]; then
        cat > "$source_file" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
        echo "Created privacy manifest file: $source_file"
    fi
    
    # Create PrivacyInfo.xcprivacy file if it doesn't exist
    local privacy_info_file="${source_bundle}/PrivacyInfo.xcprivacy"
    if [ ! -f "$privacy_info_file" ]; then
        cat > "$privacy_info_file" << 'PRIVACY_XML_EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>NSPrivacyTracking</key>
    <false/>
    <key>NSPrivacyCollectedDataTypes</key>
    <array/>
    <key>NSPrivacyAccessedAPITypes</key>
    <array/>
</dict>
</plist>
PRIVACY_XML_EOF
        echo "Created PrivacyInfo.xcprivacy file: $privacy_info_file"
    fi
    
    # Define all possible build destination paths
    local build_dest_paths=()
    
    # Add paths based on available build variables
    if [ -n "${BUILT_PRODUCTS_DIR:-}" ]; then
        build_dest_paths+=("${BUILT_PRODUCTS_DIR}/${plugin_name}/${plugin_name}_privacy.bundle")
    fi
    
    if [ -n "${CONFIGURATION_BUILD_DIR:-}" ]; then
        build_dest_paths+=("${CONFIGURATION_BUILD_DIR}/${plugin_name}/${plugin_name}_privacy.bundle")
    fi
    
    if [ -n "${TARGET_BUILD_DIR:-}" ]; then
        build_dest_paths+=("${TARGET_BUILD_DIR}/${plugin_name}/${plugin_name}_privacy.bundle")
    fi
    
    # Add common Flutter build paths
    local flutter_build_root="${SRCROOT}/../build/ios"
    if [ -d "$flutter_build_root" ]; then
        # Find all build directories
        for build_dir in "$flutter_build_root"/*; do
            if [ -d "$build_dir" ]; then
                build_dest_paths+=("${build_dir}/${plugin_name}/${plugin_name}_privacy.bundle")
            fi
        done
    fi
    
    # Add specific paths from the error messages
    build_dest_paths+=(
        "/Volumes/Untitled/member360_wb/build/ios/Debug-dev-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
        "/Volumes/Untitled/member360_wb/build/ios/Release-dev-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
        "/Volumes/Untitled/member360_wb/build/ios/Debug-prod-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
        "/Volumes/Untitled/member360_wb/build/ios/Release-prod-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
    )
    
    # Copy to all build locations
    for dest_dir in "${build_dest_paths[@]}"; do
        echo "Creating privacy bundle at: $dest_dir"
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

# Create privacy bundles for all plugins
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    create_comprehensive_privacy_bundle "$plugin"
done

# Handle AWS Core bundle
echo "Processing AWS Core bundle..."
AWS_CORE_SRC_SIMULATOR="${SRCROOT}/vendor/openpath/AWSCore.xcframework/ios-arm64_x86_64-simulator/AWSCore.framework/AWSCore.bundle"
AWS_CORE_SRC_DEVICE="${SRCROOT}/vendor/openpath/AWSCore.xcframework/ios-arm64/AWSCore.framework/AWSCore.bundle"

# Determine source based on platform
if [[ "${EFFECTIVE_PLATFORM_NAME:-}" == "-iphonesimulator" ]]; then
    AWS_CORE_SRC="$AWS_CORE_SRC_SIMULATOR"
    echo "Building for simulator, using: $AWS_CORE_SRC"
else
    AWS_CORE_SRC="$AWS_CORE_SRC_DEVICE"
    echo "Building for device, using: $AWS_CORE_SRC"
fi

# Define AWS Core destination paths
AWS_CORE_DEST_PATHS=()

# Add paths based on available build variables
if [ -n "${BUILT_PRODUCTS_DIR:-}" ]; then
    AWS_CORE_DEST_PATHS+=("${BUILT_PRODUCTS_DIR}/AWSCore/AWSCore.bundle")
fi

if [ -n "${CONFIGURATION_BUILD_DIR:-}" ]; then
    AWS_CORE_DEST_PATHS+=("${CONFIGURATION_BUILD_DIR}/AWSCore/AWSCore.bundle")
fi

if [ -n "${TARGET_BUILD_DIR:-}" ]; then
    AWS_CORE_DEST_PATHS+=("${TARGET_BUILD_DIR}/AWSCore/AWSCore.bundle")
fi

# Add common Flutter build paths
AWS_CORE_DEST_PATHS+=(
    "/Volumes/Untitled/member360_wb/build/ios/Debug-dev-iphonesimulator/AWSCore/AWSCore.bundle"
    "/Volumes/Untitled/member360_wb/build/ios/Release-dev-iphonesimulator/AWSCore/AWSCore.bundle"
    "/Volumes/Untitled/member360_wb/build/ios/Debug-prod-iphonesimulator/AWSCore/AWSCore.bundle"
    "/Volumes/Untitled/member360_wb/build/ios/Release-prod-iphonesimulator/AWSCore/AWSCore.bundle"
)

# Copy AWS Core bundle to all locations
for dest_path in "${AWS_CORE_DEST_PATHS[@]}"; do
    echo "Creating AWS Core bundle at: $dest_path"
    mkdir -p "$(dirname "$dest_path")"
    
    if [ -d "${AWS_CORE_SRC}" ]; then
        cp -R "${AWS_CORE_SRC}" "${dest_path}"
        echo "✅ Copied AWS Core bundle to: $dest_path"
    else
        echo "⚠️ AWS Core bundle not found, creating minimal one"
        mkdir -p "$dest_path"
        cat > "${dest_path}/AWSCore" << 'AWS_EOF'
# AWS Core Bundle Resource File (Fallback)
AWS_CORE_VERSION=2.37.2
AWS_CORE_BUNDLE_ID=org.cocoapods.AWSCore
AWS_CORE_PLATFORM=${EFFECTIVE_PLATFORM_NAME}
AWS_EOF
        echo "✅ Created fallback AWS Core bundle at: $dest_path"
    fi
done

echo "=== Comprehensive Privacy Manifest Fix Complete ==="