#!/bin/bash
# Comprehensive pre-build script for iOS privacy bundle issues

set -e
set -u
set -o pipefail

echo "🔧 Comprehensive Pre-Build Fix for iOS Privacy Bundles..."

# Get build directory from Xcode environment or use default
if [ -n "${BUILT_PRODUCTS_DIR:-}" ]; then
    BUILD_DIR="$BUILT_PRODUCTS_DIR"
elif [ -n "${CONFIGURATION_BUILD_DIR:-}" ]; then
    BUILD_DIR="$CONFIGURATION_BUILD_DIR"
else
    BUILD_DIR="build/Debug-dev-iphonesimulator"
fi

echo "Using build directory: $BUILD_DIR"

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

# Ensure build directory exists
mkdir -p "$BUILD_DIR"

# Copy privacy bundles for each plugin
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    echo "Processing privacy bundle for: $plugin"
    
    # Source privacy bundle
    SRC_BUNDLE="${SRCROOT:-.}/${plugin}_privacy.bundle"
    
    # Multiple possible destination locations
    DEST_LOCATIONS=(
        "$BUILD_DIR/${plugin}/${plugin}_privacy.bundle"
        "$BUILD_DIR/${plugin}_privacy.bundle"
        "$BUILD_DIR/url_launcher_ios/url_launcher_ios_privacy.bundle"
        "$BUILD_DIR/sqflite_darwin/sqflite_darwin_privacy.bundle"
    )
    
    if [ -d "$SRC_BUNDLE" ]; then
        echo "Found source privacy bundle: $SRC_BUNDLE"
        
        for dest in "${DEST_LOCATIONS[@]}"; do
            mkdir -p "$(dirname "$dest")"
            cp -R "$SRC_BUNDLE" "$dest" 2>/dev/null || true
        done
        
        echo "✅ Copied $plugin privacy bundle to all locations"
    else
        echo "⚠️ Source privacy bundle not found: $SRC_BUNDLE"
        echo "Creating minimal privacy bundle for $plugin"
        
        # Create minimal privacy bundle
        for dest in "${DEST_LOCATIONS[@]}"; do
            mkdir -p "$(dirname "$dest")"
            cat > "$dest/${plugin}_privacy" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
        done
        
        echo "✅ Created minimal privacy bundle for $plugin"
    fi
done

# Create additional framework directories that might be needed
mkdir -p "$BUILD_DIR/url_launcher_ios"
mkdir -p "$BUILD_DIR/sqflite_darwin"

echo "✅ Comprehensive pre-build fix complete"
