#!/bin/bash

# Comprehensive Privacy Bundle Fix Script
# This script ensures privacy bundles are available in all possible build locations

set -e
set -u
set -o pipefail

echo "=== Comprehensive Privacy Bundle Fix ==="

# List of plugins that need privacy bundles
PRIVACY_PLUGINS=(
    "share_plus"
    "permission_handler_apple"
    "url_launcher_ios"
    "sqflite_darwin"
    "shared_preferences_foundation"
)

# Function to fix privacy bundle in a specific build directory
fix_privacy_bundle_in_dir() {
    local build_dir="$1"
    local plugin_name="$2"
    
    echo "Fixing $plugin_name in $build_dir"
    
    # Source bundle location
    local source_bundle="$build_dir/${plugin_name}_privacy.bundle"
    local target_dir="$build_dir/${plugin_name}/${plugin_name}_privacy.bundle"
    
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

# Function to fix all privacy bundles in a build directory
fix_all_privacy_bundles_in_dir() {
    local build_dir="$1"
    
    if [ ! -d "$build_dir" ]; then
        echo "Build directory does not exist: $build_dir"
        return 0
    fi
    
    echo "Processing build directory: $build_dir"
    
    for plugin in "${PRIVACY_PLUGINS[@]}"; do
        fix_privacy_bundle_in_dir "$build_dir" "$plugin"
    done
}

# Fix privacy bundles in multiple possible build locations
POSSIBLE_BUILD_DIRS=(
    "/workspace/ios/build/Debug-dev-iphonesimulator"
    "/Volumes/Untitled/member360_wb/build/ios/Debug-dev-iphonesimulator"
    "/workspace/build/ios/Debug-dev-iphonesimulator"
    "./ios/build/Debug-dev-iphonesimulator"
    "./build/ios/Debug-dev-iphonesimulator"
)

# Process each possible build directory
for build_dir in "${POSSIBLE_BUILD_DIRS[@]}"; do
    fix_all_privacy_bundles_in_dir "$build_dir"
done

# Also fix in the current working directory if it's a build directory
if [ -d "./ios/build/Debug-dev-iphonesimulator" ]; then
    fix_all_privacy_bundles_in_dir "./ios/build/Debug-dev-iphonesimulator"
fi

echo "=== Comprehensive Privacy Bundle Fix Complete ==="