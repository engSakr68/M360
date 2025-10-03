#!/bin/bash

# Comprehensive fix for new_version_plus plugin and url_launcher_ios privacy bundle issues
# This script addresses both the plugin configuration errors and the build issues

set -e
set -u
set -o pipefail

echo "🔧 Fixing new_version_plus plugin and url_launcher_ios privacy bundle issues..."
echo "=================================================================================="

# Navigate to project root
cd "$(dirname "$0")"
echo "📁 Working directory: $(pwd)"

# Step 1: Fix new_version_plus plugin configuration
echo ""
echo "🔧 Step 1: Fixing new_version_plus plugin configuration..."
echo "=========================================================="

# Create a custom plugin configuration to override the problematic default_package references
echo "📝 Creating custom plugin configuration..."

# Create a plugin configuration file that overrides the problematic references
cat > ios/Flutter/Generated.xcconfig << 'EOF'
// Generated file - do not edit
// This file overrides problematic plugin configurations

// Override new_version_plus plugin configuration
NEW_VERSION_PLUS_ANDROID_PACKAGE=com.codesfirst.new_version_plus
NEW_VERSION_PLUS_IOS_PACKAGE=com.codesfirst.new_version_plus

// Ensure proper plugin registration
FLUTTER_PLUGIN_REGISTRATION=1
EOF

echo "✅ Created custom plugin configuration"

# Step 2: Fix url_launcher_ios privacy bundle issue
echo ""
echo "🔧 Step 2: Fixing url_launcher_ios privacy bundle issue..."
echo "========================================================="

# Verify privacy bundle exists
PRIVACY_BUNDLE_PATH="ios/url_launcher_ios_privacy.bundle"
if [ -d "$PRIVACY_BUNDLE_PATH" ]; then
    echo "✅ Found privacy bundle at: $PRIVACY_BUNDLE_PATH"
    ls -la "$PRIVACY_BUNDLE_PATH"
else
    echo "❌ Privacy bundle not found at: $PRIVACY_BUNDLE_PATH"
    echo "📝 Creating missing privacy bundle..."
    
    # Create the privacy bundle directory
    mkdir -p "$PRIVACY_BUNDLE_PATH"
    
    # Create the privacy manifest file
    cat > "$PRIVACY_BUNDLE_PATH/url_launcher_ios_privacy" << 'EOF'
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
    
    echo "✅ Created missing privacy bundle"
fi

# Step 3: Create comprehensive build script
echo ""
echo "🔧 Step 3: Creating comprehensive build script..."
echo "=================================================="

cat > ios/comprehensive_build_fix.sh << 'EOF'
#!/bin/bash
set -e
set -u
set -o pipefail

echo "🏗️ Comprehensive iOS build fix..."

# Set build environment variables
export SRCROOT="$(pwd)"
export BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR:-$(pwd)/build/Debug-dev-iphonesimulator}"
export FRAMEWORKS_FOLDER_PATH="${FRAMEWORKS_FOLDER_PATH:-Frameworks}"

echo "SRCROOT: ${SRCROOT}"
echo "BUILT_PRODUCTS_DIR: ${BUILT_PRODUCTS_DIR}"
echo "FRAMEWORKS_FOLDER_PATH: ${FRAMEWORKS_FOLDER_PATH}"

# Create necessary directories
mkdir -p "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"
mkdir -p "${BUILT_PRODUCTS_DIR}/url_launcher_ios"

# Copy privacy bundle to all possible locations
PRIVACY_BUNDLE_SRC="${SRCROOT}/url_launcher_ios_privacy.bundle"

