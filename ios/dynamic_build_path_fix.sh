#!/bin/bash

# Dynamic Build Path Fix Script
# This script runs during Xcode build to fix missing bundle files
# It detects the actual build path and creates the required files

set -e
set -u
set -o pipefail

echo "=== Dynamic Build Path Fix Script ==="

# Debug: Show all available build variables
echo "Available build variables:"
echo "SRCROOT: ${SRCROOT:-NOT_SET}"
echo "BUILT_PRODUCTS_DIR: ${BUILT_PRODUCTS_DIR:-NOT_SET}"
echo "CONFIGURATION_BUILD_DIR: ${CONFIGURATION_BUILD_DIR:-NOT_SET}"
echo "EFFECTIVE_PLATFORM_NAME: ${EFFECTIVE_PLATFORM_NAME:-NOT_SET}"
echo "TARGET_BUILD_DIR: ${TARGET_BUILD_DIR:-NOT_SET}"
echo "PWD: $(pwd)"

# Set default SRCROOT if not provided
if [ -z "${SRCROOT:-}" ]; then
    SRCROOT="/workspace/ios"
    echo "Using default SRCROOT: $SRCROOT"
fi

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

# Function to create privacy bundle in build directory
create_privacy_bundle_in_build() {
    local plugin_name="$1"
    local source_bundle="${SRCROOT}/${plugin_name}_privacy.bundle"
    local source_file="${source_bundle}/${plugin_name}_privacy"
    
    echo "Processing privacy bundle for: $plugin_name"
    echo "Source bundle: $source_bundle"
    
    if [ ! -d "$source_bundle" ] || [ ! -f "$source_file" ]; then
        echo "⚠️ $plugin_name privacy bundle not found at: $source_bundle"
        return 1
    fi
    
    # Create bundle in BUILT_PRODUCTS_DIR if available
    if [ -n "${BUILT_PRODUCTS_DIR:-}" ]; then
        local dest_dir="${BUILT_PRODUCTS_DIR}/${plugin_name}/${plugin_name}_privacy.bundle"
        echo "Creating bundle in BUILT_PRODUCTS_DIR: $dest_dir"
        mkdir -p "$dest_dir"
        cp -R "$source_bundle"/* "$dest_dir/"
        
        # Verify the copy
        local dest_file="${dest_dir}/${plugin_name}_privacy"
        if [ -f "$dest_file" ]; then
            echo "✅ Verified $plugin_name privacy bundle at: $dest_file"
        else
            echo "❌ Failed to verify $plugin_name privacy bundle at: $dest_file"
        fi
    fi
    
    # Create bundle in CONFIGURATION_BUILD_DIR if available
    if [ -n "${CONFIGURATION_BUILD_DIR:-}" ]; then
        local dest_dir="${CONFIGURATION_BUILD_DIR}/${plugin_name}/${plugin_name}_privacy.bundle"
        echo "Creating bundle in CONFIGURATION_BUILD_DIR: $dest_dir"
        mkdir -p "$dest_dir"
        cp -R "$source_bundle"/* "$dest_dir/"
        
        # Verify the copy
        local dest_file="${dest_dir}/${plugin_name}_privacy"
        if [ -f "$dest_file" ]; then
            echo "✅ Verified $plugin_name privacy bundle at: $dest_file"
        else
            echo "❌ Failed to verify $plugin_name privacy bundle at: $dest_file"
        fi
    fi
    
    # Create bundle in TARGET_BUILD_DIR if available
    if [ -n "${TARGET_BUILD_DIR:-}" ]; then
        local dest_dir="${TARGET_BUILD_DIR}/${plugin_name}/${plugin_name}_privacy.bundle"
        echo "Creating bundle in TARGET_BUILD_DIR: $dest_dir"
        mkdir -p "$dest_dir"
        cp -R "$source_bundle"/* "$dest_dir/"
        
        # Verify the copy
        local dest_file="${dest_dir}/${plugin_name}_privacy"
        if [ -f "$dest_file" ]; then
            echo "✅ Verified $plugin_name privacy bundle at: $dest_file"
        else
            echo "❌ Failed to verify $plugin_name privacy bundle at: $dest_file"
        fi
    fi
}

# Create privacy bundles for all plugins
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    create_privacy_bundle_in_build "$plugin"
done

# Handle AWS Core bundle
echo "Processing AWS Core bundle..."
AWS_CORE_SRC_SIMULATOR="${SRCROOT}/vendor/openpath/AWSCore.xcframework/ios-arm64_x86_64-simulator/AWSCore.framework/AWSCore.bundle"
AWS_CORE_SRC_DEVICE="${SRCROOT}/vendor/openpath/AWSCore.xcframework/ios-arm64/AWSCore.framework/AWSCore.bundle"

# Determine source based on platform
if [[ "${EFFECTIVE_PLATFORM_NAME:-}" == "-iphonesimulator" ]]; then
    AWS_CORE_SRC="$AWS_CORE_SRC_SIMULATOR"
    echo "Building for simulator, using: $AWS_CORE_SRC"
else
    AWS_CORE_SRC="$AWS_CORE_SRC_DEVICE"
    echo "Building for device, using: $AWS_CORE_SRC"
fi

# Create AWS Core bundle in BUILT_PRODUCTS_DIR if available
if [ -n "${BUILT_PRODUCTS_DIR:-}" ]; then
    aws_dest="${BUILT_PRODUCTS_DIR}/AWSCore/AWSCore.bundle"
    echo "Creating AWS Core bundle in BUILT_PRODUCTS_DIR: $aws_dest"
    mkdir -p "$(dirname "$aws_dest")"
    
    if [ -d "${AWS_CORE_SRC}" ]; then
        cp -R "${AWS_CORE_SRC}" "${aws_dest}"
        echo "✅ Copied AWS Core bundle to: $aws_dest"
    else
        echo "⚠️ AWS Core bundle not found, creating minimal one"
        mkdir -p "$aws_dest"
        cat > "${aws_dest}/AWSCore" << 'AWS_EOF'
# AWS Core Bundle Resource File (Fallback)
AWS_CORE_VERSION=2.37.2
AWS_CORE_BUNDLE_ID=org.cocoapods.AWSCore
AWS_CORE_PLATFORM=${EFFECTIVE_PLATFORM_NAME}
AWS_EOF
        echo "✅ Created fallback AWS Core bundle at: $aws_dest"
    fi
fi

# Create AWS Core bundle in CONFIGURATION_BUILD_DIR if available
if [ -n "${CONFIGURATION_BUILD_DIR:-}" ]; then
    aws_dest="${CONFIGURATION_BUILD_DIR}/AWSCore/AWSCore.bundle"
    echo "Creating AWS Core bundle in CONFIGURATION_BUILD_DIR: $aws_dest"
    mkdir -p "$(dirname "$aws_dest")"
    
    if [ -d "${AWS_CORE_SRC}" ]; then
        cp -R "${AWS_CORE_SRC}" "${aws_dest}"
        echo "✅ Copied AWS Core bundle to: $aws_dest"
    else
        echo "⚠️ AWS Core bundle not found, creating minimal one"
        mkdir -p "$aws_dest"
        cat > "${aws_dest}/AWSCore" << 'AWS_EOF'
# AWS Core Bundle Resource File (Fallback)
AWS_CORE_VERSION=2.37.2
AWS_CORE_BUNDLE_ID=org.cocoapods.AWSCore
AWS_CORE_PLATFORM=${EFFECTIVE_PLATFORM_NAME}
AWS_EOF
        echo "✅ Created fallback AWS Core bundle at: $aws_dest"
    fi
fi

# Create AWS Core bundle in TARGET_BUILD_DIR if available
if [ -n "${TARGET_BUILD_DIR:-}" ]; then
    aws_dest="${TARGET_BUILD_DIR}/AWSCore/AWSCore.bundle"
    echo "Creating AWS Core bundle in TARGET_BUILD_DIR: $aws_dest"
    mkdir -p "$(dirname "$aws_dest")"
    
    if [ -d "${AWS_CORE_SRC}" ]; then
        cp -R "${AWS_CORE_SRC}" "${aws_dest}"
        echo "✅ Copied AWS Core bundle to: $aws_dest"
    else
        echo "⚠️ AWS Core bundle not found, creating minimal one"
        mkdir -p "$aws_dest"
        cat > "${aws_dest}/AWSCore" << 'AWS_EOF'
# AWS Core Bundle Resource File (Fallback)
AWS_CORE_VERSION=2.37.2
AWS_CORE_BUNDLE_ID=org.cocoapods.AWSCore
AWS_CORE_PLATFORM=${EFFECTIVE_PLATFORM_NAME}
AWS_EOF
        echo "✅ Created fallback AWS Core bundle at: $aws_dest"
    fi
fi

echo "=== Dynamic Build Path Fix Complete ==="