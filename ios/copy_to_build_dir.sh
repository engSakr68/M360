#!/bin/bash

# Manual copy script for privacy bundles
set -e
set -u
set -o pipefail

if [ $# -eq 0 ]; then
    echo "Usage: $0 <build_directory>"
    echo "Example: $0 /Volumes/Untitled/member360_wb/build/ios/Debug-dev-iphonesimulator"
    exit 1
fi

BUILD_DIR="$1"
IOS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Manual Privacy Bundle Copy ==="
echo "Build Directory: $BUILD_DIR"
echo "iOS Directory: $IOS_DIR"

# List of plugins that need privacy bundles
PRIVACY_PLUGINS=(
    "image_picker_ios"
    "url_launcher_ios"
    "sqflite_darwin"
    "permission_handler_apple"
    "shared_preferences_foundation"
    "share_plus"
    "path_provider_foundation"
    "package_info_plus"
)

# Function to copy privacy bundle
copy_privacy_bundle() {
    local plugin_name="$1"
    local bundle_dir="$IOS_DIR/${plugin_name}_privacy.bundle"
    local dest_dir="$BUILD_DIR/${plugin_name}/${plugin_name}_privacy.bundle"
    
    echo "Processing privacy bundle for: $plugin_name"
    
    if [ -d "$bundle_dir" ]; then
        # Create destination directory
        mkdir -p "$(dirname "$dest_dir")"
        
        # Remove existing bundle if it exists
        rm -rf "$dest_dir"
        
        # Copy the bundle
        cp -R "$bundle_dir" "$dest_dir"
        echo "✅ Copied $plugin_name privacy bundle to: $dest_dir"
        
        # Verify the copy
        if [ -f "$dest_dir/${plugin_name}_privacy" ]; then
            echo "✅ Verified $plugin_name privacy bundle copy"
        else
            echo "❌ Failed to verify $plugin_name privacy bundle copy"
            return 1
        fi
    else
        echo "❌ Source bundle not found: $bundle_dir"
        return 1
    fi
}

# Copy all privacy bundles
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    copy_privacy_bundle "$plugin"
done

echo "=== Manual Privacy Bundle Copy Complete ==="
