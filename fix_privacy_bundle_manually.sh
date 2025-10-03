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