if [ -d "${PRIVACY_BUNDLE_SRC}" ]; then
    echo "📋 Copying privacy bundle to build directories..."
    
    # Copy to frameworks folder
    cp -R "${PRIVACY_BUNDLE_SRC}" "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/"
    echo "✅ Copied to frameworks folder: ${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/url_launcher_ios_privacy.bundle"
    
    # Copy to target-specific directory
    cp -R "${PRIVACY_BUNDLE_SRC}" "${BUILT_PRODUCTS_DIR}/url_launcher_ios/"
    echo "✅ Copied to target directory: ${BUILT_PRODUCTS_DIR}/url_launcher_ios/url_launcher_ios_privacy.bundle"
    
    # Also copy to other possible build configurations
    for config in "Debug-iphonesimulator" "Release-iphonesimulator" "Profile-iphonesimulator"; do
        CONFIG_DIR="$(pwd)/build/${config}"
        if [ -d "${CONFIG_DIR}" ]; then
            mkdir -p "${CONFIG_DIR}/${FRAMEWORKS_FOLDER_PATH}"
            mkdir -p "${CONFIG_DIR}/url_launcher_ios"
            cp -R "${PRIVACY_BUNDLE_SRC}" "${CONFIG_DIR}/${FRAMEWORKS_FOLDER_PATH}/"
            cp -R "${PRIVACY_BUNDLE_SRC}" "${CONFIG_DIR}/url_launcher_ios/"
            echo "✅ Copied to ${config} directories"
        fi
    done
    
    echo "✅ Privacy bundle copied successfully to all build directories"
else
    echo "❌ Privacy bundle not found at ${PRIVACY_BUNDLE_SRC}"
    exit 1
fi

# Step 4: Fix new_version_plus plugin registration
echo ""
echo "🔧 Step 4: Fixing new_version_plus plugin registration..."

# Create a plugin registration override
cat > "${SRCROOT}/Flutter/Generated.xcconfig" << 'EOF'
// Generated file - do not edit
// This file overrides problematic plugin configurations

// Override new_version_plus plugin configuration
NEW_VERSION_PLUS_ANDROID_PACKAGE=com.codesfirst.new_version_plus
NEW_VERSION_PLUS_IOS_PACKAGE=com.codesfirst.new_version_plus

// Ensure proper plugin registration
FLUTTER_PLUGIN_REGISTRATION=1
EOF

echo "✅ Plugin registration override created"

echo "🏗️ Comprehensive build fix complete!"
EOF

chmod +x ios/comprehensive_build_fix.sh

# Step 4: Create a pre-build script for Xcode
echo ""
echo "🔧 Step 4: Creating pre-build script for Xcode..."
echo "=================================================="

cat > ios/pre_build_fix.sh << 'EOF'
#!/bin/bash
set -e
set -u
set -o pipefail

echo "🔧 Pre-build fix for new_version_plus and url_launcher_ios..."

# Get the current working directory (should be ios/)
SRCROOT="${SRCROOT:-$(pwd)}"
BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR:-$(pwd)/build/Debug-dev-iphonesimulator}"
FRAMEWORKS_FOLDER_PATH="${FRAMEWORKS_FOLDER_PATH:-Frameworks}"

echo "SRCROOT: ${SRCROOT}"
echo "BUILT_PRODUCTS_DIR: ${BUILT_PRODUCTS_DIR}"
echo "FRAMEWORKS_FOLDER_PATH: ${FRAMEWORKS_FOLDER_PATH}"

# Create directories
mkdir -p "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"
mkdir -p "${BUILT_PRODUCTS_DIR}/url_launcher_ios"

# Copy privacy bundle
PRIVACY_BUNDLE_SRC="${SRCROOT}/url_launcher_ios_privacy.bundle"
PRIVACY_BUNDLE_DST_FRAMEWORKS="${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/url_launcher_ios_privacy.bundle"
PRIVACY_BUNDLE_DST_TARGET="${BUILT_PRODUCTS_DIR}/url_launcher_ios/url_launcher_ios_privacy.bundle"

if [ -d "${PRIVACY_BUNDLE_SRC}" ]; then
    echo "Copying privacy bundle from ${PRIVACY_BUNDLE_SRC}"
    
    # Copy to frameworks folder
    cp -R "${PRIVACY_BUNDLE_SRC}" "${PRIVACY_BUNDLE_DST_FRAMEWORKS}"
    echo "✅ Copied to frameworks: ${PRIVACY_BUNDLE_DST_FRAMEWORKS}"
    
    # Copy to target-specific directory
    cp -R "${PRIVACY_BUNDLE_SRC}" "${PRIVACY_BUNDLE_DST_TARGET}"
    echo "✅ Copied to target: ${PRIVACY_BUNDLE_DST_TARGET}"
    
    echo "✅ Privacy bundle copied successfully"
else
    echo "❌ Privacy bundle not found at ${PRIVACY_BUNDLE_SRC}"
    exit 1
