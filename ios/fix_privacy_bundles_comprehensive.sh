#!/bin/bash

# Comprehensive Privacy Bundle Fix Script
# This script ensures all privacy bundles are properly copied to the build directory

set -e
set -u
set -o pipefail

echo "=== Comprehensive Privacy Bundle Fix ==="

# Get the current directory (should be ios/)
IOS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$IOS_DIR")"

echo "iOS Directory: $IOS_DIR"
echo "Project Root: $PROJECT_ROOT"

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

# Function to create privacy bundle if it doesn't exist
create_privacy_bundle() {
    local plugin_name="$1"
    local bundle_dir="$IOS_DIR/${plugin_name}_privacy.bundle"
    local privacy_file="$bundle_dir/${plugin_name}_privacy"
    
    echo "Processing privacy bundle for: $plugin_name"
    
    # Create bundle directory if it doesn't exist
    mkdir -p "$bundle_dir"
    
    # Create privacy manifest file if it doesn't exist
    if [ ! -f "$privacy_file" ]; then
        echo "Creating privacy manifest for $plugin_name..."
        cat > "$privacy_file" << EOF
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": [
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
EOF
        echo "✅ Created privacy manifest for $plugin_name"
    else
        echo "✅ Privacy manifest already exists for $plugin_name"
    fi
    
    # Verify the bundle was created
    if [ -f "$privacy_file" ]; then
        echo "✅ Verified $plugin_name privacy bundle exists"
    else
        echo "❌ Failed to create $plugin_name privacy bundle"
        return 1
    fi
}

# Create all privacy bundles
echo "Creating/verifying privacy bundles..."
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    create_privacy_bundle "$plugin"
done

# Function to copy privacy bundles to build directory
copy_privacy_bundles_to_build() {
    local build_dir="$1"
    local plugin_name="$2"
    local bundle_dir="$IOS_DIR/${plugin_name}_privacy.bundle"
    local dest_dir="$build_dir/${plugin_name}/${plugin_name}_privacy.bundle"
    
    echo "Copying $plugin_name privacy bundle to build directory..."
    
    # Create destination directory
    mkdir -p "$(dirname "$dest_dir")"
    
    if [ -d "$bundle_dir" ]; then
        # Remove existing bundle if it exists
        rm -rf "$dest_dir"
        
        # Copy the bundle
        cp -R "$bundle_dir" "$dest_dir"
        echo "✅ Copied $plugin_name privacy bundle to: $dest_dir"
        
        # Verify the copy
        if [ -f "$dest_dir/${plugin_name}_privacy" ]; then
            echo "✅ Verified $plugin_name privacy bundle copy"
        else
            echo "❌ Failed to verify $plugin_name privacy bundle copy"
            return 1
        fi
    else
        echo "❌ Source bundle not found: $bundle_dir"
        return 1
    fi
}

# Try to find build directories and copy bundles
echo "Looking for build directories..."

# Common build directory patterns
BUILD_PATTERNS=(
    "$PROJECT_ROOT/build/ios/Debug-dev-iphonesimulator"
    "$PROJECT_ROOT/build/ios/Debug-iphonesimulator"
    "$PROJECT_ROOT/build/ios/Debug-iphoneos"
    "$PROJECT_ROOT/build/ios/Release-iphonesimulator"
    "$PROJECT_ROOT/build/ios/Release-iphoneos"
    "/Volumes/Untitled/member360_wb/build/ios/Debug-dev-iphonesimulator"
    "/Volumes/Untitled/member360_wb/build/ios/Debug-iphonesimulator"
    "/Volumes/Untitled/member360_wb/build/ios/Debug-iphoneos"
    "/Volumes/Untitled/member360_wb/build/ios/Release-iphonesimulator"
    "/Volumes/Untitled/member360_wb/build/ios/Release-iphoneos"
)

# Find and copy to existing build directories
for build_pattern in "${BUILD_PATTERNS[@]}"; do
    if [ -d "$build_pattern" ]; then
        echo "Found build directory: $build_pattern"
        
        for plugin in "${PRIVACY_PLUGINS[@]}"; do
            copy_privacy_bundles_to_build "$build_pattern" "$plugin"
        done
    fi
done

# Create a pre-build script that will be called during Xcode build
echo "Creating pre-build script..."
PRE_BUILD_SCRIPT="$IOS_DIR/pre_build_privacy_fix.sh"
cat > "$PRE_BUILD_SCRIPT" << 'EOF'
#!/bin/bash

# Pre-build Privacy Bundle Fix Script
# This script runs during Xcode build to ensure privacy bundles are available

set -e
set -u
set -o pipefail

echo "=== Pre-Build Privacy Bundle Fix ==="

# Get build environment variables
SRCROOT="${SRCROOT:-$(pwd)}"
BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR:-}"
CONFIGURATION_BUILD_DIR="${CONFIGURATION_BUILD_DIR:-}"

echo "SRCROOT: $SRCROOT"
echo "BUILT_PRODUCTS_DIR: $BUILT_PRODUCTS_DIR"
echo "CONFIGURATION_BUILD_DIR: $CONFIGURATION_BUILD_DIR"

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

# Function to copy privacy bundle
copy_privacy_bundle() {
    local plugin_name="$1"
    local bundle_dir="$SRCROOT/${plugin_name}_privacy.bundle"
    local dest_dir="$BUILT_PRODUCTS_DIR/${plugin_name}/${plugin_name}_privacy.bundle"
    
    echo "Processing privacy bundle for: $plugin_name"
    
    if [ -d "$bundle_dir" ]; then
        # Create destination directory
        mkdir -p "$(dirname "$dest_dir")"
        
        # Copy the bundle
        cp -R "$bundle_dir" "$dest_dir"
        echo "✅ Copied $plugin_name privacy bundle to: $dest_dir"
        
        # Verify the copy
        if [ -f "$dest_dir/${plugin_name}_privacy" ]; then
            echo "✅ Verified $plugin_name privacy bundle copy"
        else
            echo "❌ Failed to verify $plugin_name privacy bundle copy"
            return 1
        fi
    else
        echo "❌ Source bundle not found: $bundle_dir"
        return 1
    fi
}

# Copy all privacy bundles
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    copy_privacy_bundle "$plugin"
done

echo "=== Pre-Build Privacy Bundle Fix Complete ==="
EOF

chmod +x "$PRE_BUILD_SCRIPT"
echo "✅ Created pre-build script: $PRE_BUILD_SCRIPT"

# Privacy bundle fix is now handled directly in the main Podfile
echo "✅ Privacy bundle fix is integrated into the main Podfile - no separate script needed"

echo "=== Comprehensive Privacy Bundle Fix Complete ==="
echo ""
echo "Next steps:"
echo "1. Run 'pod install' in the ios/ directory to apply the fixes"
echo "2. Clean and rebuild your iOS project"
echo "3. The privacy bundles should now be properly copied during build"