#!/bin/bash

# Comprehensive fix for url_launcher_ios privacy bundle issue
# This script addresses the specific error: "Build input file cannot be found: url_launcher_ios_privacy"

set -e
set -u
set -o pipefail

echo "🔧 Fixing url_launcher_ios privacy bundle issue..."
echo "================================================"

# Navigate to project root
cd "$(dirname "$0")"
echo "📁 Working directory: $(pwd)"

# Check if privacy bundle exists
PRIVACY_BUNDLE_PATH="ios/url_launcher_ios_privacy.bundle"
if [ -d "$PRIVACY_BUNDLE_PATH" ]; then
    echo "✅ Found privacy bundle at: $PRIVACY_BUNDLE_PATH"
    ls -la "$PRIVACY_BUNDLE_PATH"
else
    echo "❌ Privacy bundle not found at: $PRIVACY_BUNDLE_PATH"
    echo "Creating a minimal privacy bundle..."
    mkdir -p "$PRIVACY_BUNDLE_PATH"
    cat > "$PRIVACY_BUNDLE_PATH/url_launcher_ios_privacy" << 'EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
EOF
    echo "✅ Created minimal privacy bundle"
fi

# Clean build artifacts
echo "🧹 Cleaning build artifacts..."
rm -rf ios/build/
rm -rf ios/Pods/
rm -rf ios/Podfile.lock
rm -rf build/

# Clean Flutter cache if Flutter is available
if command -v flutter >/dev/null 2>&1; then
    echo "🧹 Cleaning Flutter cache..."
    flutter clean
    flutter pub get
else
    echo "⚠️ Flutter not available, skipping Flutter clean"
fi

# Install CocoaPods if available
if command -v pod >/dev/null 2>&1; then
    echo "📦 Installing CocoaPods dependencies..."
    cd ios
    pod install --repo-update
    cd ..
    echo "✅ CocoaPods installation complete"
else
    echo "⚠️ CocoaPods not available, skipping pod install"
fi

# Create a script to manually copy the privacy bundle during build
echo "📝 Creating manual privacy bundle copy script..."
cat > ios/copy_privacy_bundles.sh << 'EOF'
#!/bin/bash
set -e

echo "=== Manual Privacy Bundle Copy ==="

# Source and destination paths
SRCROOT="${SRCROOT:-$(pwd)}"
BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR:-build/Debug-iphonesimulator}"
FRAMEWORKS_FOLDER_PATH="${FRAMEWORKS_FOLDER_PATH:-Frameworks}"

# Create directories
mkdir -p "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"
mkdir -p "${BUILT_PRODUCTS_DIR}/url_launcher_ios"

# Copy url_launcher_ios privacy bundle
if [ -d "${SRCROOT}/url_launcher_ios_privacy.bundle" ]; then
    echo "Copying url_launcher_ios privacy bundle..."
    cp -R "${SRCROOT}/url_launcher_ios_privacy.bundle" "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/"
    cp -R "${SRCROOT}/url_launcher_ios_privacy.bundle" "${BUILT_PRODUCTS_DIR}/url_launcher_ios/"
    echo "✅ Privacy bundle copied successfully"
else
    echo "❌ Privacy bundle not found at ${SRCROOT}/url_launcher_ios_privacy.bundle"
fi

echo "=== Privacy Bundle Copy Complete ==="
EOF

chmod +x ios/copy_privacy_bundles.sh

# Create a comprehensive build script
echo "📝 Creating comprehensive build script..."
cat > build_ios_fixed.sh << 'EOF'
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
EOF

chmod +x build_ios_fixed.sh

echo ""
echo "🎉 Fix complete! Here's what was done:"
echo "1. ✅ Verified/created privacy bundle at: $PRIVACY_BUNDLE_PATH"
echo "2. ✅ Cleaned all build artifacts"
echo "3. ✅ Created manual privacy bundle copy script"
echo "4. ✅ Created comprehensive build script"
echo ""
echo "Next steps:"
echo "1. Run: ./build_ios_fixed.sh"
echo "2. Or manually:"
echo "   - Open ios/Runner.xcworkspace in Xcode"
echo "   - Clean Build Folder (Cmd+Shift+K)"
echo "   - Build the project (Cmd+B)"
echo ""
echo "The privacy bundle will be copied to both locations:"
echo "- \${BUILT_PRODUCTS_DIR}/\${FRAMEWORKS_FOLDER_PATH}/url_launcher_ios_privacy.bundle"
echo "- \${BUILT_PRODUCTS_DIR}/url_launcher_ios/url_launcher_ios_privacy.bundle"