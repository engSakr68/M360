#!/bin/bash

# Quick fix for url_launcher_ios privacy bundle issue
# This ensures the privacy bundle is copied to the correct location before building

set -e
set -u
set -o pipefail

echo "🔧 Quick privacy bundle fix for url_launcher_ios..."

# Navigate to project root
cd "$(dirname "$0")"

# Verify privacy bundle exists
PRIVACY_BUNDLE_SRC="ios/url_launcher_ios_privacy.bundle"
if [ ! -d "$PRIVACY_BUNDLE_SRC" ]; then
    echo "❌ Privacy bundle not found at: $PRIVACY_BUNDLE_SRC"
    exit 1
fi

echo "✅ Found privacy bundle at: $PRIVACY_BUNDLE_SRC"

# Create build directories and copy privacy bundle
BUILD_DIRS=(
    "ios/build/Debug-dev-iphonesimulator"
    "ios/build/Debug-iphonesimulator" 
    "ios/build/Release-iphonesimulator"
    "ios/build/Profile-iphonesimulator"
)

for build_dir in "${BUILD_DIRS[@]}"; do
    if [ -d "$build_dir" ]; then
        echo "📁 Processing build directory: $build_dir"
        
        # Create necessary subdirectories
        mkdir -p "$build_dir/Frameworks"
        mkdir -p "$build_dir/url_launcher_ios"
        
        # Copy privacy bundle to both locations
        cp -R "$PRIVACY_BUNDLE_SRC" "$build_dir/Frameworks/"
        cp -R "$PRIVACY_BUNDLE_SRC" "$build_dir/url_launcher_ios/"
        
        echo "✅ Copied privacy bundle to $build_dir"
    fi
done

# Also create a generic build directory structure
GENERIC_BUILD_DIR="ios/build"
mkdir -p "$GENERIC_BUILD_DIR/Frameworks"
mkdir -p "$GENERIC_BUILD_DIR/url_launcher_ios"
cp -R "$PRIVACY_BUNDLE_SRC" "$GENERIC_BUILD_DIR/Frameworks/"
cp -R "$PRIVACY_BUNDLE_SRC" "$GENERIC_BUILD_DIR/url_launcher_ios/"

echo "✅ Copied privacy bundle to generic build directory"

echo ""
echo "🎉 Privacy bundle fix complete!"
echo "The privacy bundle has been copied to all build directories."
echo "You can now try building your iOS app again."