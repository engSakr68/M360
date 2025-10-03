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
