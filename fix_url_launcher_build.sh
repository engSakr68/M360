#!/bin/bash

echo "🔧 Fixing url_launcher iOS build issue..."

# Navigate to project root
cd "$(dirname "$0")"

echo "📁 Current directory: $(pwd)"

# Clean Flutter project
echo "🧹 Cleaning Flutter project..."
if command -v flutter &> /dev/null; then
    flutter clean
    flutter pub get
else
    echo "⚠️ Flutter command not found, skipping Flutter clean"
fi

# Clean iOS build
echo "🧹 Cleaning iOS build..."
cd ios
rm -rf build/
rm -rf Pods/
rm -rf Podfile.lock

# Reinstall pods
echo "📦 Reinstalling CocoaPods dependencies..."
if command -v pod &> /dev/null; then
    pod install --repo-update
else
    echo "⚠️ CocoaPods not found, please install it first"
    echo "   Run: sudo gem install cocoapods"
fi

echo "✅ Build fix complete!"
echo ""
echo "Next steps:"
echo "1. Open ios/Runner.xcworkspace in Xcode"
echo "2. Clean Build Folder (Cmd+Shift+K)"
echo "3. Build the project (Cmd+B)"
echo ""
echo "The updated Podfile now copies the privacy bundle to both:"
echo "- Frameworks folder: \${BUILT_PRODUCTS_DIR}/\${FRAMEWORKS_FOLDER_PATH}/url_launcher_ios_privacy.bundle"
echo "- Target directory: \${BUILT_PRODUCTS_DIR}/url_launcher_ios/url_launcher_ios_privacy.bundle"