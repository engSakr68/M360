#!/bin/bash

# Verify Privacy Bundles Script
# This script verifies that all required privacy bundles are present and properly configured

set -e
set -u
set -o pipefail

echo "🔍 Verifying Privacy Bundles..."

# Navigate to the workspace
cd /workspace

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

# Function to verify privacy bundle
verify_privacy_bundle() {
    local plugin_name="$1"
    local bundle_path="ios/${plugin_name}_privacy.bundle/${plugin_name}_privacy"
    
    echo "Checking $plugin_name privacy bundle..."
    
    if [ -f "$bundle_path" ]; then
        echo "✅ $plugin_name privacy bundle exists"
        
        # Check if the file has content
        if [ -s "$bundle_path" ]; then
            echo "✅ $plugin_name privacy bundle has content ($(wc -c < "$bundle_path") bytes)"
            
            # Check if it's valid JSON
            if python3 -m json.tool "$bundle_path" > /dev/null 2>&1; then
                echo "✅ $plugin_name privacy bundle has valid JSON"
            else
                echo "❌ $plugin_name privacy bundle has invalid JSON"
                return 1
            fi
        else
            echo "❌ $plugin_name privacy bundle is empty"
            return 1
        fi
    else
        echo "❌ $plugin_name privacy bundle missing: $bundle_path"
        return 1
    fi
}

# Verify all privacy bundles
all_good=true
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    if ! verify_privacy_bundle "$plugin"; then
        all_good=false
    fi
done

echo ""
echo "=== Verification Summary ==="

if [ "$all_good" = true ]; then
    echo "🎉 All privacy bundles are present and properly configured!"
    echo ""
    echo "✅ The url_launcher_ios privacy bundle issue should be resolved"
    echo "✅ You can now try building your iOS app again"
    echo ""
    echo "Next steps:"
    echo "1. Try building your iOS app again"
    echo "2. The build should now find the required privacy bundles"
    echo "3. If you still get errors, check the build logs for any other missing files"
else
    echo "❌ Some privacy bundles are missing or invalid"
    echo "Please run the fix scripts again to ensure all bundles are created"
    exit 1
fi

echo ""
echo "📋 Privacy Bundle Locations:"
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    echo "  - ios/${plugin}_privacy.bundle/${plugin}_privacy"
done