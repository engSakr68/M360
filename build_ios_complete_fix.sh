#!/bin/bash
set -e

echo "🏗️ Building iOS app with complete privacy bundle fix..."

# Set environment variables
export SRCROOT="$(pwd)/ios"
export BUILT_PRODUCTS_DIR="$(pwd)/build/Debug-iphonesimulator"
export FRAMEWORKS_FOLDER_PATH="Frameworks"

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf "$(pwd)/ios/build"
rm -rf "$(pwd)/build"

# Copy all privacy bundles
echo "📋 Copying privacy bundles..."
./ios/copy_privacy_bundles.sh

# Verify privacy bundles are in place
echo "🔍 Verifying privacy bundles..."
REQUIRED_BUNDLES=(
    "image_picker_ios"
    "url_launcher_ios"
)

for bundle in "${REQUIRED_BUNDLES[@]}"; do
    BUNDLE_PATH="${BUILT_PRODUCTS_DIR}/${bundle}/${bundle}_privacy.bundle/${bundle}_privacy"
    if [ -f "$BUNDLE_PATH" ]; then
        echo "✅ $bundle privacy bundle found"
    else
        echo "❌ $bundle privacy bundle missing at $BUNDLE_PATH"
        exit 1
    fi
done

echo "✅ All privacy bundles verified!"

# Try to build with Flutter if available
if command -v flutter >/dev/null 2>&1; then
    echo "🏗️ Building with Flutter..."
    flutter build ios --simulator --debug
else
    echo "⚠️ Flutter not available. Please run the following commands manually:"
    echo "1. Open ios/Runner.xcworkspace in Xcode"
    echo "2. Clean Build Folder (Product > Clean Build Folder)"
    echo "3. Build the project (Product > Build)"
    echo ""
    echo "The privacy bundles have been prepared and should resolve the build errors."
fi

echo "✅ Build process complete!"