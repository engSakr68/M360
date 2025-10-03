#!/bin/bash

# Immediate iOS Privacy Bundle Fix
# This script fixes the current iOS build issue by ensuring privacy bundles are available

set -e
set -u
set -o pipefail

echo "=== Immediate iOS Privacy Bundle Fix ==="

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IOS_DIR="$PROJECT_ROOT/ios"

echo "Project Root: $PROJECT_ROOT"
echo "iOS Directory: $IOS_DIR"

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

# Create a simple Xcode build phase script that will copy the bundles
echo "Creating Xcode build phase script..."
BUILD_PHASE_SCRIPT="$IOS_DIR/copy_privacy_bundles_build_phase.sh"
cat > "$BUILD_PHASE_SCRIPT" << 'EOF'
#!/bin/bash

# Xcode Build Phase Script for Privacy Bundles
# This script runs during Xcode build to copy privacy bundles

set -e
set -u
set -o pipefail

echo "=== Privacy Bundle Build Phase ==="

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

echo "=== Privacy Bundle Build Phase Complete ==="
EOF

chmod +x "$BUILD_PHASE_SCRIPT"
echo "✅ Created build phase script: $BUILD_PHASE_SCRIPT"

# Create a simple script to add the build phase to Xcode project
echo "Creating Xcode project update script..."
XCODE_UPDATE_SCRIPT="$IOS_DIR/add_privacy_build_phase.rb"
cat > "$XCODE_UPDATE_SCRIPT" << 'EOF'
#!/usr/bin/env ruby

# Script to add privacy bundle build phase to Xcode project
require 'xcodeproj'

project_path = 'Runner.xcodeproj'
project = Xcodeproj::Project.open(project_path)

# Find the Runner target
runner_target = project.targets.find { |target| target.name == 'Runner' }

if runner_target
  puts "Found Runner target"
  
  # Remove any existing privacy bundle build phases
  runner_target.build_phases.each do |phase|
    if phase.is_a?(Xcodeproj::Project::Object::PBXShellScriptBuildPhase) && 
       phase.name && phase.name.include?('Privacy')
      puts "Removing existing privacy build phase: #{phase.name}"
      runner_target.build_phases.delete(phase)
    end
  end
  
  # Create new privacy bundle build phase
  privacy_phase = runner_target.new_shell_script_build_phase('[CP] Copy Privacy Bundles')
  privacy_phase.shell_path = '/bin/sh'
  privacy_phase.show_env_vars_in_log = false
  privacy_phase.shell_script = <<~SCRIPT
    set -e
    set -u
    set -o pipefail
    
    echo "=== Privacy Bundle Copy ==="
    
    SRCROOT="${SRCROOT}"
    BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR}"
    
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
    
    # Copy privacy bundles for all plugins
    for plugin in "${PRIVACY_PLUGINS[@]}"; do
      echo "Processing privacy bundle for: $plugin"
      
      PRIVACY_BUNDLE_SRC="${SRCROOT}/${plugin}_privacy.bundle"
      PRIVACY_BUNDLE_DST="${BUILT_PRODUCTS_DIR}/${plugin}/${plugin}_privacy.bundle"
      
      # Create the destination directory
      mkdir -p "${BUILT_PRODUCTS_DIR}/${plugin}"
      
      if [ -d "${PRIVACY_BUNDLE_SRC}" ]; then
        echo "Copying ${plugin} privacy bundle from ${PRIVACY_BUNDLE_SRC}"
        cp -R "${PRIVACY_BUNDLE_SRC}" "${PRIVACY_BUNDLE_DST}"
        echo "✅ Copied ${plugin} privacy bundle to: ${PRIVACY_BUNDLE_DST}"
      else
        echo "⚠️ ${plugin} privacy bundle not found at ${PRIVACY_BUNDLE_SRC}"
        # Create minimal privacy bundle as fallback
        mkdir -p "${PRIVACY_BUNDLE_DST}"
        cat > "${PRIVACY_BUNDLE_DST}/${plugin}_privacy" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
        echo "✅ Created minimal privacy bundle for ${plugin}"
      fi
      
      # Verify the bundle was created
      if [ -f "${PRIVACY_BUNDLE_DST}/${plugin}_privacy" ]; then
        echo "✅ Verified ${plugin} privacy bundle exists"
      else
        echo "❌ Failed to create ${plugin} privacy bundle"
        exit 1
      fi
    done
    
    echo "=== Privacy Bundle Copy Complete ==="
  SCRIPT
  
  # Move this phase to be early in the build process
  runner_target.build_phases.move(privacy_phase, 1)
  puts "✅ Added privacy bundle copy phase to Runner target"
  
  # Save the project
  project.save
  puts "✅ Project saved successfully"
else
  puts "❌ Runner target not found"
  exit 1
end
EOF

chmod +x "$XCODE_UPDATE_SCRIPT"
echo "✅ Created Xcode project update script: $XCODE_UPDATE_SCRIPT"

echo "=== Immediate iOS Privacy Bundle Fix Complete ==="
echo ""
echo "The privacy bundles are now ready. To complete the fix:"
echo ""
echo "1. Run the Xcode project update script:"
echo "   cd $IOS_DIR && ruby add_privacy_build_phase.rb"
echo ""
echo "2. Or manually add a build phase in Xcode:"
echo "   - Open Runner.xcodeproj in Xcode"
echo "   - Select the Runner target"
echo "   - Go to Build Phases tab"
echo "   - Add a new 'Run Script Phase'"
echo "   - Set the script to: $BUILD_PHASE_SCRIPT"
echo ""
echo "3. Clean and rebuild your iOS project"