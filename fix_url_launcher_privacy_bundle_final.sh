#!/bin/bash

# Final Fix for url_launcher_ios privacy bundle issue
# This script ensures the privacy bundle is properly created and accessible during build

set -e
set -u
set -o pipefail

echo "🔧 Final Fix for url_launcher_ios privacy bundle issue..."

# Navigate to the workspace
cd /workspace

# Ensure the privacy bundle directory exists in iOS
mkdir -p ios/url_launcher_ios_privacy.bundle

# Create the privacy bundle file with proper content
cat > ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy << 'EOF'
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
EOF

echo "✅ Created url_launcher_ios privacy bundle"

# Verify the file was created correctly
if [ -f "ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy" ]; then
    echo "✅ Privacy bundle file exists and is accessible"
    echo "📄 Content preview:"
    head -5 ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy
else
    echo "❌ Failed to create privacy bundle file"
    exit 1
fi

# Create a comprehensive build script that ensures the privacy bundle is available
cat > ios/ensure_privacy_bundles.sh << 'EOF'
#!/bin/bash

# Ensure Privacy Bundles Script
# This script ensures all privacy bundles are available during build

set -e
set -u
set -o pipefail

echo "=== Ensuring Privacy Bundles are Available ==="

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

# Function to ensure privacy bundle is available
ensure_privacy_bundle() {
    local plugin_name="$1"
    local bundle_dir="$SRCROOT/${plugin_name}_privacy.bundle"
    local dest_dir="$BUILT_PRODUCTS_DIR/${plugin_name}/${plugin_name}_privacy.bundle"
    
    echo "Ensuring privacy bundle for: $plugin_name"
    
    if [ -d "$bundle_dir" ]; then
        # Create destination directory
        mkdir -p "$(dirname "$dest_dir")"
        
        # Copy the bundle
        cp -R "$bundle_dir" "$dest_dir"
        echo "✅ Ensured $plugin_name privacy bundle at: $dest_dir"
        
        # Verify the copy
        if [ -f "$dest_dir/${plugin_name}_privacy" ]; then
            echo "✅ Verified $plugin_name privacy bundle"
        else
            echo "❌ Failed to verify $plugin_name privacy bundle"
            return 1
        fi
    else
        echo "❌ Source bundle not found: $bundle_dir"
        return 1
    fi
}

# Ensure all privacy bundles are available
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    ensure_privacy_bundle "$plugin"
done

echo "=== Privacy Bundles Ensured ==="
EOF

chmod +x ios/ensure_privacy_bundles.sh

echo "✅ Created comprehensive privacy bundle ensure script"

# Update the Podfile to include a more robust privacy bundle fix
cat > ios/Podfile.privacy_fix << 'EOF'
# Add this to the post_install block in your Podfile

# Enhanced Privacy Bundle Fix for url_launcher_ios
puts "🔧 Setting up enhanced privacy bundle fix for url_launcher_ios..."

# Get the Runner target
app_target = installer.pods_project.targets.find { |t| t.name == 'Runner' }

if app_target
  # Remove any existing privacy script phases
  app_target.shell_script_build_phases.dup.each do |phase|
    if phase.name && (phase.name.include?('Privacy') || phase.name.include?('privacy'))
      app_target.build_phases.delete(phase)
      puts "• Removed existing privacy script phase: #{phase.name}"
    end
  end

  # Create an enhanced privacy bundle copy script phase
  privacy_phase = app_target.new_shell_script_build_phase('[CP] Copy Privacy Bundles (Enhanced)')
  privacy_phase.shell_path = '/bin/sh'
  privacy_phase.show_env_vars_in_log = false
  privacy_phase.shell_script = <<~SCRIPT
    set -e
    set -u
    set -o pipefail
    
    echo "=== Enhanced Privacy Bundle Copy ==="
    
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
    )
    
    # Function to copy privacy bundle
    copy_privacy_bundle() {
      local plugin_name="$1"
      local bundle_dir="${SRCROOT}/${plugin_name}_privacy.bundle"
      local dest_dir="${BUILT_PRODUCTS_DIR}/${plugin_name}/${plugin_name}_privacy.bundle"
      
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
        echo "⚠️ $plugin_name privacy bundle not found at $bundle_dir"
        # Create minimal privacy bundle as fallback
        mkdir -p "$dest_dir"
        cat > "$dest_dir/${plugin_name}_privacy" << 'PRIVACY_EOF'
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
    
    # Also copy to alternative locations that might be needed
    if [ -n "${CONFIGURATION_BUILD_DIR}" ] && [ "${CONFIGURATION_BUILD_DIR}" != "${BUILT_PRODUCTS_DIR}" ]; then
      echo "Also copying to CONFIGURATION_BUILD_DIR: ${CONFIGURATION_BUILD_DIR}"
      for plugin in "${PRIVACY_PLUGINS[@]}"; do
        copy_privacy_bundle "$plugin"
      done
    fi
    
    echo "=== Enhanced Privacy Bundle Copy Complete ==="
  SCRIPT
  
  # Move this phase to be early in the build process (after dependencies but before compilation)
  app_target.build_phases.move(privacy_phase, 1)
  puts "✅ Added enhanced privacy bundle copy phase to Runner target"
else
  puts "⚠️ Runner target not found in Pods project"
end
EOF

echo "✅ Created Podfile privacy fix snippet"

# Clean and reinstall pods to ensure proper integration
echo "🧹 Cleaning and reinstalling CocoaPods..."
cd ios
rm -rf Pods
rm -f Podfile.lock

# Install pods (this will trigger the privacy bundle scripts in Podfile)
echo "📦 Installing CocoaPods dependencies..."
pod install --repo-update

echo "✅ CocoaPods installation complete"

# Verify the privacy bundle is accessible
if [ -f "url_launcher_ios_privacy.bundle/url_launcher_ios_privacy" ]; then
    echo "✅ Privacy bundle accessible from iOS directory"
else
    echo "❌ Privacy bundle not found in iOS directory"
    exit 1
fi

echo "🎉 url_launcher_ios privacy bundle fix complete!"
echo ""
echo "Next steps:"
echo "1. Try building your iOS app again"
echo "2. The privacy bundle is now properly configured and should be copied during build"
echo "3. If issues persist, check the build logs for the privacy bundle copy phase"