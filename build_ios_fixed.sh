#!/bin/bash
set -e

echo "🏗️ Building iOS app with privacy bundle fix..."

# Set environment variables for the build
export SRCROOT="$(pwd)/ios"
export BUILT_PRODUCTS_DIR="$(pwd)/ios/build/Debug-iphonesimulator"
export FRAMEWORKS_FOLDER_PATH="Frameworks"

# Run the privacy bundle copy script
echo "📋 Copying privacy bundles..."
./ios/copy_privacy_bundles.sh

# Try to build with Flutter if available
if command -v flutter >/dev/null 2>&1; then
    echo "🏗️ Building with Flutter..."
    flutter build ios --simulator --debug
else
    echo "⚠️ Flutter not available. Please run the following commands manually:"
    echo "1. Open ios/Runner.xcworkspace in Xcode"
    echo "2. Clean Build Folder (Product > Clean Build Folder)"
    echo "3. Build the project (Product > Build)"
fi

echo "✅ Build process complete!"
