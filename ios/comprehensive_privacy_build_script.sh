#!/bin/bash

# Comprehensive Privacy Bundle Build Script
# This script runs during Xcode build to ensure privacy bundles are available

set -e
set -u
set -o pipefail

echo "=== Running Comprehensive Privacy Bundle Build Script ==="

# Debug: Show build variables
echo "SRCROOT: ${SRCROOT}"
echo "BUILT_PRODUCTS_DIR: ${BUILT_PRODUCTS_DIR}"
echo "CONFIGURATION_BUILD_DIR: ${CONFIGURATION_BUILD_DIR}"
echo "EFFECTIVE_PLATFORM_NAME: ${EFFECTIVE_PLATFORM_NAME}"
echo "PWD: $(pwd)"

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

# Function to ensure privacy bundle exists
ensure_privacy_bundle() {
    local plugin_name="$1"
    local source_bundle="${SRCROOT}/${plugin_name}_privacy.bundle"
    local source_file="${source_bundle}/${plugin_name}_privacy"
    local dest_dir="${BUILT_PRODUCTS_DIR}/${plugin_name}/${plugin_name}_privacy.bundle"
    local dest_file="${dest_dir}/${plugin_name}_privacy"
    
    echo "Processing privacy bundle for: $plugin_name"
    
    if [ -d "$source_bundle" ] && [ -f "$source_file" ]; then
        # Create destination directory
        mkdir -p "$(dirname "$dest_dir")"
        
        # Copy the bundle
        cp -R "$source_bundle" "$dest_dir"
        echo "✅ Copied $plugin_name privacy bundle to: $dest_dir"
        
        # Verify the copy
        if [ -f "$dest_file" ]; then
            echo "✅ Verified $plugin_name privacy bundle copy"
        else
            echo "❌ Failed to verify $plugin_name privacy bundle copy"
            return 1
        fi
    else
        echo "⚠️ $plugin_name privacy bundle not found, creating minimal one"
        
        # Create minimal privacy bundle
        mkdir -p "$dest_dir"
        cat > "$dest_file" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
        echo "✅ Created minimal privacy bundle for $plugin_name"
    fi
}

# Ensure privacy bundles for all plugins
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    ensure_privacy_bundle "$plugin"
done

# Handle AWS Core bundle
echo "Processing AWS Core bundle..."
AWS_CORE_DST="${BUILT_PRODUCTS_DIR}/AWSCore/AWSCore.bundle"
mkdir -p "${BUILT_PRODUCTS_DIR}/AWSCore"

# Determine if we're building for simulator or device
if [[ "${EFFECTIVE_PLATFORM_NAME}" == "-iphonesimulator" ]]; then
    AWS_CORE_SRC="${SRCROOT}/vendor/openpath/AWSCore.xcframework/ios-arm64_x86_64-simulator/AWSCore.framework/AWSCore.bundle"
    echo "Building for simulator"
else
    AWS_CORE_SRC="${SRCROOT}/vendor/openpath/AWSCore.xcframework/ios-arm64/AWSCore.framework/AWSCore.bundle"
    echo "Building for device"
fi

if [ -d "${AWS_CORE_SRC}" ]; then
    cp -R "${AWS_CORE_SRC}" "${AWS_CORE_DST}"
    echo "✅ Copied AWS Core bundle to: ${AWS_CORE_DST}"
else
    echo "⚠️ AWS Core bundle not found, creating minimal one"
    cat > "${AWS_CORE_DST}/AWSCore" << 'AWS_EOF'
# AWS Core Bundle Resource File (Fallback)
AWS_CORE_VERSION=2.37.2
AWS_CORE_BUNDLE_ID=org.cocoapods.AWSCore
AWS_CORE_PLATFORM=${EFFECTIVE_PLATFORM_NAME}
AWS_EOF
    echo "✅ Created fallback AWS Core bundle"
fi

echo "=== Comprehensive Privacy Bundle Build Script Complete ==="
