#!/bin/bash

# Pre-build Privacy Bundle Fix Script
# This script runs during Xcode build to ensure privacy bundles are available

set -e
set -u
set -o pipefail

echo "=== Pre-Build Privacy Bundle Fix ==="

# Get build environment variables
SRCROOT="${SRCROOT:-$(pwd)}"
BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR:-}"
CONFIGURATION_BUILD_DIR="${CONFIGURATION_BUILD_DIR:-}"

echo "SRCROOT: $SRCROOT"
echo "BUILT_PRODUCTS_DIR: $BUILT_PRODUCTS_DIR"
echo "CONFIGURATION_BUILD_DIR: $CONFIGURATION_BUILD_DIR"

# List of plugins that need privacy bundles
PRIVACY_PLUGINS=(
    "share_plus"
    "permission_handler_apple"
    "url_launcher_ios"
    "sqflite_darwin"
    "shared_preferences_foundation"
)

# Function to copy privacy bundle
copy_privacy_bundle() {
    local plugin_name="$1"
    local bundle_dir="$SRCROOT/${plugin_name}_privacy.bundle"
    local dest_dir="$BUILT_PRODUCTS_DIR/${plugin_name}/${plugin_name}_privacy.bundle"
    
    echo "Processing privacy bundle for: $plugin_name"
    
    if [ -d "$bundle_dir" ]; then
        # Create destination directory
        mkdir -p "$(dirname "$dest_dir")"
        
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
        echo "⚠️ Source bundle not found: $bundle_dir"
        
        # Create minimal privacy bundle as fallback
        mkdir -p "$dest_dir"
        cat > "$dest_dir/${plugin_name}_privacy" << EOF
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
EOF
        echo "✅ Created minimal privacy bundle for $plugin_name"
    fi
}

# Copy all privacy bundles
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    copy_privacy_bundle "$plugin"
done

echo "=== Pre-Build Privacy Bundle Fix Complete ==="
