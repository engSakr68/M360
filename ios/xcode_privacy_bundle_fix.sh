#!/bin/bash
set -e

echo "🔧 Running privacy bundle fix for iOS build..."

# List of plugins that need privacy bundles
PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
    "permission_handler_apple"
    "shared_preferences_foundation"
    "share_plus"
    "path_provider_foundation"
    "package_info_plus"
)

# Create privacy bundle directories and copy files
for plugin in "${PLUGINS[@]}"; do
    echo "Processing privacy bundle for: $plugin"
    
    # Create the privacy bundle directory
    mkdir -p "${BUILT_PRODUCTS_DIR}/${plugin}/${plugin}_privacy.bundle"
    
    # Copy privacy bundle if it exists
    if [ -f "${SRCROOT}/${plugin}_privacy.bundle/${plugin}_privacy" ]; then
        cp "${SRCROOT}/${plugin}_privacy.bundle/${plugin}_privacy" "${BUILT_PRODUCTS_DIR}/${plugin}/${plugin}_privacy.bundle/"
        echo "✅ Copied privacy bundle for $plugin"
    else
        # Create minimal privacy bundle
        cat > "${BUILT_PRODUCTS_DIR}/${plugin}/${plugin}_privacy.bundle/${plugin}_privacy" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
        echo "✅ Created privacy bundle for $plugin"
    fi
done

echo "✅ Privacy bundle fix completed"
