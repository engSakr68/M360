#!/bin/bash

# iOS Build Script with Privacy Bundle Fix
# This script ensures privacy bundles are in place before building

set -e
set -u
set -o pipefail

echo "=== iOS Build with Privacy Bundle Fix ==="

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IOS_DIR="${PROJECT_ROOT}/ios"

echo "Project Root: ${PROJECT_ROOT}"
echo "iOS Directory: ${IOS_DIR}"

# Step 1: Run the pre-build privacy fix
echo "Step 1: Running pre-build privacy bundle fix..."
if [ -f "${IOS_DIR}/pre_build_privacy_fix.sh" ]; then
    "${IOS_DIR}/pre_build_privacy_fix.sh"
else
    echo "⚠️ Pre-build privacy fix script not found, running comprehensive fix..."
    "${IOS_DIR}/comprehensive_privacy_bundle_fix.sh"
fi

# Step 2: Verify critical privacy bundles are in place
echo "Step 2: Verifying critical privacy bundles..."

CRITICAL_BUNDLES=(
    "url_launcher_ios"
    "image_picker_ios"
    "sqflite_darwin"
)

for bundle in "${CRITICAL_BUNDLES[@]}"; do
    bundle_file="${IOS_DIR}/build/Debug-dev-iphonesimulator/${bundle}/${bundle}_privacy.bundle/${bundle}_privacy"
    if [ -f "$bundle_file" ]; then
        echo "✅ $bundle privacy bundle verified: $bundle_file"
    else
        echo "❌ $bundle privacy bundle missing: $bundle_file"
        echo "Creating minimal privacy bundle..."
        mkdir -p "$(dirname "$bundle_file")"
        cat > "$bundle_file" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
        echo "✅ Created minimal privacy bundle for $bundle"
    fi
done

# Step 3: Check if Flutter is available
echo "Step 3: Checking Flutter availability..."
if command -v flutter >/dev/null 2>&1; then
    echo "✅ Flutter found, proceeding with build..."
    
    # Clean and get dependencies
    echo "Cleaning Flutter project..."
    flutter clean
    
    echo "Getting Flutter dependencies..."
    flutter pub get
    
    # Build for iOS simulator
    echo "Building for iOS simulator..."
    flutter build ios --simulator --debug
    
    echo "✅ iOS build completed successfully!"
else
    echo "⚠️ Flutter not found in PATH"
    echo "Privacy bundles are in place. You can now run your iOS build manually."
    echo ""
    echo "To build manually:"
    echo "1. Open Xcode"
    echo "2. Open ${IOS_DIR}/Runner.xcworkspace"
    echo "3. Select your target device/simulator"
    echo "4. Build and run"
    echo ""
    echo "The privacy bundle error should now be resolved."
fi

echo "=== iOS Build with Privacy Bundle Fix Complete ==="