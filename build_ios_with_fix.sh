#!/bin/bash

# Comprehensive iOS build script with privacy bundle fix
# This script addresses the url_launcher_ios privacy bundle issue and builds the project

set -e
set -u
set -o pipefail

echo "🏗️ Building iOS app with privacy bundle fix..."
echo "=============================================="

# Navigate to project root
cd "$(dirname "$0")"

# Step 1: Ensure privacy bundle is in place
echo "🔧 Step 1: Ensuring privacy bundle is in place..."
./quick_privacy_fix.sh

# Step 2: Clean and prepare build environment
echo "🧹 Step 2: Cleaning build environment..."
rm -rf ios/build/
rm -rf ios/Pods/
rm -rf ios/Podfile.lock

# Step 3: Install CocoaPods dependencies
echo "📦 Step 3: Installing CocoaPods dependencies..."
if command -v pod >/dev/null 2>&1; then
    cd ios
    pod install --repo-update
    cd ..
    echo "✅ CocoaPods installation complete"
else
    echo "⚠️ CocoaPods not available, skipping pod install"
fi

# Step 4: Run privacy bundle fix again after pod install
echo "🔧 Step 4: Running privacy bundle fix after pod install..."
./quick_privacy_fix.sh

# Step 5: Attempt to build with Flutter
echo "🏗️ Step 5: Attempting to build with Flutter..."
if command -v flutter >/dev/null 2>&1; then
    echo "Building iOS simulator app..."
    flutter build ios --simulator --debug --verbose
    echo "✅ Flutter build complete!"
else
    echo "⚠️ Flutter not available. Please run the following commands manually:"
    echo ""
    echo "1. Open ios/Runner.xcworkspace in Xcode"
    echo "2. Clean Build Folder (Product > Clean Build Folder or Cmd+Shift+K)"
    echo "3. Build the project (Product > Build or Cmd+B)"
    echo ""
    echo "The privacy bundle has been copied to the correct locations."
    echo "The build should now succeed without the privacy bundle error."
fi

echo ""
echo "🎉 Build process complete!"
echo ""
echo "If you still encounter the privacy bundle error, try:"
echo "1. Clean Build Folder in Xcode (Cmd+Shift+K)"
echo "2. Run: ./quick_privacy_fix.sh"
echo "3. Build again (Cmd+B)"