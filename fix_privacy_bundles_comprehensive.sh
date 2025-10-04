#!/bin/bash

# Comprehensive Privacy Bundle Fix for Flutter iOS Build
# This script ensures all privacy bundle files are properly copied to the build directory

set -e
set -u
set -o pipefail

echo "=== Comprehensive Privacy Bundle Fix ==="

# Get the project root directory
PROJECT_ROOT="/workspace"
IOS_DIR="${PROJECT_ROOT}/ios"

# List of plugins that need privacy bundles (from the error messages)
PRIVACY_PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
    "shared_preferences_foundation"
    "share_plus"
    "permission_handler_apple"
    "path_provider_foundation"
    "package_info_plus"
)

echo "Project root: ${PROJECT_ROOT}"
echo "iOS directory: ${IOS_DIR}"

# Function to create privacy bundle in build directory
create_privacy_bundle() {
    local plugin_name="$1"
    local source_bundle="${IOS_DIR}/${plugin_name}_privacy.bundle"
    local source_file="${source_bundle}/${plugin_name}_privacy"
    
    echo "Processing privacy bundle for: ${plugin_name}"
    echo "Source bundle: ${source_bundle}"
    echo "Source file: ${source_file}"
    
    if [ -d "${source_bundle}" ] && [ -f "${source_file}" ]; then
        echo "✅ Found privacy bundle for ${plugin_name}"
        
        # Create multiple possible build locations to ensure coverage
        local build_locations=(
            "${PROJECT_ROOT}/build/ios/Debug-dev-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
            "${PROJECT_ROOT}/build/ios/Debug-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
            "${PROJECT_ROOT}/build/ios/Release-iphoneos/${plugin_name}/${plugin_name}_privacy.bundle"
            "${PROJECT_ROOT}/build/ios/Release-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
        )
        
        for build_location in "${build_locations[@]}"; do
            local build_dir="$(dirname "${build_location}")"
            local privacy_file="${build_location}/${plugin_name}_privacy"
            
            echo "Creating build directory: ${build_dir}"
            mkdir -p "${build_dir}"
            
            echo "Copying privacy bundle to: ${build_location}"
            cp -R "${source_bundle}" "${build_location}"
            
            # Ensure the privacy file exists in the correct location
            if [ -f "${privacy_file}" ]; then
                echo "✅ Privacy file exists at: ${privacy_file}"
            else
                echo "⚠️ Privacy file missing, creating it..."
                cp "${source_file}" "${privacy_file}"
            fi
            
            # Verify the copy
            if [ -f "${privacy_file}" ]; then
                echo "✅ Verified privacy bundle copy for ${plugin_name} at ${build_location}"
            else
                echo "❌ Failed to verify privacy bundle copy for ${plugin_name}"
                return 1
            fi
        done
        
        echo "✅ Successfully processed privacy bundle for ${plugin_name}"
    else
        echo "⚠️ Privacy bundle not found for ${plugin_name} at ${source_bundle}"
        
        # Create minimal privacy bundle as fallback
        local fallback_content='{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}'
        
        local build_locations=(
            "${PROJECT_ROOT}/build/ios/Debug-dev-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
            "${PROJECT_ROOT}/build/ios/Debug-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
            "${PROJECT_ROOT}/build/ios/Release-iphoneos/${plugin_name}/${plugin_name}_privacy.bundle"
            "${PROJECT_ROOT}/build/ios/Release-iphonesimulator/${plugin_name}/${plugin_name}_privacy.bundle"
        )
        
        for build_location in "${build_locations[@]}"; do
            local build_dir="$(dirname "${build_location}")"
            local privacy_file="${build_location}/${plugin_name}_privacy"
            
            echo "Creating fallback privacy bundle for ${plugin_name} at ${build_location}"
            mkdir -p "${build_dir}"
            cp -R "${source_bundle}" "${build_location}" 2>/dev/null || mkdir -p "${build_location}"
            echo "${fallback_content}" > "${privacy_file}"
            echo "✅ Created fallback privacy bundle for ${plugin_name}"
        done
    fi
}

# Process all privacy bundles
echo "Processing privacy bundles for all plugins..."
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    create_privacy_bundle "${plugin}"
done

# Also create a pre-build script that will run during Xcode build
echo "Creating pre-build privacy fix script..."
cat > "${IOS_DIR}/pre_build_privacy_fix.sh" << 'EOF'
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
EOF

chmod +x "${IOS_DIR}/pre_build_privacy_fix.sh"
echo "✅ Created pre-build privacy fix script"

# Also create a post-install script for CocoaPods
echo "Creating CocoaPods post-install privacy fix..."
cat > "${IOS_DIR}/pod_post_install_privacy_fix.rb" << 'EOF'
# CocoaPods Post-Install Privacy Bundle Fix
# This ensures privacy bundles are properly handled during pod installation

post_install do |installer|
  puts "🔧 Setting up privacy bundle fix..."
  
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

    # Create privacy bundle copy script phase
    privacy_phase = app_target.new_shell_script_build_phase('[CP] Copy Privacy Bundles')
    privacy_phase.shell_path = '/bin/sh'
    privacy_phase.show_env_vars_in_log = false
    privacy_phase.shell_script = <<~SCRIPT
      set -e
      set -u
      set -o pipefail
      
      echo "=== Copy Privacy Bundles ==="
      
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
      
      # Function to copy privacy bundle
      copy_privacy_bundle() {
        local plugin_name="$1"
        local source_bundle="${SRCROOT}/${plugin_name}_privacy.bundle"
        local source_file="${source_bundle}/${plugin_name}_privacy"
        local dest_dir="${BUILT_PRODUCTS_DIR}/${plugin_name}/${plugin_name}_privacy.bundle"
        local dest_file="${dest_dir}/${plugin_name}_privacy"
        
        echo "Processing privacy bundle for: $plugin_name"
        
        if [ -d "$source_bundle" ] && [ -f "$source_file" ]; then
          # Create destination directory
          mkdir -p "$(dirname "$dest_dir")"
          
          # Copy the bundle
          cp -R "$source_bundle" "$dest_dir"
          echo "✅ Copied $plugin_name privacy bundle"
          
          # Verify the copy
          if [ -f "$dest_file" ]; then
            echo "✅ Verified $plugin_name privacy bundle copy"
          else
            echo "❌ Failed to verify $plugin_name privacy bundle copy"
            return 1
          fi
        else
          echo "⚠️ $plugin_name privacy bundle not found, creating minimal one"
          
          # Create minimal privacy bundle
          mkdir -p "$dest_dir"
          cat > "$dest_file" << 'PRIVACY_EOF'
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
      
      echo "=== Copy Privacy Bundles Complete ==="
    SCRIPT
    
    # Move this phase to be early in the build process
    app_target.build_phases.move(privacy_phase, 1)
    puts "✅ Added privacy bundle copy phase to Runner target"
  else
    puts "⚠️ Runner target not found in Pods project"
  end
end
EOF

echo "✅ Created CocoaPods post-install privacy fix"

echo "=== Comprehensive Privacy Bundle Fix Complete ==="
echo ""
echo "Next steps:"
echo "1. Run this script: ./fix_privacy_bundles_comprehensive.sh"
echo "2. Clean and rebuild your iOS project"
echo "3. The privacy bundles should now be properly copied during the build process"