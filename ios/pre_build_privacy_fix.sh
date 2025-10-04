#!/bin/bash

set -e
set -u
set -o pipefail

echo "=== Pre-Build Privacy Bundle Fix ==="

# Get the project root
PROJECT_ROOT="/workspace"
IOS_DIR="${PROJECT_ROOT}/ios"
BUILD_DIR="${IOS_DIR}/build"

echo "Project root: ${PROJECT_ROOT}"
echo "iOS directory: ${IOS_DIR}"
echo "Build directory: ${BUILD_DIR}"

# List of plugins that need privacy bundles
PRIVACY_PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
    "image_picker_ios"
    "permission_handler_apple"
    "shared_preferences_foundation"
    "share_plus"
    "path_provider_foundation"
    "package_info_plus"
    "firebase_messaging"
)

# Function to ensure privacy bundle exists and is properly structured
ensure_privacy_bundle() {
    local plugin_name="$1"
    local source_bundle="${IOS_DIR}/${plugin_name}_privacy.bundle"
    local source_privacy_file="${source_bundle}/${plugin_name}_privacy"
    
    echo "Processing privacy bundle for: $plugin_name"
    echo "Source bundle: $source_bundle"
    echo "Source privacy file: $source_privacy_file"
    
    # Check if source bundle exists
    if [ ! -d "$source_bundle" ]; then
        echo "⚠️ Source bundle not found: $source_bundle"
        return 1
    fi
    
    # Check if source privacy file exists
    if [ ! -f "$source_privacy_file" ]; then
        echo "⚠️ Source privacy file not found: $source_privacy_file"
        return 1
    fi
    
    echo "✅ Source privacy bundle verified for $plugin_name"
    
    # For each build configuration, ensure the privacy bundle is properly copied
    for build_config in "Debug-dev-iphonesimulator" "Debug-iphonesimulator" "Release-iphoneos" "Release-iphonesimulator"; do
        local build_config_dir="${BUILD_DIR}/${build_config}"
        
        if [ -d "$build_config_dir" ]; then
            echo "Processing build configuration: $build_config"
            
            # Copy to root level
            local dest_root_bundle="${build_config_dir}/${plugin_name}_privacy.bundle"
            local dest_root_file="${dest_root_bundle}/${plugin_name}_privacy"
            
            mkdir -p "$dest_root_bundle"
            cp "$source_privacy_file" "$dest_root_file"
            echo "✅ Copied to root level: $dest_root_file"
            
            # Copy to plugin subdirectory
            local dest_plugin_dir="${build_config_dir}/${plugin_name}"
            local dest_plugin_bundle="${dest_plugin_dir}/${plugin_name}_privacy.bundle"
            local dest_plugin_file="${dest_plugin_bundle}/${plugin_name}_privacy"
            
            mkdir -p "$dest_plugin_bundle"
            cp "$source_privacy_file" "$dest_plugin_file"
            echo "✅ Copied to plugin directory: $dest_plugin_file"
            
            # Verify both copies exist
            if [ -f "$dest_root_file" ] && [ -f "$dest_plugin_file" ]; then
                echo "✅ Verified both copies exist for $plugin_name in $build_config"
            else
                echo "❌ Failed to verify copies for $plugin_name in $build_config"
                return 1
            fi
        else
            echo "⚠️ Build configuration directory not found: $build_config_dir"
        fi
    done
    
    echo "✅ Privacy bundle processing complete for $plugin_name"
}

# Process all privacy bundles
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    ensure_privacy_bundle "$plugin"
done

echo "=== Pre-Build Privacy Bundle Fix Complete ==="