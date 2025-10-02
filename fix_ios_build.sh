#!/bin/bash

# Flutter iOS Build Fix Script
# This script helps resolve privacy bundle issues for Flutter iOS builds

set -e
set -u
set -o pipefail

echo "🔧 Flutter iOS Build Fix Script"
echo "================================"

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Error: pubspec.yaml not found. Please run this script from the Flutter project root."
    exit 1
fi

echo "✅ Found Flutter project"

# Clean build artifacts
echo "🧹 Cleaning build artifacts..."
if command -v flutter >/dev/null 2>&1; then
    flutter clean
else
    echo "⚠️ Flutter not found in PATH, cleaning manually..."
    rm -rf build/
    rm -rf ios/Pods/
    rm -rf ios/Podfile.lock
fi

# Check if privacy bundles exist
echo "🔍 Checking privacy bundles..."
if [ -d "ios/url_launcher_ios_privacy.bundle" ]; then
    echo "✅ url_launcher_ios_privacy.bundle found"
else
    echo "❌ url_launcher_ios_privacy.bundle missing"
fi

if [ -d "ios/sqflite_darwin_privacy.bundle" ]; then
    echo "✅ sqflite_darwin_privacy.bundle found"
else
    echo "❌ sqflite_darwin_privacy.bundle missing"
fi

# Install CocoaPods dependencies
echo "📦 Installing CocoaPods dependencies..."
cd ios
if command -v pod >/dev/null 2>&1; then
    pod install --repo-update
else
    echo "❌ CocoaPods not found. Please install CocoaPods first."
    exit 1
fi
cd ..

echo "✅ CocoaPods installation complete"

# Try to build
echo "🏗️ Attempting to build iOS app..."
if command -v flutter >/dev/null 2>&1; then
    flutter build ios --simulator
else
    echo "⚠️ Flutter not found in PATH. Please run 'flutter build ios --simulator' manually."
fi

echo "🎉 Build process complete!"
echo ""
echo "If you still encounter issues:"
echo "1. Open ios/Runner.xcworkspace in Xcode"
echo "2. Check that privacy bundles are included in the project"
echo "3. Clean Build Folder in Xcode (Product > Clean Build Folder)"
echo "4. Try building again from Xcode"