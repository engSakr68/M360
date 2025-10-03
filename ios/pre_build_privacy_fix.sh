#!/bin/bash

set -e
set -u
set -o pipefail

echo "=== Pre-Build Privacy Bundle Fix ==="

SRCROOT="${SRCROOT}"
BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR}"
CONFIGURATION_BUILD_DIR="${CONFIGURATION_BUILD_DIR}"

echo "SRCROOT: ${SRCROOT}"
echo "BUILT_PRODUCTS_DIR: ${BUILT_PRODUCTS_DIR}"
echo "CONFIGURATION_BUILD_DIR: ${CONFIGURATION_BUILD_DIR}"

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
    local bundle_dir="${SRCROOT}/${plugin_name}_privacy.bundle"
    local dest_dir="${BUILT_PRODUCTS_DIR}/${plugin_name}/${plugin_name}_privacy.bundle"
    local privacy_file="$dest_dir/${plugin_name}_privacy"
    
    echo "Processing privacy bundle for: $plugin_name"
    
    if [ -d "$bundle_dir" ]; then
        # Create destination directory
        mkdir -p "$(dirname "$dest_dir")"
        
        # Copy the bundle
        cp -R "$bundle_dir" "$dest_dir"
        echo "✅ Copied $plugin_name privacy bundle to: $dest_dir"
        
        # Special handling for firebase_messaging to handle capitalization differences
        if [ "$plugin_name" = "firebase_messaging" ]; then
            echo "🔧 Special handling for firebase_messaging..."
            # Handle both lowercase and capitalized versions
            local source_privacy_file="${bundle_dir}/${plugin_name}_privacy"
            if [ -f "$source_privacy_file" ]; then
                cp "$source_privacy_file" "$privacy_file"
                echo "✅ Ensured firebase_messaging privacy file is in correct location"
            fi
            
            # Also copy with capitalized naming for compatibility
            local capitalized_privacy_file="${dest_dir}/firebase_messaging_Privacy"
            cp "$source_privacy_file" "$capitalized_privacy_file"
            echo "✅ Also copied firebase_messaging privacy bundle with capitalized naming"
        fi
        
        # Verify the copy
        if [ -f "$privacy_file" ]; then
            echo "✅ Verified $plugin_name privacy bundle copy"
        else
            echo "❌ Failed to verify $plugin_name privacy bundle copy"
            return 1
        fi
    else
        echo "⚠️ $plugin_name privacy bundle not found at $bundle_dir"
        # Create minimal privacy bundle as fallback
        mkdir -p "$dest_dir"
        cat > "$privacy_file" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
        echo "✅ Created minimal privacy bundle for $plugin_name"
    fi
}

# Copy privacy bundles for all plugins
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    copy_privacy_bundle "$plugin"
done

echo "=== Pre-Build Privacy Bundle Fix Complete ==="
