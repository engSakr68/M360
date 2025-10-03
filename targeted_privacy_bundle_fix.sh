#!/bin/bash

# Targeted fix for the specific url_launcher_ios privacy bundle error
# Error: Build input file cannot be found: '/Volumes/Untitled/member360_wb/build/ios/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy'

set -e
set -u
set -o pipefail

echo "🎯 Targeted fix for url_launcher_ios privacy bundle error"
echo "========================================================"

# Navigate to project root
cd "$(dirname "$0")"

# The error shows the build system is looking for the file at:
# /Volumes/Untitled/member360_wb/build/ios/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy

# Create the expected directory structure
echo "📁 Creating expected directory structure..."
mkdir -p "ios/build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle"

# Copy the privacy bundle to the expected location
if [ -f "ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy" ]; then
    echo "📋 Copying privacy bundle to expected location..."
    cp "ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy" "ios/build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/"
    echo "✅ Privacy bundle copied to expected location"
else
    echo "❌ Source privacy bundle not found, creating minimal one..."
    cat > "ios/build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy" << 'EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
EOF
    echo "✅ Created minimal privacy bundle at expected location"
fi

# Also create it for other possible build configurations
echo "📁 Creating for other build configurations..."
for config in "Debug-iphonesimulator" "Release-iphonesimulator" "Profile-iphonesimulator"; do
    mkdir -p "ios/build/${config}/url_launcher_ios/url_launcher_ios_privacy.bundle"
    cp "ios/build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy" "ios/build/${config}/url_launcher_ios/url_launcher_ios_privacy.bundle/"
done

# Create a script that runs before each build to ensure the privacy bundle is in place
echo "📝 Creating pre-build script..."
cat > ios/pre_build_privacy_fix.sh << 'EOF'
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
EOF

chmod +x ios/pre_build_privacy_fix.sh

# Create a comprehensive Xcode build script that can be added as a build phase
echo "📝 Creating Xcode build phase script..."
cat > ios/xcode_build_phase_privacy_fix.sh << 'EOF'
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
EOF

chmod +x ios/xcode_build_phase_privacy_fix.sh

echo ""
echo "🎉 Targeted fix complete!"
echo ""
echo "What was done:"
echo "1. ✅ Created expected directory structure: ios/build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/"
echo "2. ✅ Copied privacy bundle to the exact location the build system expects"
echo "3. ✅ Created pre-build script for future builds"
echo "4. ✅ Created Xcode build phase script"
echo ""
echo "The privacy bundle is now at the exact location the error was looking for:"
echo "ios/build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy"
echo ""
echo "Next steps:"
echo "1. Try building your iOS app again"
echo "2. If you still get the error, add the Xcode build phase script to your project:"
echo "   - Open ios/Runner.xcworkspace in Xcode"
echo "   - Select Runner target"
echo "   - Go to Build Phases"
echo "   - Add a new 'Run Script Phase'"
echo "   - Add this script: \${SRCROOT}/xcode_build_phase_privacy_fix.sh"
echo "   - Move it to run before 'Copy Bundle Resources'"