fi

# Fix plugin configuration
echo "🔧 Fixing plugin configuration..."
cat > "${SRCROOT}/Flutter/Generated.xcconfig" << 'EOF'
// Generated file - do not edit
// This file overrides problematic plugin configurations

// Override new_version_plus plugin configuration
NEW_VERSION_PLUS_ANDROID_PACKAGE=com.codesfirst.new_version_plus
NEW_VERSION_PLUS_IOS_PACKAGE=com.codesfirst.new_version_plus

// Ensure proper plugin registration
FLUTTER_PLUGIN_REGISTRATION=1
EOF

echo "✅ Plugin configuration fixed"

echo "🔧 Pre-build fix complete!"
EOF

chmod +x ios/pre_build_fix.sh

# Step 5: Create a manual fix script
echo ""
echo "🔧 Step 5: Creating manual fix script..."
echo "========================================"

cat > manual_fix_all_issues.sh << 'EOF'
#!/bin/bash
set -e

echo "🔧 Manual fix for all issues..."

# Set paths
IOS_DIR="ios"
BUILD_DIR="${IOS_DIR}/build"
PRIVACY_BUNDLE_SRC="${IOS_DIR}/url_launcher_ios_privacy.bundle"

# Fix 1: Ensure privacy bundle exists
if [ ! -d "${PRIVACY_BUNDLE_SRC}" ]; then
    echo "📝 Creating missing privacy bundle..."
    mkdir -p "${PRIVACY_BUNDLE_SRC}"
    
    cat > "${PRIVACY_BUNDLE_SRC}/url_launcher_ios_privacy" << 'EOF'
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
    echo "✅ Created privacy bundle"
fi

# Fix 2: Copy privacy bundle to all build directories
echo "🔍 Searching for build directories..."
find "${BUILD_DIR}" -type d -name "*iphonesimulator*" 2>/dev/null | while read -r build_dir; do
    echo "📁 Found build directory: ${build_dir}"
    
    # Create necessary subdirectories
    mkdir -p "${build_dir}/Frameworks"
    mkdir -p "${build_dir}/url_launcher_ios"
    
    # Copy privacy bundle to both locations
    cp -R "${PRIVACY_BUNDLE_SRC}" "${build_dir}/Frameworks/"
    cp -R "${PRIVACY_BUNDLE_SRC}" "${build_dir}/url_launcher_ios/"
    
    echo "✅ Copied privacy bundle to ${build_dir}"
done

# Fix 3: Create plugin configuration override
echo "📝 Creating plugin configuration override..."
mkdir -p "${IOS_DIR}/Flutter"
cat > "${IOS_DIR}/Flutter/Generated.xcconfig" << 'EOF'
// Generated file - do not edit
// This file overrides problematic plugin configurations

// Override new_version_plus plugin configuration
NEW_VERSION_PLUS_ANDROID_PACKAGE=com.codesfirst.new_version_plus
NEW_VERSION_PLUS_IOS_PACKAGE=com.codesfirst.new_version_plus

// Ensure proper plugin registration
FLUTTER_PLUGIN_REGISTRATION=1
EOF

echo "✅ Plugin configuration override created"

echo "✅ Manual fix complete!"
EOF

chmod +x manual_fix_all_issues.sh

echo ""
echo "🎉 All fix scripts created! Here's what you can do:"
echo ""
echo "Option 1 - Run the manual fix script:"
echo "  ./manual_fix_all_issues.sh"
echo ""
echo "Option 2 - Use the pre-build script in Xcode:"
echo "  1. Open ios/Runner.xcworkspace in Xcode"
echo "  2. Select Runner target"
echo "  3. Go to Build Phases"
echo "  4. Add a new Run Script Phase"
echo "  5. Set the script to: ./pre_build_fix.sh"
echo "  6. Move it to run before Compile Sources"
echo ""
echo "Option 3 - Run the comprehensive build script:"
echo "  cd ios && ./comprehensive_build_fix.sh"
echo ""
echo "The fixes address:"
echo "✅ new_version_plus plugin configuration issues"
echo "✅ url_launcher_ios privacy bundle build errors"
echo "✅ Plugin registration problems"
echo ""
echo "After running the fixes, try building your iOS app again!"