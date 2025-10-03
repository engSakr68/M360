#!/bin/bash

# Quick Complete Fix - Run this before building
set -e

echo "🔧 Quick Complete Fix - Privacy Bundles + AWS Core Bundle"

# Create build directories
mkdir -p ios/build/Debug-dev-iphonesimulator

# Fix privacy bundles
PRIVACY_PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
)

for plugin in "${PRIVACY_PLUGINS[@]}"; do
    BUNDLE_SRC="ios/${plugin}_privacy.bundle"
    BUNDLE_DST="ios/build/Debug-dev-iphonesimulator/${plugin}/${plugin}_privacy.bundle"
    
    if [ -d "$BUNDLE_SRC" ]; then
        mkdir -p "ios/build/Debug-dev-iphonesimulator/${plugin}"
        cp -R "$BUNDLE_SRC" "$BUNDLE_DST"
        echo "✅ Fixed privacy bundle: $plugin"
    else
        echo "⚠️ Privacy bundle not found: $BUNDLE_SRC"
    fi
done

# Fix AWS Core bundle
AWS_CORE_SRC="ios/vendor/openpath/AWSCore.xcframework/ios-arm64_x86_64-simulator/AWSCore.framework/AWSCore.bundle"
AWS_CORE_DST="ios/build/Debug-dev-iphonesimulator/AWSCore/AWSCore.bundle"

if [ -d "$AWS_CORE_SRC" ]; then
    mkdir -p "ios/build/Debug-dev-iphonesimulator/AWSCore"
    cp -R "$AWS_CORE_SRC" "$AWS_CORE_DST"
    echo "✅ Fixed AWS Core bundle"
else
    echo "⚠️ AWS Core bundle not found: $AWS_CORE_SRC"
fi

echo "✅ Quick complete fix completed"
echo "You can now try building again!"
