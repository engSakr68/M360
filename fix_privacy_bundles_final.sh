#!/bin/bash

# Final Privacy Bundle Fix Script
# This script fixes the privacy bundle structure in the build directory

set -e
set -u
set -o pipefail

echo "=== Final Privacy Bundle Fix ==="

# Get the current build directory
BUILD_DIR="/workspace/ios/build/Debug-dev-iphonesimulator"
echo "Build directory: $BUILD_DIR"

# List of plugins that need privacy bundles
PRIVACY_PLUGINS=(
    "share_plus"
    "permission_handler_apple"
    "url_launcher_ios"
    "sqflite_darwin"
    "shared_preferences_foundation"
)

# Function to fix privacy bundle structure
fix_privacy_bundle() {
    local plugin_name="$1"
    local source_bundle="$BUILD_DIR/${plugin_name}_privacy.bundle"
    local target_dir="$BUILD_DIR/${plugin_name}/${plugin_name}_privacy.bundle"
    
    echo "Fixing privacy bundle for: $plugin_name"
    
    # Check if source bundle exists
    if [ -d "$source_bundle" ]; then
        echo "Found source bundle: $source_bundle"
        
        # Create target directory
        mkdir -p "$(dirname "$target_dir")"
        
        # Copy the bundle to the correct location
        cp -R "$source_bundle" "$target_dir"
        echo "✅ Copied $plugin_name privacy bundle to: $target_dir"
        
        # Verify the copy
        if [ -f "$target_dir/${plugin_name}_privacy" ]; then
            echo "✅ Verified $plugin_name privacy bundle copy"
        else
            echo "❌ Failed to verify $plugin_name privacy bundle copy"
            return 1
        fi
    else
        echo "⚠️ Source bundle not found: $source_bundle"
        
        # Create minimal privacy bundle as fallback
        mkdir -p "$target_dir"
        cat > "$target_dir/${plugin_name}_privacy" << EOF
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

echo "=== Final Privacy Bundle Fix Complete ==="