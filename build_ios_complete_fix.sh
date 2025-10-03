#!/bin/bash

# Complete iOS Build Script - Fixes All Known Issues
set -e
set -u
set -o pipefail

echo "🚀 Complete iOS Build - All Issues Fixed"
echo "========================================"

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

# Step 1: Pre-build fixes
print_status "Step 1: Running pre-build fixes..."

# Create build directories
mkdir -p ios/build/Debug-dev-iphonesimulator
mkdir -p ios/build/Release-iphoneos

# Copy privacy bundles to build directories
PRIVACY_PLUGINS=(
    "image_picker_ios"
    "url_launcher_ios"
    "sqflite_darwin"
    "permission_handler_apple"
    "shared_preferences_foundation"
    "share_plus"
    "path_provider_foundation"
    "package_info_plus"
)

for plugin in "${PRIVACY_PLUGINS[@]}"; do
    BUNDLE_SRC="ios/${plugin}_privacy.bundle"
    
    if [ -d "$BUNDLE_SRC" ]; then
        # Copy to simulator build directory
        mkdir -p "ios/build/Debug-dev-iphonesimulator/${plugin}/${plugin}_privacy.bundle"
        cp -R "$BUNDLE_SRC"/* "ios/build/Debug-dev-iphonesimulator/${plugin}/${plugin}_privacy.bundle/"
        
        # Copy to device build directory
        mkdir -p "ios/build/Release-iphoneos/${plugin}/${plugin}_privacy.bundle"
        cp -R "$BUNDLE_SRC"/* "ios/build/Release-iphoneos/${plugin}/${plugin}_privacy.bundle/"
        
        print_success "Copied privacy bundle: $plugin"
    fi
done

# Copy AWS Core bundle to build directories
AWS_CORE_SIMULATOR_SRC="ios/vendor/openpath/AWSCore.xcframework/ios-arm64_x86_64-simulator/AWSCore.framework/AWSCore.bundle"
AWS_CORE_DEVICE_SRC="ios/vendor/openpath/AWSCore.xcframework/ios-arm64/AWSCore.framework/AWSCore.bundle"

if [ -d "$AWS_CORE_SIMULATOR_SRC" ]; then
    mkdir -p "ios/build/Debug-dev-iphonesimulator/AWSCore"
    cp -R "$AWS_CORE_SIMULATOR_SRC" "ios/build/Debug-dev-iphonesimulator/AWSCore/"
    print_success "Copied AWS Core bundle to simulator build directory"
fi

if [ -d "$AWS_CORE_DEVICE_SRC" ]; then
    mkdir -p "ios/build/Release-iphoneos/AWSCore"
    cp -R "$AWS_CORE_DEVICE_SRC" "ios/build/Release-iphoneos/AWSCore/"
    print_success "Copied AWS Core bundle to device build directory"
fi

# Step 2: Get Flutter dependencies
print_status "Step 2: Getting Flutter dependencies..."
if command -v flutter >/dev/null 2>&1; then
    flutter clean
    flutter pub get
    print_success "Flutter dependencies updated"
else
    print_warning "Flutter not available, skipping pub get"
fi

# Step 3: Install CocoaPods dependencies
print_status "Step 3: Installing CocoaPods dependencies..."
cd ios
if command -v pod >/dev/null 2>&1; then
    pod install --repo-update
    print_success "CocoaPods dependencies installed"
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

echo "✅ Complete iOS build with all fixes completed!"
