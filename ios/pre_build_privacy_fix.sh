#!/bin/bash
set -e

echo "🔧 Pre-build privacy bundle fix..."

# Get the current build directory from Xcode environment variables
BUILD_DIR="${BUILT_PRODUCTS_DIR:-build/Debug-iphonesimulator}"
TARGET_NAME="${TARGET_NAME:-Runner}"

# Create the privacy bundle directory structure
PRIVACY_DIR="${BUILD_DIR}/url_launcher_ios/url_launcher_ios_privacy.bundle"
mkdir -p "${PRIVACY_DIR}"

# Copy or create the privacy bundle
if [ -f "${SRCROOT}/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy" ]; then
    cp "${SRCROOT}/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy" "${PRIVACY_DIR}/"
    echo "✅ Copied privacy bundle to ${PRIVACY_DIR}"
else
    cat > "${PRIVACY_DIR}/url_launcher_ios_privacy" << 'JSON'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
JSON
    echo "✅ Created privacy bundle at ${PRIVACY_DIR}"
fi

echo "🔧 Pre-build privacy bundle fix complete"
