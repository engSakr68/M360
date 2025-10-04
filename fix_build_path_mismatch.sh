#!/bin/bash

# Fix Build Path Mismatch for Privacy Bundles
# This script handles the case where the build system expects files in a different location

set -e
set -u
set -o pipefail

echo "=== Fix Build Path Mismatch for Privacy Bundles ==="

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IOS_DIR="${PROJECT_ROOT}/ios"

echo "Project Root: ${PROJECT_ROOT}"
echo "iOS Directory: ${IOS_DIR}"

# Expected build paths from the error message
EXPECTED_BUILD_ROOT="/Volumes/Untitled/member360_wb/build/ios"
CURRENT_BUILD_ROOT="${IOS_DIR}/build"

echo "Expected build root: ${EXPECTED_BUILD_ROOT}"
echo "Current build root: ${CURRENT_BUILD_ROOT}"

# List of plugins that need privacy bundles
PRIVACY_PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
    "image_picker_ios"
    "permission_handler_apple"
    "shared_preferences_foundation"
    "share_plus"
    "path_provider_foundation"
    "package_info_plus"
    "firebase_messaging"
)

# Function to create privacy bundle in expected location
create_privacy_bundle_in_expected_location() {
    local plugin_name="$1"
    local source_file="${IOS_DIR}/${plugin_name}_privacy.bundle/${plugin_name}_privacy"
    local expected_dir="${EXPECTED_BUILD_ROOT}/Debug-dev-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
    local expected_file="${expected_dir}/${plugin_name}_privacy"
    
    echo "Processing privacy bundle for: $plugin_name"
    echo "Source file: $source_file"
    echo "Expected file: $expected_file"
    
    # Check if source file exists
    if [ -f "$source_file" ]; then
        echo "✅ Found source file: $source_file"
        
        # Try to create the expected directory structure
        if mkdir -p "$expected_dir" 2>/dev/null; then
            # Copy the privacy file to expected location
            cp "$source_file" "$expected_file"
            echo "✅ Copied privacy bundle to expected location: $expected_file"
        else
            echo "⚠️ Cannot create directory at expected location: $expected_dir"
            echo "This might be due to permission restrictions or the volume not being mounted."
            
            # Try alternative approach - create symlink if possible
            local parent_dir="$(dirname "$expected_dir")"
            if mkdir -p "$parent_dir" 2>/dev/null; then
                echo "Creating symlink from expected location to current location..."
                local current_file="${CURRENT_BUILD_ROOT}/Debug-dev-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle/${plugin_name}_privacy"
                if [ -f "$current_file" ]; then
                    ln -sf "$current_file" "$expected_file" 2>/dev/null && echo "✅ Created symlink: $expected_file -> $current_file" || echo "❌ Failed to create symlink"
                fi
            fi
        fi
    else
        echo "⚠️ Source file not found: $source_file"
        
        # Create minimal privacy bundle in expected location
        if mkdir -p "$expected_dir" 2>/dev/null; then
            cat > "$expected_file" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
            echo "✅ Created minimal privacy bundle at expected location: $expected_file"
        else
            echo "❌ Cannot create privacy bundle at expected location"
        fi
    fi
}

# Function to create symlink from expected path to current path
create_symlink_if_possible() {
    local plugin_name="$1"
    local expected_path="${EXPECTED_BUILD_ROOT}/Debug-dev-iphonesimulator/${plugin_name}"
    local current_path="${CURRENT_BUILD_ROOT}/Debug-dev-iphonesimulator/${plugin_name}"
    
    echo "Attempting to create symlink for $plugin_name..."
    echo "Expected path: $expected_path"
    echo "Current path: $current_path"
    
    # Check if current path exists
    if [ -d "$current_path" ]; then
        echo "✅ Current path exists: $current_path"
        
        # Try to create parent directory for symlink
        local expected_parent="$(dirname "$expected_path")"
        if mkdir -p "$expected_parent" 2>/dev/null; then
            # Create symlink
            ln -sf "$current_path" "$expected_path" 2>/dev/null && echo "✅ Created symlink: $expected_path -> $current_path" || echo "❌ Failed to create symlink"
        else
            echo "❌ Cannot create parent directory for symlink: $expected_parent"
        fi
    else
        echo "⚠️ Current path does not exist: $current_path"
    fi
}

# First, ensure privacy bundles exist in current location
echo "Step 1: Ensuring privacy bundles exist in current location..."
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    create_privacy_bundle_in_expected_location "$plugin"
done

# Step 2: Try to create symlinks from expected paths to current paths
echo "Step 2: Attempting to create symlinks from expected paths to current paths..."
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    create_symlink_if_possible "$plugin"
done

# Step 3: Verify critical files exist
echo "Step 3: Verifying critical privacy bundles..."

CRITICAL_BUNDLES=(
    "url_launcher_ios"
    "sqflite_darwin"
)

for bundle in "${CRITICAL_BUNDLES[@]}"; do
    echo "Checking $bundle..."
    
    # Check current location
    current_file="${CURRENT_BUILD_ROOT}/Debug-dev-iphonesimulator/${bundle}/${bundle}_privacy.bundle/${bundle}_privacy"
    if [ -f "$current_file" ]; then
        echo "✅ Current location exists: $current_file"
    else
        echo "❌ Current location missing: $current_file"
    fi
    
    # Check expected location
    expected_file="${EXPECTED_BUILD_ROOT}/Debug-dev-iphonesimulator/${bundle}/${bundle}_privacy.bundle/${bundle}_privacy"
    if [ -f "$expected_file" ]; then
        echo "✅ Expected location exists: $expected_file"
    else
        echo "❌ Expected location missing: $expected_file"
    fi
done

echo "=== Build Path Mismatch Fix Complete ==="
echo ""
echo "If the expected paths still don't exist, this might be because:"
echo "1. The volume /Volumes/Untitled/ is not mounted"
echo "2. Permission restrictions prevent creating directories there"
echo "3. The build system is using a different working directory"
echo ""
echo "In that case, you may need to:"
echo "1. Mount the volume at the expected location"
echo "2. Run the build from the expected working directory"
echo "3. Modify the build configuration to use the correct paths"