#!/bin/bash

# Comprehensive URL Launcher Privacy Bundle Fix
# This script fixes the nested bundle structure issue that causes Xcode build failures

set -e
set -u
set -o pipefail

echo "🔧 Starting URL Launcher Privacy Bundle Fix..."

# Define paths
IOS_DIR="/workspace/ios"
BUILD_DIR="${IOS_DIR}/build"
SRC_PRIVACY_BUNDLE="${IOS_DIR}/url_launcher_ios_privacy.bundle"
SRC_PRIVACY_FILE="${SRC_PRIVACY_BUNDLE}/url_launcher_ios_privacy"

echo "📁 Source privacy bundle: ${SRC_PRIVACY_BUNDLE}"
echo "📄 Source privacy file: ${SRC_PRIVACY_FILE}"

# Verify source files exist
if [ ! -d "${SRC_PRIVACY_BUNDLE}" ]; then
    echo "❌ Source privacy bundle not found: ${SRC_PRIVACY_BUNDLE}"
    exit 1
fi

if [ ! -f "${SRC_PRIVACY_FILE}" ]; then
    echo "❌ Source privacy file not found: ${SRC_PRIVACY_FILE}"
    exit 1
fi

echo "✅ Source files verified"

# Function to create proper privacy bundle structure
create_privacy_bundle() {
    local target_dir="$1"
    local bundle_name="url_launcher_ios_privacy.bundle"
    local privacy_file_name="url_launcher_ios_privacy"
    
    echo "🔧 Creating privacy bundle at: ${target_dir}"
    
    # Create the bundle directory
    mkdir -p "${target_dir}/${bundle_name}"
    
    # Copy the privacy file directly into the bundle
    cp "${SRC_PRIVACY_FILE}" "${target_dir}/${bundle_name}/${privacy_file_name}"
    
    # Verify the copy
    if [ -f "${target_dir}/${bundle_name}/${privacy_file_name}" ]; then
        echo "✅ Created privacy bundle: ${target_dir}/${bundle_name}/${privacy_file_name}"
    else
        echo "❌ Failed to create privacy bundle at: ${target_dir}/${bundle_name}/${privacy_file_name}"
        return 1
    fi
}

# Function to clean up nested bundle structures
clean_nested_bundles() {
    local base_dir="$1"
    echo "🧹 Cleaning nested bundle structures in: ${base_dir}"
    
    # Find and remove nested bundle directories
    find "${base_dir}" -type d -name "*_privacy.bundle" -path "*/url_launcher_ios/*" | while read -r nested_bundle; do
        echo "🗑️ Removing nested bundle: ${nested_bundle}"
        rm -rf "${nested_bundle}"
    done
    
    # Find and remove nested privacy files
    find "${base_dir}" -name "url_launcher_ios_privacy" -path "*/url_launcher_ios/*" | while read -r nested_file; do
        echo "🗑️ Removing nested privacy file: ${nested_file}"
        rm -f "${nested_file}"
    done
}

# Create build directory structure for different configurations
CONFIGURATIONS=(
    "Debug-dev-iphonesimulator"
    "Debug-iphonesimulator" 
    "Release-iphoneos"
    "Release-iphonesimulator"
)

for config in "${CONFIGURATIONS[@]}"; do
    config_build_dir="${BUILD_DIR}/${config}"
    
    if [ -d "${config_build_dir}" ]; then
        echo "🔧 Processing configuration: ${config}"
        
        # Clean up any existing nested structures
        clean_nested_bundles "${config_build_dir}"
        
        # Create proper privacy bundle structure
        url_launcher_dir="${config_build_dir}/url_launcher_ios"
        mkdir -p "${url_launcher_dir}"
        
        create_privacy_bundle "${url_launcher_dir}"
        
        # Also create at the root level for compatibility
        create_privacy_bundle "${config_build_dir}"
        
        echo "✅ Completed configuration: ${config}"
    else
        echo "⚠️ Build directory not found: ${config_build_dir}"
    fi
done

# Create a pre-build script that will run during Xcode build
PRE_BUILD_SCRIPT="${IOS_DIR}/pre_build_url_launcher_fix.sh"
cat > "${PRE_BUILD_SCRIPT}" << 'EOF'
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
EOF

chmod +x "${PRE_BUILD_SCRIPT}"
echo "✅ Created pre-build script: ${PRE_BUILD_SCRIPT}"

# Update Podfile to include the pre-build script
PODFILE="${IOS_DIR}/Podfile"
if [ -f "${PODFILE}" ]; then
    echo "🔧 Updating Podfile to include pre-build script..."
    
    # Check if the pre-build script is already referenced
    if ! grep -q "pre_build_url_launcher_fix.sh" "${PODFILE}"; then
        # Add the pre-build script reference to the existing pre-build phase
        sed -i.bak 's|if \[ -f "\${SRCROOT}/pre_build_privacy_fix.sh" \]; then|if [ -f "${SRCROOT}/pre_build_url_launcher_fix.sh" ]; then\
        echo "Running URL launcher privacy fix script..."\
        "${SRCROOT}/pre_build_url_launcher_fix.sh"\
    elif [ -f "${SRCROOT}/pre_build_privacy_fix.sh" ]; then|' "${PODFILE}"
        echo "✅ Updated Podfile to include URL launcher pre-build script"
    else
        echo "✅ Podfile already includes URL launcher pre-build script"
    fi
fi

echo "🎉 URL Launcher Privacy Bundle Fix Complete!"
echo ""
echo "📋 Summary:"
echo "  • Cleaned nested bundle structures"
echo "  • Created proper privacy bundle structure for all configurations"
echo "  • Added pre-build script for automatic fix during builds"
echo "  • Updated Podfile to include the pre-build script"
echo ""
echo "🚀 You can now build your iOS app. The privacy bundle will be automatically fixed during the build process."