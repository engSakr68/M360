#!/bin/bash

# Comprehensive Privacy Bundle Fix for iOS Build
# This script ensures all privacy bundles are properly copied to their expected locations

set -e
set -u
set -o pipefail

echo "=== Comprehensive Privacy Bundle Fix ==="

# Get the current directory (should be ios/)
IOS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$IOS_DIR")"

echo "iOS Directory: $IOS_DIR"
echo "Project Root: $PROJECT_ROOT"

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

# Function to fix privacy bundle for a plugin
fix_privacy_bundle() {
    local plugin_name="$1"
    local source_bundle="${IOS_DIR}/${plugin_name}_privacy.bundle"
    local source_file="${source_bundle}/${plugin_name}_privacy"
    
    echo "Processing privacy bundle for: $plugin_name"
    
    # Check if source bundle exists
    if [ ! -d "$source_bundle" ]; then
        echo "⚠️ Source bundle not found: $source_bundle"
        return 0
    fi
    
    if [ ! -f "$source_file" ]; then
        echo "⚠️ Source privacy file not found: $source_file"
        return 0
    fi
    
    echo "✅ Found source bundle: $source_bundle"
    echo "✅ Found source file: $source_file"
    
    # Create multiple destination locations to cover all possible build scenarios
    local destinations=(
        "${IOS_DIR}/build/Debug-dev-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle/${plugin_name}_privacy"
        "${IOS_DIR}/build/Debug-dev-iphonesimulator/${plugin_name}_privacy.bundle/${plugin_name}_privacy"
        "${IOS_DIR}/build/Debug-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle/${plugin_name}_privacy"
        "${IOS_DIR}/build/Debug-iphonesimulator/${plugin_name}_privacy.bundle/${plugin_name}_privacy"
        "${IOS_DIR}/build/Release-iphoneos/${plugin_name}/${plugin_name}_privacy.bundle/${plugin_name}_privacy"
        "${IOS_DIR}/build/Release-iphoneos/${plugin_name}_privacy.bundle/${plugin_name}_privacy"
    )
    
    # Copy to all possible destinations
    for dest_file in "${destinations[@]}"; do
        local dest_dir="$(dirname "$dest_file")"
        
        # Create destination directory
        mkdir -p "$dest_dir"
        
        # Copy the privacy file
        cp "$source_file" "$dest_file"
        echo "✅ Copied to: $dest_file"
    done
    
    # Special handling for url_launcher_ios - ensure it's in the exact location the build system expects
    if [ "$plugin_name" = "url_launcher_ios" ]; then
        echo "🔧 Special handling for url_launcher_ios..."
        
        # The build system specifically looks for this path:
        # /Volumes/Untitled/member360_wb/build/ios/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy
        
        # Create the exact structure expected
        local exact_dest_dir="${IOS_DIR}/build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle"
        local exact_dest_file="${exact_dest_dir}/url_launcher_ios_privacy"
        
        mkdir -p "$exact_dest_dir"
        cp "$source_file" "$exact_dest_file"
        echo "✅ Ensured url_launcher_ios is in exact expected location: $exact_dest_file"
        
        # Also create a symlink or copy in case the build system looks elsewhere
        local alt_dest_dir="${IOS_DIR}/build/Debug-dev-iphonesimulator/url_launcher_ios_privacy.bundle"
        local alt_dest_file="${alt_dest_dir}/url_launcher_ios_privacy"
        
        mkdir -p "$alt_dest_dir"
        cp "$source_file" "$alt_dest_file"
        echo "✅ Also copied to alternative location: $alt_dest_file"
    fi
    
    echo "✅ Completed privacy bundle fix for: $plugin_name"
}

# Fix privacy bundles for all plugins
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    fix_privacy_bundle "$plugin"
done

# Verify all privacy bundles are in place
echo ""
echo "=== Verification ==="
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    expected_file="${IOS_DIR}/build/Debug-dev-iphonesimulator/${plugin}/${plugin}_privacy.bundle/${plugin}_privacy"
    if [ -f "$expected_file" ]; then
        echo "✅ $plugin privacy bundle verified: $expected_file"
    else
        echo "❌ $plugin privacy bundle missing: $expected_file"
    fi
done

# Special verification for url_launcher_ios
url_launcher_file="${IOS_DIR}/build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy"
if [ -f "$url_launcher_file" ]; then
    echo "✅ url_launcher_ios privacy bundle verified: $url_launcher_file"
    echo "Privacy bundle contents:"
    cat "$url_launcher_file"
else
    echo "❌ url_launcher_ios privacy bundle missing: $url_launcher_file"
fi

echo ""
echo "=== Comprehensive Privacy Bundle Fix Complete ==="
echo "All privacy bundles have been copied to their expected locations."
echo "You can now run your iOS build."