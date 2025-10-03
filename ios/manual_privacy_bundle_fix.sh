#!/bin/bash

# Manual Privacy Bundle Fix for url_launcher_ios and sqflite_darwin
set -e

echo "🔧 Manual Privacy Bundle Fix"

# Create the missing privacy bundle files
mkdir -p ios/build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle
mkdir -p ios/build/Debug-dev-iphonesimulator/sqflite_darwin/sqflite_darwin_privacy.bundle

# Copy privacy bundle content
if [ -f "ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy" ]; then
    cp ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy ios/build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/
    echo "✅ Copied url_launcher_ios privacy bundle"
else
    # Create minimal privacy bundle
    cat > ios/build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
    echo "✅ Created url_launcher_ios privacy bundle"
fi

if [ -f "ios/sqflite_darwin_privacy.bundle/sqflite_darwin_privacy" ]; then
    cp ios/sqflite_darwin_privacy.bundle/sqflite_darwin_privacy ios/build/Debug-dev-iphonesimulator/sqflite_darwin/sqflite_darwin_privacy.bundle/
    echo "✅ Copied sqflite_darwin privacy bundle"
else
    # Create minimal privacy bundle
    cat > ios/build/Debug-dev-iphonesimulator/sqflite_darwin/sqflite_darwin_privacy.bundle/sqflite_darwin_privacy << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
    echo "✅ Created sqflite_darwin privacy bundle"
fi

echo "✅ Manual privacy bundle fix completed"
