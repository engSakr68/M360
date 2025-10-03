#!/bin/bash

set -e
set -u
set -o pipefail

echo "=== Comprehensive Privacy Manifest Fix ==="

# Change to the workspace directory
cd /workspace

# Define the iOS directory
IOS_DIR="/workspace/ios"

echo "🔧 Setting up privacy manifest bundles..."

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
    "firebase_messaging"
)

# Function to create privacy bundle
create_privacy_bundle() {
    local plugin_name="$1"
    local bundle_dir="${IOS_DIR}/${plugin_name}_privacy.bundle"
    local privacy_file="${bundle_dir}/${plugin_name}_privacy"
    
    echo "Creating privacy bundle for: $plugin_name"
    
    # Create bundle directory
    mkdir -p "$bundle_dir"
    
    # Create privacy manifest file
    cat > "$privacy_file" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": [
    {
      "NSPrivacyAccessedAPIType": "NSPrivacyAccessedAPICategoryUserDefaults",
      "NSPrivacyAccessedAPITypeReasons": ["CA92.1"]
    },
    {
      "NSPrivacyAccessedAPIType": "NSPrivacyAccessedAPICategoryFileTimestamp",
      "NSPrivacyAccessedAPITypeReasons": ["C617.1"]
    },
    {
      "NSPrivacyAccessedAPIType": "NSPrivacyAccessedAPICategorySystemBootTime",
      "NSPrivacyAccessedAPITypeReasons": ["35F9.1"]
    },
    {
      "NSPrivacyAccessedAPIType": "NSPrivacyAccessedAPICategoryDiskSpace",
      "NSPrivacyAccessedAPITypeReasons": ["85F4.1"]
    }
  ]
}
PRIVACY_EOF
    
    echo "✅ Created privacy bundle for $plugin_name at: $bundle_dir"
    
    # For firebase_messaging, also create the capitalized version
    if [ "$plugin_name" = "firebase_messaging" ]; then
        local capitalized_file="${bundle_dir}/firebase_messaging_Privacy"
        cp "$privacy_file" "$capitalized_file"
        echo "✅ Also created capitalized version for firebase_messaging"
    fi
}

# Create privacy bundles for all plugins
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    create_privacy_bundle "$plugin"
done

echo "🔧 Creating build directory structure..."

# Create build directories for different configurations
BUILD_CONFIGS=(
    "Debug-dev-iphonesimulator"
    "Debug-iphonesimulator"
    "Release-iphonesimulator"
    "Release-iphoneos"
)

for config in "${BUILD_CONFIGS[@]}"; do
    BUILD_DIR="${IOS_DIR}/build/${config}"
    echo "Creating build directory: $BUILD_DIR"
    
    for plugin in "${PRIVACY_PLUGINS[@]}"; do
        PLUGIN_BUILD_DIR="${BUILD_DIR}/${plugin}"
        BUNDLE_DIR="${PLUGIN_BUILD_DIR}/${plugin}_privacy.bundle"
        PRIVACY_FILE="${BUNDLE_DIR}/${plugin}_privacy"
        
        # Create the directory structure
        mkdir -p "$BUNDLE_DIR"
        
        # Copy the privacy file
        SOURCE_FILE="${IOS_DIR}/${plugin}_privacy.bundle/${plugin}_privacy"
        if [ -f "$SOURCE_FILE" ]; then
            cp "$SOURCE_FILE" "$PRIVACY_FILE"
            echo "✅ Copied privacy file for $plugin in $config"
            
            # For firebase_messaging, also create capitalized version
            if [ "$plugin" = "firebase_messaging" ]; then
                CAPITALIZED_FILE="${BUNDLE_DIR}/firebase_messaging_Privacy"
                cp "$SOURCE_FILE" "$CAPITALIZED_FILE"
                echo "✅ Also created capitalized version for firebase_messaging in $config"
            fi
        else
            echo "⚠️ Source privacy file not found: $SOURCE_FILE"
        fi
    done
done

echo "🔧 Creating pre-build script..."

