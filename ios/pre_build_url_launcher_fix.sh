#!/bin/bash

# Pre-build URL Launcher Privacy Bundle Fix
# This script runs before each build to ensure proper privacy bundle structure

set -e
set -u
set -o pipefail

echo "🔧 Pre-build URL Launcher Privacy Bundle Fix..."

# Get build environment variables
SRCROOT="${SRCROOT}"
BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR}"
CONFIGURATION_BUILD_DIR="${CONFIGURATION_BUILD_DIR}"

echo "SRCROOT: ${SRCROOT}"
echo "BUILT_PRODUCTS_DIR: ${BUILT_PRODUCTS_DIR}"
echo "CONFIGURATION_BUILD_DIR: ${CONFIGURATION_BUILD_DIR}"

# Source privacy bundle path
SRC_PRIVACY_BUNDLE="${SRCROOT}/url_launcher_ios_privacy.bundle"
SRC_PRIVACY_FILE="${SRC_PRIVACY_BUNDLE}/url_launcher_ios_privacy"

# Function to create privacy bundle
create_privacy_bundle() {
    local target_dir="$1"
    local bundle_name="url_launcher_ios_privacy.bundle"
    local privacy_file_name="url_launcher_ios_privacy"
    
    echo "🔧 Creating privacy bundle at: ${target_dir}"
    
    # Create the bundle directory
    mkdir -p "${target_dir}/${bundle_name}"
    
    # Copy the privacy file
    if [ -f "${SRC_PRIVACY_FILE}" ]; then
        cp "${SRC_PRIVACY_FILE}" "${target_dir}/${bundle_name}/${privacy_file_name}"
        echo "✅ Created privacy bundle: ${target_dir}/${bundle_name}/${privacy_file_name}"
    else
        echo "⚠️ Source privacy file not found: ${SRC_PRIVACY_FILE}"
        # Create minimal privacy bundle
        cat > "${target_dir}/${bundle_name}/${privacy_file_name}" << 'PRIVACY_EOF'
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
PRIVACY_EOF
        echo "✅ Created minimal privacy bundle: ${target_dir}/${bundle_name}/${privacy_file_name}"
    fi
}

# Create privacy bundles in multiple locations for compatibility
create_privacy_bundle "${BUILT_PRODUCTS_DIR}/url_launcher_ios"
create_privacy_bundle "${BUILT_PRODUCTS_DIR}"

if [ -n "${CONFIGURATION_BUILD_DIR}" ] && [ "${CONFIGURATION_BUILD_DIR}" != "${BUILT_PRODUCTS_DIR}" ]; then
    create_privacy_bundle "${CONFIGURATION_BUILD_DIR}/url_launcher_ios"
    create_privacy_bundle "${CONFIGURATION_BUILD_DIR}"
fi

echo "✅ Pre-build URL Launcher Privacy Bundle Fix Complete"
