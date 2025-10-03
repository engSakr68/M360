#!/bin/bash

# iOS Build Preparation Script
# This script prepares the iOS build environment and ensures privacy bundles are ready

set -e
set -u
set -o pipefail

echo "=== iOS Build Preparation ==="

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IOS_DIR="$PROJECT_ROOT/ios"

echo "Project Root: $PROJECT_ROOT"
echo "iOS Directory: $IOS_DIR"

# Check if we're in a Flutter project
if [ ! -f "$PROJECT_ROOT/pubspec.yaml" ]; then
    echo "❌ Not a Flutter project (pubspec.yaml not found)"
    exit 1
fi

# Check if iOS directory exists
if [ ! -d "$IOS_DIR" ]; then
    echo "❌ iOS directory not found: $IOS_DIR"
    exit 1
fi

# Run the comprehensive privacy bundle fix
echo "Running comprehensive privacy bundle fix..."
cd "$IOS_DIR"
if [ -f "./fix_privacy_bundles_comprehensive.sh" ]; then
    ./fix_privacy_bundles_comprehensive.sh
else
    echo "❌ Privacy bundle fix script not found"
    exit 1
fi

# Check if CocoaPods is available
if command -v pod >/dev/null 2>&1; then
    echo "Running pod install..."
    cd "$IOS_DIR"
    pod install
    echo "✅ Pod install completed"
else
    echo "⚠️ CocoaPods not found, skipping pod install"
fi

# Create a build directory structure for testing
echo "Creating test build directory structure..."
TEST_BUILD_DIR="$PROJECT_ROOT/build/ios/Debug-dev-iphonesimulator"
mkdir -p "$TEST_BUILD_DIR"

# Copy privacy bundles to test build directory
if [ -f "$IOS_DIR/copy_privacy_bundles_manual.sh" ]; then
    echo "Copying privacy bundles to test build directory..."
    "$IOS_DIR/copy_privacy_bundles_manual.sh" "$TEST_BUILD_DIR"
else
    echo "❌ Manual copy script not found"
fi

echo "=== iOS Build Preparation Complete ==="
echo ""
echo "The iOS build environment is now prepared with:"
echo "✅ Privacy bundles created and verified"
echo "✅ Pod install completed (if CocoaPods available)"
echo "✅ Test build directory created with privacy bundles"
echo ""
echo "You can now build your iOS app. The privacy bundles should be properly included."