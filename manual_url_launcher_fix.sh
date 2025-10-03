#!/bin/bash

# Manual URL Launcher Privacy Bundle Fix
# Run this script to manually fix the privacy bundle structure

set -e
set -u
set -o pipefail

echo "🔧 Manual URL Launcher Privacy Bundle Fix..."

# Define paths
IOS_DIR="/workspace/ios"
SRC_PRIVACY_BUNDLE="${IOS_DIR}/url_launcher_ios_privacy.bundle"
SRC_PRIVACY_FILE="${SRC_PRIVACY_BUNDLE}/url_launcher_ios_privacy"

# Verify source files exist
if [ ! -f "${SRC_PRIVACY_FILE}" ]; then
    echo "❌ Source privacy file not found: ${SRC_PRIVACY_FILE}"
    echo "Creating minimal privacy bundle..."
    
    mkdir -p "${SRC_PRIVACY_BUNDLE}"
    cat > "${SRC_PRIVACY_FILE}" << 'EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": [
    {
      "NSPrivacyAccessedAPIType": "NSPrivacyAccessedAPICategoryUserDefaults",
      "NSPrivacyAccessedAPITypeReasons": ["CA92.1"]
    },
    {
      "NSPrivacyAccessedAPIType": "NSPrivacyAccessedAPICategoryFileTimestamp",
      "NSPrivacyAccessedAPITypeReasons": ["C617.1"]
    },
    {
      "NSPrivacyAccessedAPIType": "NSPrivacyAccessedAPICategorySystemBootTime",
      "NSPrivacyAccessedAPITypeReasons": ["35F9.1"]
    },
    {
      "NSPrivacyAccessedAPIType": "NSPrivacyAccessedAPICategoryDiskSpace",
      "NSPrivacyAccessedAPITypeReasons": ["85F4.1"]
    }
  ]
}
EOF
    echo "✅ Created minimal privacy bundle"
fi

# Create the expected build structure
BUILD_DIR="${IOS_DIR}/build"
CONFIGURATIONS=(
    "Debug-dev-iphonesimulator"
    "Debug-iphonesimulator" 
    "Release-iphoneos"
    "Release-iphonesimulator"
)

for config in "${CONFIGURATIONS[@]}"; do
    config_build_dir="${BUILD_DIR}/${config}"
    url_launcher_dir="${config_build_dir}/url_launcher_ios"
    bundle_dir="${url_launcher_dir}/url_launcher_ios_privacy.bundle"
    privacy_file="${bundle_dir}/url_launcher_ios_privacy"
    
    echo "🔧 Creating structure for: ${config}"
    
    # Create directory structure
    mkdir -p "${bundle_dir}"
    
    # Copy privacy file
    cp "${SRC_PRIVACY_FILE}" "${privacy_file}"
    
    # Verify
    if [ -f "${privacy_file}" ]; then
        echo "✅ Created: ${privacy_file}"
    else
        echo "❌ Failed to create: ${privacy_file}"
    fi
done

echo "🎉 Manual fix complete!"
echo "📋 Created privacy bundles for all configurations"
echo "🚀 You can now try building your iOS app"