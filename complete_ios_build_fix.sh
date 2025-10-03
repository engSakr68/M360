#!/bin/bash

set -e
set -u
set -o pipefail

echo "=== Complete iOS Build Fix ==="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Navigate to project root
cd /workspace

print_status "Starting complete iOS build fix..."

# Step 1: Verify privacy bundles
print_status "Step 1: Verifying privacy bundles..."
./verify_privacy_bundles.sh

# Step 2: Clean build artifacts
print_status "Step 2: Cleaning build artifacts..."
rm -rf ios/build
rm -rf build
rm -rf ios/Pods
rm -rf ios/.symlinks

# Step 3: Run pod install
print_status "Step 3: Running pod install..."
cd ios

if command -v pod >/dev/null 2>&1; then
    pod install --repo-update
    print_status "Pod install completed successfully"
else
    print_warning "CocoaPods not found in PATH"
    print_warning "Please install CocoaPods and run: pod install"
    print_warning "Or use Xcode to build the project directly"
fi

cd ..

# Step 4: Final verification
print_status "Step 4: Final verification..."
echo ""
echo "=== Build Fix Summary ==="
echo "✅ Privacy bundles are properly configured"
echo "✅ Podfile has been updated with privacy bundle fixes"
echo "✅ Build artifacts have been cleaned"
if command -v pod >/dev/null 2>&1; then
    echo "✅ Pod install completed"
else
    echo "⚠️ Pod install skipped (CocoaPods not available)"
fi

echo ""
echo "=== Next Steps ==="
echo "1. If CocoaPods is available, the fix is complete"
echo "2. If not, install CocoaPods: sudo gem install cocoapods"
echo "3. Then run: cd ios && pod install"
echo "4. Build your iOS app - privacy bundle errors should be resolved"

echo ""
echo "=== Alternative Manual Fix ==="
echo "If you still encounter issues, manually copy privacy bundles:"
echo "mkdir -p ios/build/ios/Debug-dev-iphonesimulator"
echo "for plugin in image_picker_ios url_launcher_ios sqflite_darwin permission_handler_apple shared_preferences_foundation share_plus path_provider_foundation package_info_plus; do"
echo "  mkdir -p \"ios/build/ios/Debug-dev-iphonesimulator/\${plugin}\""
echo "  cp -R \"ios/\${plugin}_privacy.bundle\" \"ios/build/ios/Debug-dev-iphonesimulator/\${plugin}/\""
echo "done"

print_status "Complete iOS build fix finished!"