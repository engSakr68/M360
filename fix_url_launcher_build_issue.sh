#!/bin/bash

# Fix for url_launcher_ios privacy bundle build issue
# This script addresses the specific error: "Build input file cannot be found: url_launcher_ios_privacy"

set -e
set -u
set -o pipefail

echo "🔧 Fixing url_launcher_ios privacy bundle build issue..."
echo "======================================================"

# Navigate to project root
cd "$(dirname "$0")"
echo "📁 Working directory: $(pwd)"

# Verify privacy bundle exists
PRIVACY_BUNDLE_PATH="ios/url_launcher_ios_privacy.bundle"
if [ -d "$PRIVACY_BUNDLE_PATH" ]; then
    echo "✅ Found privacy bundle at: $PRIVACY_BUNDLE_PATH"
    ls -la "$PRIVACY_BUNDLE_PATH"
else
    echo "❌ Privacy bundle not found at: $PRIVACY_BUNDLE_PATH"
    exit 1
fi

# Create a comprehensive build script that handles the privacy bundle issue
echo "📝 Creating comprehensive build fix script..."
cat > ios/build_with_privacy_fix.sh << 'EOF'
#!/bin/bash
set -e
set -u
set -o pipefail

echo "🏗️ Building iOS with privacy bundle fix..."

# Set build environment variables
export SRCROOT="$(pwd)"
export BUILT_PRODUCTS_DIR="$(pwd)/build/Debug-dev-iphonesimulator"
export FRAMEWORKS_FOLDER_PATH="Frameworks"

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

echo "🏗️ Privacy bundle fix complete!"
EOF

chmod +x ios/build_with_privacy_fix.sh

# Create a pre-build script that runs before Xcode build
echo "📝 Creating pre-build script..."
cat > ios/pre_build_privacy_fix.sh << 'EOF'
#!/bin/bash
set -e
set -u
set -o pipefail

echo "🔧 Pre-build privacy bundle fix..."

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

echo "🔧 Pre-build privacy bundle fix complete!"
EOF

chmod +x ios/pre_build_privacy_fix.sh

# Create a comprehensive fix script that can be run manually
echo "📝 Creating manual fix script..."
cat > fix_privacy_bundle_manually.sh << 'EOF'
#!/bin/bash
set -e

echo "🔧 Manual privacy bundle fix..."

# Set paths
IOS_DIR="ios"
BUILD_DIR="${IOS_DIR}/build"
PRIVACY_BUNDLE_SRC="${IOS_DIR}/url_launcher_ios_privacy.bundle"

if [ ! -d "${PRIVACY_BUNDLE_SRC}" ]; then
    echo "❌ Privacy bundle not found at ${PRIVACY_BUNDLE_SRC}"
    exit 1
fi

# Find all build directories and copy the privacy bundle
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

echo "✅ Manual privacy bundle fix complete!"
EOF

chmod +x fix_privacy_bundle_manually.sh

echo ""
echo "🎉 Fix scripts created! Here's what you can do:"
echo ""
echo "Option 1 - Run the manual fix script:"
echo "  ./fix_privacy_bundle_manually.sh"
echo ""
echo "Option 2 - Use the pre-build script in Xcode:"
echo "  1. Open ios/Runner.xcworkspace in Xcode"
echo "  2. Select Runner target"
echo "  3. Go to Build Phases"
echo "  4. Add a new Run Script Phase"
echo "  5. Set the script to: ./pre_build_privacy_fix.sh"
echo "  6. Move it to run before Compile Sources"
echo ""
echo "Option 3 - Run the comprehensive build script:"
echo "  cd ios && ./build_with_privacy_fix.sh"
echo ""
echo "The privacy bundle will be copied to:"
echo "- \${BUILT_PRODUCTS_DIR}/\${FRAMEWORKS_FOLDER_PATH}/url_launcher_ios_privacy.bundle"
echo "- \${BUILT_PRODUCTS_DIR}/url_launcher_ios/url_launcher_ios_privacy.bundle"