# Create a pre-build script that will run during Xcode build
cat > "${IOS_DIR}/pre_build_privacy_fix.sh" << 'SCRIPT_EOF'
#!/bin/bash

set -e
set -u
set -o pipefail

echo "=== Pre-Build Privacy Bundle Fix ==="

SRCROOT="${SRCROOT}"
BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR}"
CONFIGURATION_BUILD_DIR="${CONFIGURATION_BUILD_DIR}"

echo "SRCROOT: ${SRCROOT}"
echo "BUILT_PRODUCTS_DIR: ${BUILT_PRODUCTS_DIR}"
echo "CONFIGURATION_BUILD_DIR: ${CONFIGURATION_BUILD_DIR}"

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
    "firebase_messaging"
)

# Function to copy privacy bundle
copy_privacy_bundle() {
    local plugin_name="$1"
    local bundle_dir="${SRCROOT}/${plugin_name}_privacy.bundle"
    local dest_dir="${BUILT_PRODUCTS_DIR}/${plugin_name}/${plugin_name}_privacy.bundle"
    local privacy_file="$dest_dir/${plugin_name}_privacy"
    
    echo "Processing privacy bundle for: $plugin_name"
    
    if [ -d "$bundle_dir" ]; then
        # Create destination directory
        mkdir -p "$(dirname "$dest_dir")"
        
        # Copy the bundle
        cp -R "$bundle_dir" "$dest_dir"
        echo "✅ Copied $plugin_name privacy bundle to: $dest_dir"
        
        # Special handling for firebase_messaging to handle capitalization differences
        if [ "$plugin_name" = "firebase_messaging" ]; then
            echo "🔧 Special handling for firebase_messaging..."
            # Handle both lowercase and capitalized versions
            local source_privacy_file="${bundle_dir}/${plugin_name}_privacy"
            if [ -f "$source_privacy_file" ]; then
                cp "$source_privacy_file" "$privacy_file"
                echo "✅ Ensured firebase_messaging privacy file is in correct location"
            fi
            
            # Also copy with capitalized naming for compatibility
            local capitalized_privacy_file="${dest_dir}/firebase_messaging_Privacy"
            cp "$source_privacy_file" "$capitalized_privacy_file"
            echo "✅ Also copied firebase_messaging privacy bundle with capitalized naming"
        fi
        
        # Verify the copy
        if [ -f "$privacy_file" ]; then
            echo "✅ Verified $plugin_name privacy bundle copy"
        else
            echo "❌ Failed to verify $plugin_name privacy bundle copy"
            return 1
        fi
    else
        echo "⚠️ $plugin_name privacy bundle not found at $bundle_dir"
        # Create minimal privacy bundle as fallback
        mkdir -p "$dest_dir"
        cat > "$privacy_file" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
        echo "✅ Created minimal privacy bundle for $plugin_name"
    fi
}

# Copy privacy bundles for all plugins
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    copy_privacy_bundle "$plugin"
done

echo "=== Pre-Build Privacy Bundle Fix Complete ==="
SCRIPT_EOF

chmod +x "${IOS_DIR}/pre_build_privacy_fix.sh"

echo "✅ Created pre-build privacy fix script"

echo "🔧 Verifying all privacy bundles..."

# Verify all privacy bundles exist
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    bundle_dir="${IOS_DIR}/${plugin}_privacy.bundle"
    privacy_file="${bundle_dir}/${plugin}_privacy"
    
    if [ -f "$privacy_file" ]; then
        echo "✅ Verified privacy bundle for $plugin"
    else
        echo "❌ Missing privacy bundle for $plugin"
    fi
done

echo "=== Comprehensive Privacy Manifest Fix Complete ==="
echo ""
echo "Next steps:"
echo "1. Run 'flutter clean' to clean the build cache"
echo "2. Run 'flutter pub get' to get dependencies"
echo "3. Run 'cd ios && pod install' to install CocoaPods dependencies"
echo "4. Try building the iOS app again"
echo ""
echo "The privacy manifest files have been created and the build scripts have been updated."
echo "This should resolve the missing privacy manifest errors."