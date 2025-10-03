#!/bin/bash

# Privacy Bundle Verification Script
# This script verifies that all privacy bundles are in the correct locations

set -e
set -u
set -o pipefail

echo "=== Privacy Bundle Verification ==="

# Get build environment variables
BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR:-/workspace/ios/build/Debug-dev-iphonesimulator}"

echo "BUILT_PRODUCTS_DIR: $BUILT_PRODUCTS_DIR"

# List of plugins that need privacy bundles
PRIVACY_PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
    "permission_handler_apple"
    "shared_preferences_foundation"
    "path_provider_foundation"
    "share_plus"
    "package_info_plus"
    "image_picker_ios"
)

# Function to verify privacy bundle
verify_privacy_bundle() {
    local plugin_name="$1"
    local plugin_dir="$BUILT_PRODUCTS_DIR/${plugin_name}"
    local bundle_dir="$plugin_dir/${plugin_name}_privacy.bundle"
    local privacy_file="$bundle_dir/${plugin_name}_privacy"
    
    echo "Verifying privacy bundle for: $plugin_name"
    
    # Check if the plugin directory exists
    if [ ! -d "$plugin_dir" ]; then
        echo "❌ Plugin directory not found: $plugin_dir"
        return 1
    fi
    
    # Check if the bundle directory exists
    if [ ! -d "$bundle_dir" ]; then
        echo "❌ Bundle directory not found: $bundle_dir"
        return 1
    fi
    
    # Check if the privacy file exists
    if [ ! -f "$privacy_file" ]; then
        echo "❌ Privacy file not found: $privacy_file"
        return 1
    fi
    
    # Check if the privacy file has content
    if [ ! -s "$privacy_file" ]; then
        echo "❌ Privacy file is empty: $privacy_file"
        return 1
    fi
    
    # Check if the privacy file contains valid JSON
    if ! python3 -m json.tool "$privacy_file" > /dev/null 2>&1; then
        echo "❌ Privacy file contains invalid JSON: $privacy_file"
        return 1
    fi
    
    echo "✅ Privacy bundle verified for $plugin_name"
    return 0
}

# Verify all privacy bundles
all_good=true
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    if ! verify_privacy_bundle "$plugin"; then
        all_good=false
    fi
done

if [ "$all_good" = true ]; then
    echo "=== All Privacy Bundles Verified Successfully ==="
    exit 0
else
    echo "=== Some Privacy Bundles Failed Verification ==="
    exit 1
fi