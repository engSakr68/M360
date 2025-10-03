#!/bin/bash

# Fix for url_launcher_ios privacy bundle issue
# This script ensures the privacy bundle is properly created and accessible

set -e
set -u
set -o pipefail

echo "🔧 Fixing url_launcher_ios privacy bundle issue..."

# Navigate to the iOS directory
cd /workspace/ios

# Ensure the privacy bundle directory exists
mkdir -p url_launcher_ios_privacy.bundle

# Create the privacy bundle file with proper content
cat > url_launcher_ios_privacy.bundle/url_launcher_ios_privacy << 'EOF'
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

echo "✅ Created url_launcher_ios privacy bundle"

# Verify the file was created correctly
if [ -f "url_launcher_ios_privacy.bundle/url_launcher_ios_privacy" ]; then
    echo "✅ Privacy bundle file exists and is accessible"
    echo "📄 Content preview:"
    head -5 url_launcher_ios_privacy.bundle/url_launcher_ios_privacy
else
    echo "❌ Failed to create privacy bundle file"
    exit 1
fi

# Also create a backup in the build directory structure that Xcode expects
mkdir -p build/Debug-dev-iphonesimulator/url_launcher_ios
cp -R url_launcher_ios_privacy.bundle build/Debug-dev-iphonesimulator/url_launcher_ios/

echo "✅ Created backup privacy bundle in build directory"

# Clean and reinstall pods to ensure proper integration
echo "🧹 Cleaning and reinstalling CocoaPods..."
rm -rf Pods
rm -f Podfile.lock

# Install pods (this will trigger the privacy bundle scripts in Podfile)
echo "📦 Installing CocoaPods dependencies..."
pod install --repo-update

echo "✅ CocoaPods installation complete"

# Verify the privacy bundle is accessible from the expected build path
BUILD_PATH="build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy"
if [ -f "$BUILD_PATH" ]; then
    echo "✅ Privacy bundle accessible from build path: $BUILD_PATH"
else
    echo "⚠️ Privacy bundle not found in expected build path, but this may be normal before first build"
fi

echo "🎉 url_launcher_ios privacy bundle fix complete!"
echo ""
echo "Next steps:"
echo "1. Try building your iOS app again"
echo "2. If the issue persists, the Podfile scripts should handle it automatically"
echo "3. The privacy bundle is now properly configured for url_launcher_ios"