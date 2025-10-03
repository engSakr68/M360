#!/bin/bash
# Comprehensive iOS build script with privacy bundle fixes

set -e
set -u
set -o pipefail

echo "🚀 Comprehensive iOS Build with Privacy Bundle Fixes..."

# Navigate to project root
cd "$(dirname "$0")"

# Step 1: Run the comprehensive fix
echo "🔧 Step 1: Running comprehensive privacy bundle fix..."
./comprehensive_ios_build_fix.sh

# Step 2: Run pre-build fix
echo "🔧 Step 2: Running pre-build fix..."
if [ -f "ios/comprehensive_pre_build_fix.sh" ]; then
    ./ios/comprehensive_pre_build_fix.sh
fi

# Step 3: Try to run Flutter clean (if available)
echo "🧹 Step 3: Cleaning Flutter build..."
if command -v flutter >/dev/null 2>&1; then
    flutter clean
    echo "✅ Flutter clean completed"
else
    echo "⚠️ Flutter not available, skipping flutter clean"
fi

# Step 4: Try to run pod install (if available)
echo "📦 Step 4: Installing CocoaPods dependencies..."
if command -v pod >/dev/null 2>&1; then
    cd ios
    pod install
    cd ..
    echo "✅ CocoaPods install completed"
else
    echo "⚠️ CocoaPods not available, skipping pod install"
fi

# Step 5: Try to build with Flutter (if available)
echo "🏗️ Step 5: Building iOS app..."
if command -v flutter >/dev/null 2>&1; then
    flutter build ios --simulator
    echo "✅ iOS build completed"
else
    echo "⚠️ Flutter not available, manual build required"
    echo "💡 Please run the following commands manually:"
    echo "   1. flutter clean"
    echo "   2. cd ios && pod install"
    echo "   3. flutter build ios --simulator"
fi

echo ""
echo "🎉 Comprehensive iOS Build Complete!"
echo ""
echo "📋 Summary:"
echo "   ✅ Privacy bundles copied to build locations"
echo "   ✅ Pre-build script created"
echo "   ✅ CocoaPods post-install script created"
echo "   ✅ Comprehensive build script created"
echo ""
echo "💡 If you still encounter issues:"
echo "   1. Run this script again: ./build_ios_with_privacy_fix.sh"
echo "   2. Or run the pre-build script before each build: ./ios/comprehensive_pre_build_fix.sh"
