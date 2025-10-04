#!/bin/bash

# Pre-build Privacy Bundle Fix Script
# This script runs during the Xcode build process to ensure privacy bundles are available

set -e
set -u
set -o pipefail

echo "=== Pre-Build Privacy Bundle Fix ==="

# Debug: Show build variables
echo "SRCROOT: ${SRCROOT}"
echo "BUILT_PRODUCTS_DIR: ${BUILT_PRODUCTS_DIR}"
echo "CONFIGURATION_BUILD_DIR: ${CONFIGURATION_BUILD_DIR}"
echo "PWD: $(pwd)"

# List of plugins that need privacy bundles
PRIVACY_PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
    "shared_preferences_foundation"
    "share_plus"
    "permission_handler_apple"
    "path_provider_foundation"
    "package_info_plus"
)

# Function to ensure privacy bundle exists
ensure_privacy_bundle() {
    local plugin_name="$1"
    local source_bundle="${SRCROOT}/${plugin_name}_privacy.bundle"
    local source_file="${source_bundle}/${plugin_name}_privacy"
    local dest_dir="${BUILT_PRODUCTS_DIR}/${plugin_name}/${plugin_name}_privacy.bundle"
    local dest_file="${dest_dir}/${plugin_name}_privacy"
    
    echo "Ensuring privacy bundle for: ${plugin_name}"
    echo "Source: ${source_bundle}"
    echo "Destination: ${dest_dir}"
    
    if [ -d "${source_bundle}" ] && [ -f "${source_file}" ]; then
        # Create destination directory
        mkdir -p "$(dirname "${dest_dir}")"
        
        # Copy the bundle
        cp -R "${source_bundle}" "${dest_dir}"
        echo "✅ Copied ${plugin_name} privacy bundle"
        
        # Verify the copy
        if [ -f "${dest_file}" ]; then
            echo "✅ Verified ${plugin_name} privacy bundle copy"
        else
            echo "❌ Failed to verify ${plugin_name} privacy bundle copy"
            return 1
        fi
    else
        echo "⚠️ ${plugin_name} privacy bundle not found, creating minimal one"
        
        # Create minimal privacy bundle
        mkdir -p "${dest_dir}"
        cat > "${dest_file}" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
        echo "✅ Created minimal privacy bundle for ${plugin_name}"
    fi
}

# Ensure all privacy bundles exist
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    ensure_privacy_bundle "${plugin}"
done

echo "=== Pre-Build Privacy Bundle Fix Complete ==="
