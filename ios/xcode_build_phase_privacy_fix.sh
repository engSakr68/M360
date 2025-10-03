#!/bin/bash
set -e
set -u
set -o pipefail

echo "=== Xcode Build Phase: Privacy Bundle Fix ==="

# Ensure the privacy bundle exists in the expected location
PRIVACY_BUNDLE_DIR="${BUILT_PRODUCTS_DIR}/url_launcher_ios/url_launcher_ios_privacy.bundle"
PRIVACY_BUNDLE_FILE="${PRIVACY_BUNDLE_DIR}/url_launcher_ios_privacy"

echo "Target location: ${PRIVACY_BUNDLE_FILE}"

# Create directory if it doesn't exist
mkdir -p "${PRIVACY_BUNDLE_DIR}"

# Copy from source if available
if [ -f "${SRCROOT}/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy" ]; then
    echo "Copying privacy bundle from source..."
    cp "${SRCROOT}/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy" "${PRIVACY_BUNDLE_FILE}"
    echo "✅ Privacy bundle copied successfully"
else
    echo "Creating minimal privacy bundle..."
    cat > "${PRIVACY_BUNDLE_FILE}" << 'JSON'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
JSON
    echo "✅ Minimal privacy bundle created"
fi

# Verify the file exists
if [ -f "${PRIVACY_BUNDLE_FILE}" ]; then
    echo "✅ Privacy bundle verified at: ${PRIVACY_BUNDLE_FILE}"
    ls -la "${PRIVACY_BUNDLE_FILE}"
else
    echo "❌ Privacy bundle verification failed"
    exit 1
fi

echo "=== Privacy Bundle Fix Complete ==="
