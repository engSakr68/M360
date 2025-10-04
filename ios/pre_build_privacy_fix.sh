#!/bin/bash

# Pre-Build Privacy Bundle Fix
# This script ensures all privacy bundles are in place before the build starts

set -e
set -u
set -o pipefail

echo "=== Pre-Build Privacy Bundle Fix ==="

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IOS_DIR="${PROJECT_ROOT}/ios"

echo "Project Root: ${PROJECT_ROOT}"
echo "iOS Directory: ${IOS_DIR}"

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
    "firebase_messaging"
)

# Function to copy privacy bundle
copy_privacy_bundle() {
    local plugin_name="$1"
    local source_bundle="${IOS_DIR}/${plugin_name}_privacy.bundle"
    local source_file="${source_bundle}/${plugin_name}_privacy"
    
    echo "Processing privacy bundle for: $plugin_name"
    
    if [ -f "$source_file" ]; then
        echo "✅ Found source file: $source_file"
        
        # Copy to multiple build configurations
        local build_configs=(
            "Debug-dev-iphonesimulator"
            "Debug-iphonesimulator"
            "Release-iphonesimulator"
            "Release-iphoneos"
        )
        
        for config in "${build_configs[@]}"; do
            local build_dir="${IOS_DIR}/build/${config}"
            local dest_dir="${build_dir}/${plugin_name}/${plugin_name}_privacy.bundle"
            local dest_file="${dest_dir}/${plugin_name}_privacy"
            
            # Create destination directory
            mkdir -p "$dest_dir"
            
            # Copy the privacy file
            cp "$source_file" "$dest_file"
            echo "✅ Copied to: $dest_file"
            
            # Also copy to bundle root for compatibility
            local bundle_root="${build_dir}/${plugin_name}_privacy.bundle"
            mkdir -p "$bundle_root"
            cp "$source_file" "${bundle_root}/${plugin_name}_privacy"
            echo "✅ Also copied to bundle root: ${bundle_root}/${plugin_name}_privacy"
        done
        
        echo "✅ Completed privacy bundle fix for: $plugin_name"
    else
        echo "⚠️ Privacy bundle not found for: $plugin_name at $source_file"
        
        # Create minimal privacy bundle as fallback
        for config in "${build_configs[@]}"; do
            local build_dir="${IOS_DIR}/build/${config}"
            local dest_dir="${build_dir}/${plugin_name}/${plugin_name}_privacy.bundle"
            local dest_file="${dest_dir}/${plugin_name}_privacy"
            
            mkdir -p "$dest_dir"
            cat > "$dest_file" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
            echo "✅ Created minimal privacy bundle for $plugin_name at $dest_file"
        done
    fi
}

# Copy privacy bundles for all plugins
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    copy_privacy_bundle "$plugin"
done

# Special verification for url_launcher_ios
url_launcher_file="${IOS_DIR}/build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy"
if [ -f "$url_launcher_file" ]; then
    echo "✅ url_launcher_ios privacy bundle verified: $url_launcher_file"
else
    echo "❌ url_launcher_ios privacy bundle missing: $url_launcher_file"
    exit 1
fi

echo "=== Pre-Build Privacy Bundle Fix Complete ==="
echo "All privacy bundles are now in place for the build."