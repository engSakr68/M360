#!/bin/bash

# Ensure Privacy Bundles Script
# This script ensures all privacy bundles are available during build

set -e
set -u
set -o pipefail

echo "=== Ensuring Privacy Bundles are Available ==="

# Get build environment variables
SRCROOT="${SRCROOT:-$(pwd)}"
BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR:-}"
CONFIGURATION_BUILD_DIR="${CONFIGURATION_BUILD_DIR:-}"

echo "SRCROOT: $SRCROOT"
echo "BUILT_PRODUCTS_DIR: $BUILT_PRODUCTS_DIR"
echo "CONFIGURATION_BUILD_DIR: $CONFIGURATION_BUILD_DIR"

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

# Function to ensure privacy bundle is available
ensure_privacy_bundle() {
    local plugin_name="$1"
    local bundle_dir="$SRCROOT/${plugin_name}_privacy.bundle"
    local dest_dir="$BUILT_PRODUCTS_DIR/${plugin_name}/${plugin_name}_privacy.bundle"
    
    echo "Ensuring privacy bundle for: $plugin_name"
    
    if [ -d "$bundle_dir" ]; then
        # Create destination directory
        mkdir -p "$(dirname "$dest_dir")"
        
        # Copy the bundle
        cp -R "$bundle_dir" "$dest_dir"
        echo "✅ Ensured $plugin_name privacy bundle at: $dest_dir"
        
        # Verify the copy
        if [ -f "$dest_dir/${plugin_name}_privacy" ]; then
            echo "✅ Verified $plugin_name privacy bundle"
        else
            echo "❌ Failed to verify $plugin_name privacy bundle"
            return 1
        fi
    else
        echo "❌ Source bundle not found: $bundle_dir"
        return 1
    fi
}

# Ensure all privacy bundles are available
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    ensure_privacy_bundle "$plugin"
done

echo "=== Privacy Bundles Ensured ==="
