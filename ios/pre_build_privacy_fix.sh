#!/bin/bash

# Pre-build script to ensure privacy bundles are available
set -e

echo "🔧 Pre-build Privacy Bundle Fix"

# Create build directories
mkdir -p build/Debug-dev-iphonesimulator
mkdir -p build/Release-iphoneos

# List of plugins that need privacy bundles
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

# Copy privacy bundles to all possible build locations
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    BUNDLE_SRC="${plugin}_privacy.bundle"
    
    if [ -d "$BUNDLE_SRC" ]; then
        # Copy to Debug-dev-iphonesimulator
        mkdir -p "build/Debug-dev-iphonesimulator/${plugin}/${plugin}_privacy.bundle"
        cp -R "$BUNDLE_SRC"/* "build/Debug-dev-iphonesimulator/${plugin}/${plugin}_privacy.bundle/"
        
        # Copy to Release-iphoneos
        mkdir -p "build/Release-iphoneos/${plugin}/${plugin}_privacy.bundle"
        cp -R "$BUNDLE_SRC"/* "build/Release-iphoneos/${plugin}/${plugin}_privacy.bundle/"
        
        # Also copy to root of build directories
        cp -R "$BUNDLE_SRC" "build/Debug-dev-iphonesimulator/"
        cp -R "$BUNDLE_SRC" "build/Release-iphoneos/"
        
        echo "✅ Copied privacy bundle for: $plugin"
    else
        echo "⚠️ Privacy bundle not found: $BUNDLE_SRC"
    fi
done

echo "✅ Pre-build privacy bundle fix completed"
