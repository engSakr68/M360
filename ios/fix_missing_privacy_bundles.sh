#!/bin/bash

# Fix Missing Privacy Bundles Script
# This script addresses the specific Xcode build errors for missing privacy bundle files
# Error paths from Xcode:
# - /Volumes/Untitled/member360_wb/build/ios/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy
# - /Volumes/Untitled/member360_wb/build/ios/Debug-dev-iphonesimulator/sqflite_darwin/sqflite_darwin_privacy.bundle/sqflite_darwin_privacy

set -e
set -u
set -o pipefail

echo "=== Fix Missing Privacy Bundles Script ==="

# Set default paths
SRCROOT="${SRCROOT:-/workspace/ios}"
PROJECT_ROOT="${SRCROOT}/.."

echo "SRCROOT: $SRCROOT"
echo "PROJECT_ROOT: $PROJECT_ROOT"

# List of plugins that need privacy bundles (from the error messages)
PRIVACY_PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
)

# Function to create privacy bundle in source location
create_source_privacy_bundle() {
    local plugin_name="$1"
    local source_bundle="${SRCROOT}/${plugin_name}_privacy.bundle"
    local source_file="${source_bundle}/${plugin_name}_privacy"
    
    echo "Creating source privacy bundle for: $plugin_name"
    echo "Source bundle: $source_bundle"
    
    # Create source bundle directory
    mkdir -p "$source_bundle"
    
    # Create the privacy manifest file
    cat > "$source_file" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
    
    # Create PrivacyInfo.xcprivacy file
    cat > "${source_bundle}/PrivacyInfo.xcprivacy" << 'PRIVACY_XML_EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>NSPrivacyTracking</key>
    <false/>
    <key>NSPrivacyCollectedDataTypes</key>
    <array/>
    <key>NSPrivacyAccessedAPITypes</key>
    <array/>
</dict>
</plist>
PRIVACY_XML_EOF
    
    echo "✅ Created source privacy bundle for $plugin_name"
}

# Function to create privacy bundle in the specific error paths
create_error_path_privacy_bundle() {
    local plugin_name="$1"
    local source_bundle="${SRCROOT}/${plugin_name}_privacy.bundle"
    
    echo "Creating privacy bundles for error paths: $plugin_name"
    
    # Define the specific error paths from the Xcode build error
    local error_paths=(
        "/Volumes/Untitled/member360_wb/build/ios/Debug-dev-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
        "/Volumes/Untitled/member360_wb/build/ios/Debug-dev-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
        "/Volumes/Untitled/member360_wb/build/ios/Release-dev-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
        "/Volumes/Untitled/member360_wb/build/ios/Debug-prod-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
        "/Volumes/Untitled/member360_wb/build/ios/Release-prod-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
        "/Volumes/Untitled/member360_wb/build/ios/Profile-dev-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
        "/Volumes/Untitled/member360_wb/build/ios/Profile-prod-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
    )
    
    # Copy to all error path locations
    for dest_dir in "${error_paths[@]}"; do
        echo "Creating privacy bundle at: $dest_dir"
        
        # Create parent directories
        mkdir -p "$(dirname "$dest_dir")"
        mkdir -p "$dest_dir"
        
        # Copy files from source bundle
        if [ -d "$source_bundle" ]; then
            cp -R "$source_bundle"/* "$dest_dir/"
            
            # Verify the copy
            local dest_file="${dest_dir}/${plugin_name}_privacy"
            if [ -f "$dest_file" ]; then
                echo "✅ Verified $plugin_name privacy bundle at: $dest_file"
            else
                echo "❌ Failed to verify $plugin_name privacy bundle at: $dest_file"
            fi
        else
            echo "⚠️ Source bundle not found, creating minimal privacy bundle"
            
            # Create minimal privacy bundle
            cat > "${dest_dir}/${plugin_name}_privacy" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
            
            cat > "${dest_dir}/PrivacyInfo.xcprivacy" << 'PRIVACY_XML_EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>NSPrivacyTracking</key>
    <false/>
    <key>NSPrivacyCollectedDataTypes</key>
    <array/>
    <key>NSPrivacyAccessedAPITypes</key>
    <array/>
</dict>
</plist>
PRIVACY_XML_EOF
            
            echo "✅ Created minimal privacy bundle for $plugin_name at: $dest_dir"
        fi
    done
}

# Function to create privacy bundle in local build locations
create_local_build_privacy_bundle() {
    local plugin_name="$1"
    local source_bundle="${SRCROOT}/${plugin_name}_privacy.bundle"
    
    echo "Creating local build privacy bundles for: $plugin_name"
    
    # Define local build destination paths
    local build_dest_paths=()
    
    # Add common Flutter build paths
    local flutter_build_root="${PROJECT_ROOT}/build/ios"
    if [ -d "$flutter_build_root" ]; then
        # Find all build directories
        for build_dir in "$flutter_build_root"/*; do
            if [ -d "$build_dir" ]; then
                build_dest_paths+=("${build_dir}/${plugin_name}/${plugin_name}_privacy.bundle")
            fi
        done
    fi
    
    # Copy to all build locations
    for dest_dir in "${build_dest_paths[@]}"; do
        echo "Creating privacy bundle at: $dest_dir"
        mkdir -p "$dest_dir"
        cp -R "$source_bundle"/* "$dest_dir/"
        
        # Verify the copy
        local dest_file="${dest_dir}/${plugin_name}_privacy"
        if [ -f "$dest_file" ]; then
            echo "✅ Verified $plugin_name privacy bundle at: $dest_file"
        else
            echo "❌ Failed to verify $plugin_name privacy bundle at: $dest_file"
        fi
    done
}

# Create source privacy bundles for all plugins
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    create_source_privacy_bundle "$plugin"
done

# Create privacy bundles in the specific error paths
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    create_error_path_privacy_bundle "$plugin"
done

# Create local build privacy bundles for all plugins
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    create_local_build_privacy_bundle "$plugin"
done

echo "=== Fix Missing Privacy Bundles Complete ==="