#!/bin/bash
set -e

echo "=== Manual Privacy Bundle Copy ==="

# Source and destination paths
SRCROOT="${SRCROOT:-$(pwd)/ios}"
BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR:-build/Debug-iphonesimulator}"
FRAMEWORKS_FOLDER_PATH="${FRAMEWORKS_FOLDER_PATH:-Frameworks}"

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

# Create directories
mkdir -p "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"

# Copy privacy bundles for all plugins
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    echo "Processing privacy bundle for: $plugin"
    
    PRIVACY_BUNDLE_SRC="${SRCROOT}/${plugin}_privacy.bundle"
    PRIVACY_BUNDLE_DST="${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/${plugin}_privacy.bundle"
    TARGET_DST="${BUILT_PRODUCTS_DIR}/${plugin}/${plugin}_privacy.bundle"
    
    if [ -d "${PRIVACY_BUNDLE_SRC}" ]; then
        echo "Copying ${plugin} privacy bundle..."
        
        # Copy to frameworks folder
        mkdir -p "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"
        cp -R "${PRIVACY_BUNDLE_SRC}" "${PRIVACY_BUNDLE_DST}"
        echo "✅ Copied to frameworks folder: ${PRIVACY_BUNDLE_DST}"
        
        # Copy to target-specific directory
        mkdir -p "${BUILT_PRODUCTS_DIR}/${plugin}"
        cp -R "${PRIVACY_BUNDLE_SRC}" "${TARGET_DST}"
        echo "✅ Copied to target directory: ${TARGET_DST}"
        
        echo "✅ ${plugin} privacy bundle copied"
    else
        echo "⚠️ ${plugin} privacy bundle not found at ${PRIVACY_BUNDLE_SRC}"
        # Create minimal privacy bundle as fallback
        mkdir -p "${TARGET_DST}"
        cat > "${TARGET_DST}/${plugin}_privacy" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
        echo "✅ Created minimal privacy bundle for ${plugin}"
    fi
done

echo "=== Privacy Bundle Copy Complete ==="
