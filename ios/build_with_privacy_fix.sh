#!/bin/bash

# Build with Privacy Fix Script
# This script ensures privacy bundles are available before building

set -e
set -u
set -o pipefail

echo "=== Building with Privacy Fix ==="

# Ensure all privacy bundles exist
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

# Check that all privacy bundles exist
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    bundle_path="${plugin}_privacy.bundle/${plugin}_privacy"
    if [ -f "$bundle_path" ]; then
        echo "✅ $plugin privacy bundle exists"
    else
        echo "❌ $plugin privacy bundle missing: $bundle_path"
        exit 1
    fi
done

echo "✅ All privacy bundles verified"

# Now proceed with the build
echo "🚀 Proceeding with build..."
# Add your build command here
