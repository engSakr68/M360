#!/bin/bash

# Comprehensive Privacy Bundle Fix Script
# This script fixes the nested privacy bundle structure issue

set -e
set -u
set -o pipefail

echo "=== Comprehensive Privacy Bundle Fix ==="

# Get build environment variables
SRCROOT="${SRCROOT:-/workspace/ios}"
BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR:-/workspace/ios/build/Debug-dev-iphonesimulator}"

echo "SRCROOT: $SRCROOT"
echo "BUILT_PRODUCTS_DIR: $BUILT_PRODUCTS_DIR"

# List of plugins that need privacy bundles
PRIVACY_PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
    "permission_handler_apple"
    "shared_preferences_foundation"
    "path_provider_foundation"
    "share_plus"
    "package_info_plus"
    "image_picker_ios"
)

# Function to fix privacy bundle structure
fix_privacy_bundle() {
    local plugin_name="$1"
    local plugin_dir="$BUILT_PRODUCTS_DIR/${plugin_name}"
    local bundle_dir="$plugin_dir/${plugin_name}_privacy.bundle"
    local nested_bundle_dir="$bundle_dir/${plugin_name}_privacy.bundle"
    local privacy_file="$bundle_dir/${plugin_name}_privacy"
    local nested_privacy_file="$nested_bundle_dir/${plugin_name}_privacy"
    
    echo "Processing privacy bundle for: $plugin_name"
    
    # Check if the plugin directory exists
    if [ ! -d "$plugin_dir" ]; then
        echo "⚠️ Plugin directory not found: $plugin_dir"
        return 0
    fi
    
    # Check if the bundle directory exists
    if [ ! -d "$bundle_dir" ]; then
        echo "⚠️ Bundle directory not found: $bundle_dir"
        return 0
    fi
    
    # Check if the privacy file exists in the correct location
    if [ -f "$privacy_file" ]; then
        echo "✅ Privacy file already in correct location: $privacy_file"
        return 0
    fi
    
    # Check if there's a nested structure
    if [ -d "$nested_bundle_dir" ] && [ -f "$nested_privacy_file" ]; then
        echo "🔧 Found nested structure, fixing..."
        
        # Copy the privacy file to the correct location
        cp "$nested_privacy_file" "$privacy_file"
        echo "✅ Copied privacy file from nested structure: $privacy_file"
        
        # Verify the copy
        if [ -f "$privacy_file" ]; then
            echo "✅ Verified privacy file copy for $plugin_name"
        else
            echo "❌ Failed to verify privacy file copy for $plugin_name"
            return 1
        fi
    else
        echo "⚠️ No nested structure found for $plugin_name"
        
        # Create minimal privacy bundle as fallback
        cat > "$privacy_file" << EOF
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
EOF
        echo "✅ Created minimal privacy bundle for $plugin_name"
    fi
}

# Fix all privacy bundles
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    fix_privacy_bundle "$plugin"
done

echo "=== Comprehensive Privacy Bundle Fix Complete ==="