#!/bin/bash

# Enhanced Privacy Bundle Fix Script
# This script addresses the path mismatch issue where the build system looks for
# privacy bundles in /Volumes/Untitled/member360_wb/ but they're located in /workspace/

set -e
set -u
set -o pipefail

echo "=== Enhanced Privacy Bundle Fix ==="
echo "Addressing path mismatch: /Volumes/Untitled/member360_wb/ vs /workspace/"

# Get current working directory
WORKSPACE_DIR="$(pwd)"
IOS_DIR="${WORKSPACE_DIR}/ios"

echo "Workspace Directory: $WORKSPACE_DIR"
echo "iOS Directory: $IOS_DIR"

# List of plugins that need privacy bundles (from the error messages)
PRIVACY_PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
    "shared_preferences_foundation"
    "share_plus"
    "permission_handler_apple"
    "path_provider_foundation"
    "package_info_plus"
    "image_picker_ios"
    "fluttertoast"
    "flutter_local_notifications"
)

# Function to create privacy bundle in the expected path
create_privacy_bundle_in_expected_path() {
    local plugin_name="$1"
    local source_bundle="${IOS_DIR}/${plugin_name}_privacy.bundle"
    local source_file="${source_bundle}/${plugin_name}_privacy"
    
    echo "Processing privacy bundle for: $plugin_name"
    
    # Check if source bundle exists
    if [ ! -d "$source_bundle" ]; then
        echo "⚠️ Source bundle not found: $source_bundle"
        return 1
    fi
    
    if [ ! -f "$source_file" ]; then
        echo "⚠️ Source privacy file not found: $source_file"
        return 1
    fi
    
    echo "✅ Found source bundle: $source_bundle"
    echo "✅ Found source file: $source_file"
    
    # The build system expects files at:
    # /Volumes/Untitled/member360_wb/build/ios/Debug-dev-iphonesimulator/{plugin}/{plugin}_privacy.bundle/{plugin}_privacy
    
    # Create the expected path structure in the workspace
    local expected_base_path="${WORKSPACE_DIR}/build/ios/Debug-dev-iphonesimulator"
    local plugin_build_dir="${expected_base_path}/${plugin_name}"
    local privacy_bundle_dir="${plugin_build_dir}/${plugin_name}_privacy.bundle"
    local expected_privacy_file="${privacy_bundle_dir}/${plugin_name}_privacy"
    
    echo "Creating expected path structure:"
    echo "  Plugin build dir: $plugin_build_dir"
    echo "  Privacy bundle dir: $privacy_bundle_dir"
    echo "  Expected privacy file: $expected_privacy_file"
    
    # Create the directory structure
    mkdir -p "$privacy_bundle_dir"
    
    # Copy the privacy file
    cp "$source_file" "$expected_privacy_file"
    
    # Also copy the PrivacyInfo.xcprivacy file if it exists
    local privacy_info_file="${source_bundle}/PrivacyInfo.xcprivacy"
    if [ -f "$privacy_info_file" ]; then
        cp "$privacy_info_file" "${privacy_bundle_dir}/PrivacyInfo.xcprivacy"
        echo "✅ Copied PrivacyInfo.xcprivacy"
    fi
    
    # Verify the copy
    if [ -f "$expected_privacy_file" ]; then
        echo "✅ Successfully created privacy bundle at: $expected_privacy_file"
        echo "   File size: $(wc -c < "$expected_privacy_file") bytes"
    else
        echo "❌ Failed to create privacy bundle at: $expected_privacy_file"
        return 1
    fi
    
    # Create alternative paths that the build system might look for
    local alt_paths=(
        "${expected_base_path}/${plugin_name}_privacy.bundle/${plugin_name}_privacy"
        "${WORKSPACE_DIR}/build/ios/Debug-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle/${plugin_name}_privacy"
        "${WORKSPACE_DIR}/build/ios/Release-dev-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle/${plugin_name}_privacy"
        "${WORKSPACE_DIR}/build/ios/Release-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle/${plugin_name}_privacy"
    )
    
    for alt_path in "${alt_paths[@]}"; do
        local alt_dir="$(dirname "$alt_path")"
        mkdir -p "$alt_dir"
        cp "$source_file" "$alt_path"
        echo "✅ Also copied to alternative path: $alt_path"
    done
}

