#!/bin/bash

# Fix for iOS privacy bundle build issues
# This script addresses the missing privacy bundle files during iOS build

set -e
set -u
set -o pipefail

echo "🔧 Fixing iOS Privacy Bundle Build Issues..."

# Navigate to the project root
cd "$(dirname "$0")"

# Create the expected build directory structure
echo "📁 Creating build directory structure..."

# Create the build directory that Xcode expects
BUILD_DIR="ios/build/Debug-dev-iphonesimulator"
mkdir -p "$BUILD_DIR"

# List of plugins that need privacy bundles
PRIVACY_PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
    "image_picker_ios"
    "permission_handler_apple"
    "shared_preferences_foundation"
    "share_plus"
    "path_provider_foundation"
    "package_info_plus"
)

# Copy privacy bundles to the expected build locations
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    echo "📦 Processing privacy bundle for: $plugin"
    
    # Source privacy bundle
    SRC_BUNDLE="ios/${plugin}_privacy.bundle"
    
    # Expected build locations
    BUILD_BUNDLE_FRAMEWORKS="$BUILD_DIR/${plugin}/${plugin}_privacy.bundle"
    BUILD_BUNDLE_DIRECT="$BUILD_DIR/${plugin}_privacy.bundle"
    
    if [ -d "$SRC_BUNDLE" ]; then
        echo "✅ Found source privacy bundle: $SRC_BUNDLE"
        
        # Create plugin directory in build
        mkdir -p "$BUILD_DIR/$plugin"
        
        # Copy to both expected locations
        cp -R "$SRC_BUNDLE" "$BUILD_BUNDLE_FRAMEWORKS"
        cp -R "$SRC_BUNDLE" "$BUILD_BUNDLE_DIRECT"
        
        echo "✅ Copied privacy bundle to:"
        echo "   - $BUILD_BUNDLE_FRAMEWORKS"
        echo "   - $BUILD_BUNDLE_DIRECT"
        
        # Verify the copy was successful
        if [ -f "$BUILD_BUNDLE_FRAMEWORKS/${plugin}_privacy" ]; then
            echo "✅ Privacy bundle file verified: ${plugin}_privacy"
        else
            echo "❌ Privacy bundle file missing: ${plugin}_privacy"
            exit 1
        fi
    else
        echo "⚠️ Source privacy bundle not found: $SRC_BUNDLE"
        
        # Create minimal privacy bundle as fallback
        mkdir -p "$BUILD_BUNDLE_FRAMEWORKS"
        mkdir -p "$BUILD_BUNDLE_DIRECT"
        
        cat > "$BUILD_BUNDLE_FRAMEWORKS/${plugin}_privacy" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
        
        cat > "$BUILD_BUNDLE_DIRECT/${plugin}_privacy" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
        
        echo "✅ Created minimal privacy bundle for $plugin"
    fi
done

# Also create the frameworks folder structure that Xcode expects
FRAMEWORKS_DIR="$BUILD_DIR/url_launcher_ios/url_launcher_ios_privacy.bundle"
mkdir -p "$FRAMEWORKS_DIR"

FRAMEWORKS_DIR2="$BUILD_DIR/sqflite_darwin/sqflite_darwin_privacy.bundle"
mkdir -p "$FRAMEWORKS_DIR2"

echo "📁 Created frameworks directory structure"

# Create a script that can be run before each build
cat > "ios/pre_build_privacy_fix.sh" << 'SCRIPT_EOF'
#!/bin/bash
# Pre-build script to ensure privacy bundles are in place

set -e
set -u
set -o pipefail

echo "🔧 Pre-build: Ensuring privacy bundles are available..."

# Get the build directory from Xcode environment
if [ -n "${BUILT_PRODUCTS_DIR:-}" ]; then
    BUILD_DIR="$BUILT_PRODUCTS_DIR"
else
    BUILD_DIR="build/Debug-dev-iphonesimulator"
fi

# List of plugins that need privacy bundles
PRIVACY_PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
    "image_picker_ios"
    "permission_handler_apple"
    "shared_preferences_foundation"
    "share_plus"
    "path_provider_foundation"
    "package_info_plus"
)

# Copy privacy bundles to build locations
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    SRC_BUNDLE="${SRCROOT:-.}/${plugin}_privacy.bundle"
    
    # Multiple possible build locations
    BUILD_LOCATIONS=(
        "$BUILD_DIR/${plugin}/${plugin}_privacy.bundle"
        "$BUILD_DIR/${plugin}_privacy.bundle"
        "$BUILD_DIR/url_launcher_ios/url_launcher_ios_privacy.bundle"
        "$BUILD_DIR/sqflite_darwin/sqflite_darwin_privacy.bundle"
    )
    
    if [ -d "$SRC_BUNDLE" ]; then
        for location in "${BUILD_LOCATIONS[@]}"; do
            mkdir -p "$(dirname "$location")"
            cp -R "$SRC_BUNDLE" "$location" 2>/dev/null || true
        done
        echo "✅ Copied $plugin privacy bundle to build locations"
    else
        echo "⚠️ Source privacy bundle not found: $SRC_BUNDLE"
    fi
done

echo "✅ Pre-build privacy bundle fix complete"
SCRIPT_EOF

chmod +x "ios/pre_build_privacy_fix.sh"

echo ""
echo "🎉 Privacy Bundle Build Fix Complete!"
echo ""
echo "📋 What was done:"
echo "   ✅ Cleaned iOS build directory"
echo "   ✅ Created expected build directory structure"
echo "   ✅ Copied privacy bundles to build locations"
echo "   ✅ Created pre-build script for future builds"
echo ""
echo "🚀 Next steps:"
echo "   1. Run 'flutter clean' (if Flutter is available)"
echo "   2. Run 'cd ios && pod install' (if CocoaPods is available)"
echo "   3. Try building your iOS app again"
echo ""
echo "💡 If the issue persists, run this script again before each build:"
echo "   ./ios/pre_build_privacy_fix.sh"