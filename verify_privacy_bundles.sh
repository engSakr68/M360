#!/bin/bash

# Verify Privacy Bundles Script
set -e

echo "🔍 Verifying Privacy Bundles"

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

echo "Checking source privacy bundles..."
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    BUNDLE_FILE="ios/${plugin}_privacy.bundle/${plugin}_privacy"
    if [ -f "$BUNDLE_FILE" ]; then
        echo "✅ Source privacy bundle exists: $plugin"
    else
        echo "❌ Source privacy bundle missing: $plugin"
    fi
done

echo ""
echo "Checking AWS Core bundle..."
AWS_CORE_SIMULATOR="ios/vendor/openpath/AWSCore.xcframework/ios-arm64_x86_64-simulator/AWSCore.framework/AWSCore.bundle/AWSCore"
if [ -f "$AWS_CORE_SIMULATOR" ]; then
    echo "✅ AWS Core simulator bundle exists"
else
    echo "❌ AWS Core simulator bundle missing"
fi

AWS_CORE_DEVICE="ios/vendor/openpath/AWSCore.xcframework/ios-arm64/AWSCore.framework/AWSCore.bundle/AWSCore"
if [ -f "$AWS_CORE_DEVICE" ]; then
    echo "✅ AWS Core device bundle exists"
else
    echo "❌ AWS Core device bundle missing"
fi

echo ""
echo "✅ Privacy bundle verification completed"
