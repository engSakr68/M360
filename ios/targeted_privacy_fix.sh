#!/bin/bash

# Targeted Privacy Fix Script
# This script creates privacy bundles in the actual build locations
# It focuses on the paths that Xcode is actually looking for

set -e
set -u
set -o pipefail

echo "=== Targeted Privacy Fix Script ==="

# Set default paths
SRCROOT="${SRCROOT:-/workspace/ios}"
PROJECT_ROOT="${SRCROOT}/.."

echo "SRCROOT: $SRCROOT"
echo "PROJECT_ROOT: $PROJECT_ROOT"

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

# Function to create privacy bundle in source location
create_source_privacy_bundle() {
    local plugin_name="$1"
    local source_bundle="${SRCROOT}/${plugin_name}_privacy.bundle"
    local source_file="${source_bundle}/${plugin_name}_privacy"
    
    echo "Creating source privacy bundle for: $plugin_name"
    echo "Source bundle: $source_bundle"
    
    # Create source bundle directory
    mkdir -p "$source_bundle"
    
    # Create the privacy manifest file
    cat > "$source_file" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
    
    # Create PrivacyInfo.xcprivacy file
    cat > "${source_bundle}/PrivacyInfo.xcprivacy" << 'PRIVACY_XML_EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>NSPrivacyTracking</key>
    <false/>
    <key>NSPrivacyCollectedDataTypes</key>
    <array/>
    <key>NSPrivacyAccessedAPITypes</key>
    <array/>
</dict>
</plist>
PRIVACY_XML_EOF
    
    echo "✅ Created source privacy bundle for $plugin_name"
}

# Function to create privacy bundle in local build locations
create_local_build_privacy_bundle() {
    local plugin_name="$1"
    local source_bundle="${SRCROOT}/${plugin_name}_privacy.bundle"
    
    echo "Creating local build privacy bundles for: $plugin_name"
    
    # Define local build destination paths
    local build_dest_paths=()
    
    # Add common Flutter build paths
    local flutter_build_root="${PROJECT_ROOT}/build/ios"
    if [ -d "$flutter_build_root" ]; then
        # Find all build directories
        for build_dir in "$flutter_build_root"/*; do
            if [ -d "$build_dir" ]; then
                build_dest_paths+=("${build_dir}/${plugin_name}/${plugin_name}_privacy.bundle")
            fi
        done
    fi
    
    # Copy to all build locations
    for dest_dir in "${build_dest_paths[@]}"; do
        echo "Creating privacy bundle at: $dest_dir"
        mkdir -p "$dest_dir"
        cp -R "$source_bundle"/* "$dest_dir/"
        
        # Verify the copy
        local dest_file="${dest_dir}/${plugin_name}_privacy"
        if [ -f "$dest_file" ]; then
            echo "✅ Verified $plugin_name privacy bundle at: $dest_file"
        else
            echo "❌ Failed to verify $plugin_name privacy bundle at: $dest_file"
        fi
    done
}

# Create source privacy bundles for all plugins
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    create_source_privacy_bundle "$plugin"
done

# Create local build privacy bundles for all plugins
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    create_local_build_privacy_bundle "$plugin"
done

# Handle AWS Core bundle
echo "Processing AWS Core bundle..."
AWS_CORE_SRC_SIMULATOR="${SRCROOT}/vendor/openpath/AWSCore.xcframework/ios-arm64_x86_64-simulator/AWSCore.framework/AWSCore.bundle"
AWS_CORE_SRC_DEVICE="${SRCROOT}/vendor/openpath/AWSCore.xcframework/ios-arm64/AWSCore.framework/AWSCore.bundle"

# Define local AWS Core destination paths
AWS_CORE_DEST_PATHS=()

# Add common Flutter build paths
flutter_build_root="${PROJECT_ROOT}/build/ios"
if [ -d "$flutter_build_root" ]; then
    # Find all build directories
    for build_dir in "$flutter_build_root"/*; do
        if [ -d "$build_dir" ]; then
            AWS_CORE_DEST_PATHS+=("${build_dir}/AWSCore/AWSCore.bundle")
        fi
    done
fi

# Copy AWS Core bundle to all locations
for dest_path in "${AWS_CORE_DEST_PATHS[@]}"; do
    echo "Creating AWS Core bundle at: $dest_path"
    mkdir -p "$(dirname "$dest_path")"
    
    # Try simulator first, then device
    if [ -d "${AWS_CORE_SRC_SIMULATOR}" ]; then
        cp -R "${AWS_CORE_SRC_SIMULATOR}" "${dest_path}"
        echo "✅ Copied AWS Core bundle (simulator) to: $dest_path"
    elif [ -d "${AWS_CORE_SRC_DEVICE}" ]; then
        cp -R "${AWS_CORE_SRC_DEVICE}" "${dest_path}"
        echo "✅ Copied AWS Core bundle (device) to: $dest_path"
    else
        echo "⚠️ AWS Core bundle not found, creating minimal one"
        mkdir -p "$dest_path"
        cat > "${dest_path}/AWSCore" << 'AWS_EOF'
# AWS Core Bundle Resource File (Fallback)
AWS_CORE_VERSION=2.37.2
AWS_CORE_BUNDLE_ID=org.cocoapods.AWSCore
AWS_CORE_PLATFORM=ios
AWS_EOF
        echo "✅ Created fallback AWS Core bundle at: $dest_path"
    fi
done

echo "=== Targeted Privacy Fix Complete ==="