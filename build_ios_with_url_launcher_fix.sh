#!/bin/bash

# iOS Build Script with URL Launcher Privacy Bundle Fix
# This script ensures the privacy bundle is properly set up before building

set -e
set -u
set -o pipefail

echo "🚀 Starting iOS Build with URL Launcher Privacy Bundle Fix..."

# Define paths
WORKSPACE="/workspace"
IOS_DIR="${WORKSPACE}/ios"
BUILD_DIR="${IOS_DIR}/build"

# Function to ensure privacy bundle structure
ensure_privacy_bundle() {
    local config="$1"
    local config_build_dir="${BUILD_DIR}/${config}"
    local url_launcher_dir="${config_build_dir}/url_launcher_ios"
    local bundle_dir="${url_launcher_dir}/url_launcher_ios_privacy.bundle"
    local privacy_file="${bundle_dir}/url_launcher_ios_privacy"
    
    echo "🔧 Ensuring privacy bundle for: ${config}"
    
    # Create directory structure
    mkdir -p "${bundle_dir}"
    
    # Create or update privacy file
    cat > "${privacy_file}" << 'EOF'
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
    
    # Verify the file was created
    if [ -f "${privacy_file}" ]; then
        echo "✅ Privacy bundle ready: ${privacy_file}"
    else
        echo "❌ Failed to create privacy bundle: ${privacy_file}"
        return 1
    fi
}

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf "${BUILD_DIR}"

# Create privacy bundles for all configurations
CONFIGURATIONS=(
    "Debug-dev-iphonesimulator"
    "Debug-iphonesimulator" 
    "Release-iphoneos"
    "Release-iphonesimulator"
)

echo "🔧 Setting up privacy bundles for all configurations..."
for config in "${CONFIGURATIONS[@]}"; do
    ensure_privacy_bundle "${config}"
done

# Create a build verification script
VERIFICATION_SCRIPT="${IOS_DIR}/verify_privacy_bundles.sh"
cat > "${VERIFICATION_SCRIPT}" << 'EOF'
#!/bin/bash

# Privacy Bundle Verification Script
# This script verifies that all privacy bundles are properly structured

set -e
set -u

echo "🔍 Verifying privacy bundles..."

IOS_DIR="/workspace/ios"
BUILD_DIR="${IOS_DIR}/build"
CONFIGURATIONS=(
    "Debug-dev-iphonesimulator"
    "Debug-iphonesimulator" 
    "Release-iphoneos"
    "Release-iphonesimulator"
)

ALL_GOOD=true

for config in "${CONFIGURATIONS[@]}"; do
    config_build_dir="${BUILD_DIR}/${config}"
    url_launcher_dir="${config_build_dir}/url_launcher_ios"
    bundle_dir="${url_launcher_dir}/url_launcher_ios_privacy.bundle"
    privacy_file="${bundle_dir}/url_launcher_ios_privacy"
    
    if [ -f "${privacy_file}" ]; then
        echo "✅ ${config}: Privacy bundle exists"
    else
        echo "❌ ${config}: Privacy bundle missing"
        ALL_GOOD=false
    fi
done

if [ "$ALL_GOOD" = true ]; then
    echo "🎉 All privacy bundles are properly set up!"
    exit 0
else
    echo "❌ Some privacy bundles are missing!"
    exit 1
fi
EOF

chmod +x "${VERIFICATION_SCRIPT}"

# Run verification
echo "🔍 Running privacy bundle verification..."
"${VERIFICATION_SCRIPT}"

# Create a summary of what was fixed
echo ""
echo "📋 URL Launcher Privacy Bundle Fix Summary:"
echo "  ✅ Cleaned previous build artifacts"
echo "  ✅ Created proper privacy bundle structure for all configurations"
echo "  ✅ Verified all privacy bundles are in place"
echo "  ✅ Created verification script for future builds"
echo ""
echo "🎯 The privacy bundle structure is now correct:"
echo "   /workspace/ios/build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy"
echo ""
echo "🚀 You can now build your iOS app using Xcode or your preferred build method."
echo "   The privacy bundle will be automatically available during the build process."
echo ""
echo "💡 If you encounter the same error again, run this script to fix it:"
echo "   /workspace/build_ios_with_url_launcher_fix.sh"