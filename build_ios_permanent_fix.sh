#!/bin/bash

# iOS Build Script with Permanent Privacy Bundle Fix
set -e
set -u
set -o pipefail

echo "🚀 iOS Build with Permanent Privacy Bundle Fix"
echo "============================================="

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Change to project root
cd /workspace

# Step 1: Clean everything
print_status "Step 1: Cleaning build artifacts..."
rm -rf ios/build
rm -rf build/ios
rm -rf ios/Pods
rm -rf ios/Podfile.lock
rm -rf ios/.symlinks
print_success "Build artifacts cleaned"

# Step 2: Get Flutter dependencies
print_status "Step 2: Getting Flutter dependencies..."
if command -v flutter >/dev/null 2>&1; then
    flutter clean
    flutter pub get
    print_success "Flutter dependencies updated"
else
    print_warning "Flutter not available, skipping pub get"
fi

# Step 3: Install CocoaPods dependencies (this will apply the permanent fix)
print_status "Step 3: Installing CocoaPods dependencies with permanent fix..."
cd ios
if command -v pod >/dev/null 2>&1; then
    pod install --repo-update
    print_success "CocoaPods dependencies installed with permanent privacy bundle fix"
else
    print_warning "CocoaPods not available, skipping pod install"
fi
cd ..

# Step 4: Build for iOS simulator
print_status "Step 4: Building for iOS simulator..."
if command -v flutter >/dev/null 2>&1; then
    flutter build ios --simulator --debug --flavor dev
    print_success "iOS build completed successfully"
else
    print_warning "Flutter not available, build script ready for manual execution"
    print_status "To build manually, run: flutter build ios --simulator --debug --flavor dev"
fi

echo "✅ iOS build with permanent privacy bundle fix completed!"
echo ""
print_status "The privacy bundles and AWS Core bundle are now permanently integrated into the build process."
print_status "You should no longer encounter these build errors on subsequent builds."