# Create privacy bundles for all plugins
echo ""
echo "=== Creating Privacy Bundles in Expected Paths ==="
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    create_privacy_bundle_in_expected_path "$plugin"
    echo ""
done

# Create a comprehensive build directory structure
echo "=== Creating Comprehensive Build Directory Structure ==="
BUILD_CONFIGS=(
    "Debug-dev-iphonesimulator"
    "Debug-iphonesimulator"
    "Release-dev-iphonesimulator"
    "Release-iphonesimulator"
    "Debug-prod-iphonesimulator"
    "Release-prod-iphonesimulator"
    "Debug-stage-iphonesimulator"
    "Release-stage-iphonesimulator"
)

for config in "${BUILD_CONFIGS[@]}"; do
    config_dir="${WORKSPACE_DIR}/build/ios/${config}"
    echo "Creating build config directory: $config_dir"
    
    for plugin in "${PRIVACY_PLUGINS[@]}"; do
        plugin_dir="${config_dir}/${plugin}"
        privacy_bundle_dir="${plugin_dir}/${plugin}_privacy.bundle"
        privacy_file="${privacy_bundle_dir}/${plugin}_privacy"
        
        # Create directory structure
        mkdir -p "$privacy_bundle_dir"
        
        # Copy privacy file if source exists
        source_file="${IOS_DIR}/${plugin}_privacy.bundle/${plugin}_privacy"
        if [ -f "$source_file" ]; then
            cp "$source_file" "$privacy_file"
            echo "  ✅ Created: $privacy_file"
        else
            echo "  ⚠️ Source not found for: $plugin"
        fi
    done
done

# Create a symbolic link or directory structure that matches the expected volume path
echo ""
echo "=== Creating Volume Path Compatibility ==="
VOLUME_PATH="/Volumes/Untitled/member360_wb"
EXPECTED_BUILD_PATH="${VOLUME_PATH}/build/ios/Debug-dev-iphonesimulator"

echo "Expected volume path: $VOLUME_PATH"
echo "Expected build path: $EXPECTED_BUILD_PATH"

# Check if we can create the volume path (this might fail due to permissions)
if mkdir -p "${VOLUME_PATH}/build/ios/Debug-dev-iphonesimulator" 2>/dev/null; then
    echo "✅ Successfully created volume path structure"
    
    # Copy all privacy bundles to the volume path
    for plugin in "${PRIVACY_PLUGINS[@]}"; do
        source_file="${WORKSPACE_DIR}/build/ios/Debug-dev-iphonesimulator/${plugin}/${plugin}_privacy.bundle/${plugin}_privacy"
        if [ -f "$source_file" ]; then
            dest_dir="${EXPECTED_BUILD_PATH}/${plugin}/${plugin}_privacy.bundle"
            mkdir -p "$dest_dir"
            cp "$source_file" "${dest_dir}/${plugin}_privacy"
            echo "✅ Copied $plugin to volume path: ${dest_dir}/${plugin}_privacy"
        fi
    done
else
    echo "⚠️ Cannot create volume path (permission denied or volume not mounted)"
    echo "   This is expected in some environments. The workspace path should work."
fi

# Verification
echo ""
echo "=== Verification ==="
echo "Checking privacy bundles in workspace build directory:"
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    expected_file="${WORKSPACE_DIR}/build/ios/Debug-dev-iphonesimulator/${plugin}/${plugin}_privacy.bundle/${plugin}_privacy"
    if [ -f "$expected_file" ]; then
        echo "✅ $plugin: $expected_file"
    else
        echo "❌ $plugin: Missing at $expected_file"
    fi
done

echo ""
echo "=== Enhanced Privacy Bundle Fix Complete ==="
echo "All privacy bundles have been created in the expected build paths."
echo "The build system should now find the privacy bundle files."
echo ""
echo "Next steps:"
echo "1. Run 'pod install' in the ios/ directory"
echo "2. Build your iOS app"
echo "3. If you still get path errors, the build system variables may need adjustment"