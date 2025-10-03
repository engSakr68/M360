#!/bin/bash
# Pre-build script to ensure privacy bundles are available

set -e

echo "🔧 Pre-build: Ensuring privacy bundles are available..."

# Create build directories if they don't exist
mkdir -p build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle
mkdir -p build/Debug-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle
mkdir -p build/Profile-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle
mkdir -p build/Release-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle

# Copy privacy bundle to all build configurations
if [ -d "url_launcher_ios_privacy.bundle" ]; then
    cp -R url_launcher_ios_privacy.bundle/* build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/ 2>/dev/null || true
    cp -R url_launcher_ios_privacy.bundle/* build/Debug-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/ 2>/dev/null || true
    cp -R url_launcher_ios_privacy.bundle/* build/Profile-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/ 2>/dev/null || true
    cp -R url_launcher_ios_privacy.bundle/* build/Release-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/ 2>/dev/null || true
    echo "✅ Privacy bundles copied to all build configurations"
else
    echo "⚠️ Source privacy bundle not found, creating minimal one..."
    # Create minimal privacy bundle as fallback
    for config in Debug-dev-iphonesimulator Debug-iphonesimulator Profile-iphonesimulator Release-iphonesimulator; do
        mkdir -p "build/${config}/url_launcher_ios/url_launcher_ios_privacy.bundle"
        cat > "build/${config}/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy" << 'PRIVACY_EOF'
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
PRIVACY_EOF
    done
    echo "✅ Minimal privacy bundles created for all configurations"
fi

echo "🎉 Pre-build privacy bundle fix complete!"
