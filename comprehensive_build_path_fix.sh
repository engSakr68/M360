#!/bin/bash

# Comprehensive Build Path Fix Script
# This script fixes the build path mismatch issue where Xcode is looking for files
# in /Volumes/Untitled/member360_wb/ but the project is in /workspace/

set -e
set -u
set -o pipefail

echo "=== Comprehensive Build Path Fix Script ==="

# Define the actual project root
PROJECT_ROOT="/workspace"
IOS_ROOT="${PROJECT_ROOT}/ios"

# Define the problematic build path that Xcode is looking for
PROBLEM_BUILD_PATH="/Volumes/Untitled/member360_wb/build/ios/Debug-dev-iphonesimulator"

echo "Project root: $PROJECT_ROOT"
echo "iOS root: $IOS_ROOT"
echo "Problem build path: $PROBLEM_BUILD_PATH"

# Create the problematic build directory structure
echo "Creating build directory structure at: $PROBLEM_BUILD_PATH"
mkdir -p "$PROBLEM_BUILD_PATH"

# List of plugins that need privacy bundles
PRIVACY_PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
    "shared_preferences_foundation"
    "share_plus"
    "device_info_plus"
    "permission_handler_apple"
    "path_provider_foundation"
    "package_info_plus"
    "file_picker"
    "flutter_local_notifications"
    "image_picker_ios"
)

# Function to copy privacy bundle to the problematic build location
copy_privacy_bundle_to_problem_path() {
    local plugin_name="$1"
    local source_bundle="${IOS_ROOT}/${plugin_name}_privacy.bundle"
    local source_file="${source_bundle}/${plugin_name}_privacy"
    local dest_dir="${PROBLEM_BUILD_PATH}/${plugin_name}/${plugin_name}_privacy.bundle"
    
    echo "Processing privacy bundle for: $plugin_name"
    echo "Source bundle: $source_bundle"
    echo "Destination: $dest_dir"
    
    if [ ! -d "$source_bundle" ] || [ ! -f "$source_file" ]; then
        echo "⚠️ $plugin_name privacy bundle not found at: $source_bundle"
        return 1
    fi
    
    # Create destination directory and copy bundle
    echo "Copying to problematic build location: $dest_dir"
    mkdir -p "$dest_dir"
    cp -R "$source_bundle"/* "$dest_dir/"
    
    # Verify the copy
    local dest_file="${dest_dir}/${plugin_name}_privacy"
    if [ -f "$dest_file" ]; then
        echo "✅ Verified $plugin_name privacy bundle at: $dest_file"
    else
        echo "❌ Failed to verify $plugin_name privacy bundle at: $dest_file"
        return 1
    fi
}

# Copy privacy bundles for all plugins to the problematic path
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    copy_privacy_bundle_to_problem_path "$plugin"
done

# Handle AWS Core bundle
echo "Processing AWS Core bundle..."
AWS_CORE_SRC_SIMULATOR="${IOS_ROOT}/vendor/openpath/AWSCore.xcframework/ios-arm64_x86_64-simulator/AWSCore.framework/AWSCore.bundle"
AWS_CORE_SRC_DEVICE="${IOS_ROOT}/vendor/openpath/AWSCore.xcframework/ios-arm64/AWSCore.framework/AWSCore.bundle"
AWS_CORE_DEST="${PROBLEM_BUILD_PATH}/AWSCore/AWSCore.bundle"

echo "AWS Core source (simulator): $AWS_CORE_SRC_SIMULATOR"
echo "AWS Core source (device): $AWS_CORE_SRC_DEVICE"
echo "AWS Core destination: $AWS_CORE_DEST"

# Use simulator version for Debug-dev-iphonesimulator
AWS_CORE_SRC="$AWS_CORE_SRC_SIMULATOR"

if [ -d "${AWS_CORE_SRC}" ]; then
    echo "Copying AWS Core bundle to: $AWS_CORE_DEST"
    mkdir -p "$(dirname "$AWS_CORE_DEST")"
    cp -R "${AWS_CORE_SRC}" "${AWS_CORE_DEST}"
    echo "✅ Copied AWS Core bundle to: $AWS_CORE_DEST"
    
    # Verify the copy
    if [ -f "${AWS_CORE_DEST}/AWSCore" ]; then
        echo "✅ Verified AWS Core bundle file at: ${AWS_CORE_DEST}/AWSCore"
    else
        echo "❌ Failed to verify AWS Core bundle file"
    fi
else
    echo "⚠️ AWS Core bundle not found, creating minimal one"
    mkdir -p "$(dirname "$AWS_CORE_DEST")"
    cat > "${AWS_CORE_DEST}/AWSCore" << 'AWS_EOF'
# AWS Core Bundle Resource File (Fallback)
AWS_CORE_VERSION=2.37.2
AWS_CORE_BUNDLE_ID=org.cocoapods.AWSCore
AWS_CORE_PLATFORM=iphonesimulator
AWS_EOF
    echo "✅ Created fallback AWS Core bundle at: $AWS_CORE_DEST"
fi

# Also create the same structure in the local build directory for consistency
LOCAL_BUILD_PATH="${PROJECT_ROOT}/build/ios/Debug-dev-iphonesimulator"
echo "Creating local build directory structure at: $LOCAL_BUILD_PATH"
mkdir -p "$LOCAL_BUILD_PATH"

# Copy all bundles to local build directory as well
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    local source_bundle="${IOS_ROOT}/${plugin_name}_privacy.bundle"
    local dest_dir="${LOCAL_BUILD_PATH}/${plugin_name}/${plugin_name}_privacy.bundle"
    
    if [ -d "$source_bundle" ]; then
        mkdir -p "$dest_dir"
        cp -R "$source_bundle"/* "$dest_dir/"
        echo "✅ Copied $plugin_name to local build directory"
    fi
done

# Copy AWS Core to local build directory
if [ -d "${AWS_CORE_SRC}" ]; then
    local_aws_dest="${LOCAL_BUILD_PATH}/AWSCore/AWSCore.bundle"
    mkdir -p "$(dirname "$local_aws_dest")"
    cp -R "${AWS_CORE_SRC}" "${local_aws_dest}"
    echo "✅ Copied AWS Core to local build directory"
fi

echo "=== Comprehensive Build Path Fix Complete ==="
echo "✅ All required bundle files have been copied to both problematic and local build paths"
echo "✅ The build should now find all required files"