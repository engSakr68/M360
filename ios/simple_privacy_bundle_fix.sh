#!/bin/bash

# Simple Privacy Bundle Fix Script
# This script creates privacy bundles in accessible locations and focuses on the local build environment

set -e
set -u
set -o pipefail

echo "=== Simple Privacy Bundle Fix Script ==="

# Set default paths
SRCROOT="${SRCROOT:-/workspace/ios}"
PROJECT_ROOT="${SRCROOT}/.."

echo "SRCROOT: $SRCROOT"
echo "PROJECT_ROOT: $PROJECT_ROOT"

# List of plugins that need privacy bundles (from the error messages)
PRIVACY_PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
)

# Function to create privacy bundle in source location
create_source_privacy_bundle() {
    local plugin_name="$1"
    local source_bundle="${SRCROOT}/${plugin_name}_privacy.bundle"
    local source_file="${source_bundle}/${plugin_name}_privacy"
    
    echo "Creating source privacy bundle for: $plugin_name"
    echo "Source bundle: $source_bundle"
    
    # Create source bundle directory
    mkdir -p "$source_bundle"
    
    # Create the privacy manifest file
    cat > "$source_file" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
    
    # Create PrivacyInfo.xcprivacy file
    cat > "${source_bundle}/PrivacyInfo.xcprivacy" << 'PRIVACY_XML_EOF'
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
    
    echo "✅ Created source privacy bundle for $plugin_name"
}

# Function to create privacy bundle in local build locations
create_local_build_privacy_bundle() {
    local plugin_name="$1"
    local source_bundle="${SRCROOT}/${plugin_name}_privacy.bundle"
    
    echo "Creating local build privacy bundles for: $plugin_name"
    
    # Define local build destination paths
    local build_dest_paths=()
    
    # Add common Flutter build paths
    local flutter_build_root="${PROJECT_ROOT}/build/ios"
    if [ -d "$flutter_build_root" ]; then
        # Find all build directories
        for build_dir in "$flutter_build_root"/*; do
            if [ -d "$build_dir" ]; then
                build_dest_paths+=("${build_dir}/${plugin_name}/${plugin_name}_privacy.bundle")
            fi
        done
    fi
    
    # Create build directory if it doesn't exist
    if [ ! -d "$flutter_build_root" ]; then
        mkdir -p "$flutter_build_root"
        echo "Created build directory: $flutter_build_root"
    fi
    
    # Create common build configurations
    local common_configs=(
        "Debug-dev-iphonesimulator"
        "Release-dev-iphonesimulator"
        "Debug-prod-iphonesimulator"
        "Release-prod-iphonesimulator"
        "Profile-dev-iphonesimulator"
        "Profile-prod-iphonesimulator"
        "Debug-dev-iphoneos"
        "Release-dev-iphoneos"
        "Debug-prod-iphoneos"
        "Release-prod-iphoneos"
        "Profile-dev-iphoneos"
        "Profile-prod-iphoneos"
    )
    
    for config in "${common_configs[@]}"; do
        local config_dir="${flutter_build_root}/${config}"
        if [ ! -d "$config_dir" ]; then
            mkdir -p "$config_dir"
            echo "Created build config directory: $config_dir"
        fi
        build_dest_paths+=("${config_dir}/${plugin_name}/${plugin_name}_privacy.bundle")
    done
    
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

# Create source privacy bundles for all plugins
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    create_source_privacy_bundle "$plugin"
done

# Create local build privacy bundles for all plugins
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    create_local_build_privacy_bundle "$plugin"
done

echo "=== Simple Privacy Bundle Fix Complete ==="