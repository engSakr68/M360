#!/bin/bash

# iOS Build Solution for Privacy Bundle Issues
# This script provides a comprehensive solution for the privacy bundle build errors

set -e
set -u
set -o pipefail

echo "🔧 iOS Build Solution for Privacy Bundle Issues"
echo "=============================================="
echo ""

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Error: Please run this script from the Flutter project root directory"
    exit 1
fi

echo "✅ Found Flutter project"
echo ""

# Step 1: Clean build artifacts
echo "🧹 Step 1: Cleaning build artifacts..."
rm -rf ios/build/
rm -rf build/
echo "✅ Build artifacts cleaned"
echo ""

# Step 2: Run privacy bundle fix
echo "🔧 Step 2: Setting up privacy bundles..."
if [ -f "./fix_all_privacy_bundles.sh" ]; then
    ./fix_all_privacy_bundles.sh
    echo "✅ Privacy bundles configured"
else
    echo "⚠️ Privacy bundle fix script not found, running manual setup..."
    
    # Manual privacy bundle setup
    PRIVACY_PLUGINS=(
        "url_launcher_ios"
        "sqflite_darwin"
        "permission_handler_apple"
        "shared_preferences_foundation"
        "share_plus"
        "path_provider_foundation"
        "package_info_plus"
    )
    
    BUILD_CONFIGS=(
        "Debug-dev-iphonesimulator"
        "Debug-iphonesimulator"
        "Release-iphonesimulator"
        "Profile-iphonesimulator"
    )
    
    for config in "${BUILD_CONFIGS[@]}"; do
        BUILD_DIR="ios/build/${config}"
        mkdir -p "${BUILD_DIR}"
        
        for plugin in "${PRIVACY_PLUGINS[@]}"; do
            PLUGIN_DIR="${BUILD_DIR}/${plugin}"
            BUNDLE_SRC="ios/${plugin}_privacy.bundle"
            BUNDLE_DST="${PLUGIN_DIR}/${plugin}_privacy.bundle"
            
            if [ -d "${BUNDLE_SRC}" ]; then
                mkdir -p "${PLUGIN_DIR}"
                cp -R "${BUNDLE_SRC}" "${BUNDLE_DST}"
                echo "✅ Copied ${plugin} privacy bundle to ${config}"
            else
                echo "⚠️ Privacy bundle not found: ${BUNDLE_SRC}"
            fi
        done
    done
    
    echo "✅ Manual privacy bundle setup complete"
fi
echo ""

# Step 3: Check for Flutter and CocoaPods
echo "🔍 Step 3: Checking build tools..."
FLUTTER_AVAILABLE=false
COCOAPODS_AVAILABLE=false

if command -v flutter >/dev/null 2>&1; then
    FLUTTER_AVAILABLE=true
    echo "✅ Flutter is available"
else
    echo "⚠️ Flutter is not available"
fi

if command -v pod >/dev/null 2>&1; then
    COCOAPODS_AVAILABLE=true
    echo "✅ CocoaPods is available"
else
    echo "⚠️ CocoaPods is not available"
fi
echo ""

# Step 4: Provide build instructions
echo "📋 Step 4: Build Instructions"
echo "============================="
echo ""

if [ "$FLUTTER_AVAILABLE" = true ] && [ "$COCOAPODS_AVAILABLE" = true ]; then
    echo "🚀 Automated build process:"
    echo ""
    echo "1. Installing CocoaPods dependencies..."
    echo "   cd ios && pod install --repo-update"
    echo ""
    echo "2. Building iOS app..."
    echo "   flutter build ios --simulator --debug"
    echo ""
    echo "3. Running on simulator..."
    echo "   flutter run --debug"
    echo ""
    
    # Ask if user wants to run automated build
    read -p "Do you want to run the automated build process? (y/n): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "🏗️ Running automated build..."
        cd ios && pod install --repo-update && cd ..
        flutter build ios --simulator --debug
        echo "✅ Build complete!"
    fi
    
elif [ "$FLUTTER_AVAILABLE" = true ]; then
    echo "🚀 Flutter-only build process:"
    echo ""
    echo "1. Install CocoaPods dependencies manually:"
    echo "   cd ios && pod install --repo-update && cd .."
    echo ""
    echo "2. Build iOS app:"
    echo "   flutter build ios --simulator --debug"
    echo ""
    echo "3. Run on simulator:"
    echo "   flutter run --debug"
    echo ""
    
else
    echo "📱 Manual Xcode build process:"
    echo ""
    echo "1. Install CocoaPods dependencies:"
    echo "   cd ios && pod install --repo-update && cd .."
    echo ""
    echo "2. Open Xcode workspace:"
    echo "   open ios/Runner.xcworkspace"
    echo ""
    echo "3. In Xcode:"
    echo "   - Select Runner target"
    echo "   - Go to Build Phases tab"
    echo "   - Add new 'Run Script Phase' BEFORE 'Copy Bundle Resources'"
    echo "   - Add script: \${SRCROOT}/xcode_privacy_bundle_fix.sh"
    echo "   - Clean Build Folder (Cmd+Shift+K)"
    echo "   - Build project (Cmd+B)"
    echo ""
fi

echo ""
echo "🔧 Troubleshooting:"
echo "==================="
echo ""
echo "If you still encounter privacy bundle errors:"
echo ""
echo "1. Clean Build Folder in Xcode (Cmd+Shift+K)"
echo "2. Run: ./fix_all_privacy_bundles.sh"
echo "3. Rebuild the project"
echo ""
echo "4. If the error persists, check that the privacy bundles exist:"
echo "   find ios/build -name '*privacy.bundle' -type d"
echo ""
echo "5. Verify the privacy bundle files contain valid JSON/XML:"
echo "   cat ios/build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy"
echo ""

echo "✅ Privacy bundle setup complete!"
echo "The build should now succeed without privacy bundle errors."
echo ""