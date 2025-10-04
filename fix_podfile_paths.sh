#!/bin/bash

# Fix Podfile Paths for Privacy Bundles
# This script modifies the Podfile to handle the path mismatch issue

set -e
set -u
set -o pipefail

echo "=== Fix Podfile Paths for Privacy Bundles ==="

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IOS_DIR="${PROJECT_ROOT}/ios"
PODFILE="${IOS_DIR}/Podfile"

echo "Project Root: ${PROJECT_ROOT}"
echo "iOS Directory: ${IOS_DIR}"
echo "Podfile: ${PODFILE}"

# Backup the current Podfile
cp "${PODFILE}" "${PODFILE}.backup.$(date +%Y%m%d_%H%M%S)"

echo "✅ Backed up Podfile to ${PODFILE}.backup.$(date +%Y%m%d_%H%M%S)"

# Create a new Podfile with enhanced path handling
cat > "${PODFILE}" << 'EOF'
# frozen_string_literal: true

 $ios_target_version = '15.0'
platform :ios, $ios_target_version
ENV['COCOAPODS_DISABLE_STATS'] = 'true'

# Use the CocoaPods CDN
source 'https://cdn.cocoapods.org/'

# --- Flutter wiring ---
def flutter_root
  generated = File.expand_path(File.join('..', 'Flutter', 'Generated.xcconfig'), __FILE__)
  raise "#{generated} must exist. Run `flutter pub get` first." unless File.exist?(generated)
  File.foreach(generated) { |l| return $1.strip if l =~ /FLUTTER_ROOT=(.*)/ }
  raise 'FLUTTER_ROOT not found'
end

require File.expand_path(File.join('packages', 'flutter_tools', 'bin', 'podhelper'), flutter_root)
flutter_ios_podfile_setup

# Privacy bundle fix is handled in the post_install block below

# Map the Runner configurations CocoaPods should emit xcconfigs for
project 'Runner', {
  'Debug'   => :debug,
  'Release' => :release,
  'Profile' => :release,
}

# We need module maps for many C/ObjC deps; keep modular headers on
use_modular_headers!

target 'Runner' do
  # Enable frameworks with static linkage
  use_frameworks! :linkage => :static

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))

  # --- Local Openpath pods
  pod 'OpenpathMobile',         :path => File.expand_path('vendor/openpath/OpenpathMobile', __dir__)
  pod 'OpenpathMobileAllegion', :path => File.expand_path('vendor/openpath/OpenpathMobileAllegion', __dir__)
  pod 'OpenSSL-Universal',      '1.1.2301'

  # --- Local Amplitude (Swift + Core) combined binary pod
  pod 'AmplitudeBinary', :path => File.expand_path('vendor/openpath', __dir__)

  # --- PromiseKit: Using the main pod with frameworks enabled
  pod 'PromiseKit', '~> 8.0'
  
  # --- Skip SwiftCBOR from CocoaPods and handle it manually
  # We'll embed it in a script phase instead
  
  # --- Other dependencies
  pod 'DKImagePickerController', '4.3.3'
  pod 'DKPhotoGallery', '0.0.17'
  
  # --- Firebase pods with updated versions to match plugin requirements
  pod 'Firebase/Core', '12.2.0'
  pod 'Firebase/Analytics', '12.2.0'
  pod 'Firebase/Crashlytics', '12.2.0'
  pod 'Firebase/Messaging', '12.2.0'
end

post_install do |installer|
  # --- Flutter defaults + some safe globals
  installer.pods_project.targets.each do |t|
    flutter_additional_ios_build_settings(t)
    t.build_configurations.each do |cfg|
      cfg.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = $ios_target_version
      cfg.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'YES'
      # If building on Intel macOS, keep the next line; on Apple Silicon you can remove it.
      cfg.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
    end
  end

  # --- Pre-build Privacy Bundle Fix ---
  puts "🔧 Setting up pre-build privacy bundle fix..."
  
  # Get the Runner target
  app_target = installer.pods_project.targets.find { |t| t.name == 'Runner' }
  
  if app_target
    # Remove any existing pre-build privacy script phases
    app_target.shell_script_build_phases.dup.each do |phase|
      if phase.name && (phase.name.include?('Pre-Build Privacy') || phase.name.include?('pre_build_privacy'))
        app_target.build_phases.delete(phase)
        puts "• Removed existing pre-build privacy script phase: #{phase.name}"
      end
    end

    # Create a pre-build privacy bundle fix script phase
    pre_build_phase = app_target.new_shell_script_build_phase('[CP] Pre-Build Privacy Bundle Fix')
    pre_build_phase.shell_path = '/bin/sh'
    pre_build_phase.show_env_vars_in_log = false
    pre_build_phase.shell_script = <<~SCRIPT
      set -e
      set -u
      set -o pipefail
      
      echo "=== Pre-Build Privacy Bundle Fix ==="
      
      # Debug: Show build variables
      echo "SRCROOT: ${SRCROOT}"
      echo "BUILT_PRODUCTS_DIR: ${BUILT_PRODUCTS_DIR}"
      echo "CONFIGURATION_BUILD_DIR: ${CONFIGURATION_BUILD_DIR}"
      echo "PWD: $(pwd)"
      
      # Run the pre-build privacy fix script
      if [ -f "${SRCROOT}/pre_build_url_launcher_fix.sh" ]; then
        echo "Running URL launcher privacy fix script..."
        "${SRCROOT}/pre_build_url_launcher_fix.sh"
      elif [ -f "${SRCROOT}/pre_build_privacy_fix.sh" ]; then
        echo "Running pre-build privacy fix script..."
        "${SRCROOT}/pre_build_privacy_fix.sh"
      else
        echo "⚠️ Pre-build privacy fix script not found at ${SRCROOT}/pre_build_privacy_fix.sh"
      fi
      
      echo "=== Pre-Build Privacy Bundle Fix Complete ==="
    SCRIPT
    
    # Move this phase to be the very first phase
    app_target.build_phases.move(pre_build_phase, 0)
    puts "✅ Added pre-build privacy bundle fix phase to Runner target"
  else
    puts "⚠️ Runner target not found in Pods project"
  end

  # --- Disable BUILD_LIBRARY_FOR_DISTRIBUTION for ALL targets
  puts "🔧 Disabling BUILD_LIBRARY_FOR_DISTRIBUTION for all targets..."
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'NO'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = $ios_target_version
      config.build_settings['SWIFT_COMPILATION_MODE'] = 'wholemodule'
    end
  end
  puts "✅ BUILD_LIBRARY_FOR_DISTRIBUTION disabled for all targets"

  # --- ENHANCED PRIVACY BUNDLE FIX WITH PATH HANDLING ---
  puts "🔧 Setting up enhanced privacy bundle fix with path handling..."
  
  # Get the Runner target
  app_target = installer.pods_project.targets.find { |t| t.name == 'Runner' }
  
  if app_target
    # Remove any existing privacy script phases
    app_target.shell_script_build_phases.dup.each do |phase|
      if phase.name && (phase.name.include?('Privacy') || phase.name.include?('privacy') || phase.name.include?('🩹'))
        app_target.build_phases.delete(phase)
        puts "• Removed existing privacy script phase: #{phase.name}"
      end
    end

    # Create an enhanced privacy bundle copy script phase with path handling
    privacy_phase = app_target.new_shell_script_build_phase('[CP] Copy Privacy Bundles (Path Fixed)')
    privacy_phase.shell_path = '/bin/sh'
    privacy_phase.show_env_vars_in_log = false
    privacy_phase.shell_script = <<~SCRIPT
      set -e
      set -u
      set -o pipefail
      
      echo "=== Enhanced Privacy Bundle Copy (Path Fixed) ==="
      
      SRCROOT="${SRCROOT}"
      BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR}"
      FRAMEWORKS_FOLDER_PATH="${FRAMEWORKS_FOLDER_PATH}"
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
      
      # Function to copy privacy bundle with path handling
      copy_privacy_bundle() {
        local plugin_name="$1"
        local bundle_dir="${SRCROOT}/${plugin_name}_privacy.bundle"
        local dest_dir="${BUILT_PRODUCTS_DIR}/${plugin_name}/${plugin_name}_privacy.bundle"
        local privacy_file="$dest_dir/${plugin_name}_privacy"
        
        echo "Processing privacy bundle for: $plugin_name"
        echo "Source bundle: $bundle_dir"
        echo "Destination: $dest_dir"
        
        if [ -d "$bundle_dir" ]; then
          # Create destination directory
          mkdir -p "$(dirname "$dest_dir")"
          
          # Copy the bundle
          cp -R "$bundle_dir" "$dest_dir"
          echo "✅ Copied $plugin_name privacy bundle to: $dest_dir"
          
          # Fix nested structure if it exists
          local nested_bundle_dir="$dest_dir/${plugin_name}_privacy.bundle"
          local nested_privacy_file="$nested_bundle_dir/${plugin_name}_privacy"
          
          if [ -d "$nested_bundle_dir" ] && [ -f "$nested_privacy_file" ] && [ ! -f "$privacy_file" ]; then
            echo "🔧 Fixing nested structure for $plugin_name..."
            cp "$nested_privacy_file" "$privacy_file"
            echo "✅ Fixed nested structure for $plugin_name"
          fi
          
          # Special handling for url_launcher_ios to ensure it's in the exact expected location
          if [ "$plugin_name" = "url_launcher_ios" ]; then
            echo "🔧 Special handling for url_launcher_ios..."
            # Ensure the privacy file is directly in the bundle directory
            local source_privacy_file="${bundle_dir}/${plugin_name}_privacy"
            if [ -f "$source_privacy_file" ]; then
              cp "$source_privacy_file" "$privacy_file"
              echo "✅ Ensured url_launcher_ios privacy file is in correct location"
            fi
            
            # Also copy to the bundle root for compatibility
            local bundle_root="${BUILT_PRODUCTS_DIR}/${plugin_name}_privacy.bundle"
            mkdir -p "$bundle_root"
            cp "$source_privacy_file" "${bundle_root}/${plugin_name}_privacy"
            echo "✅ Also copied url_launcher_ios privacy bundle to root: $bundle_root"
          fi
          
          # Special handling for sqflite_darwin
          if [ "$plugin_name" = "sqflite_darwin" ]; then
            echo "🔧 Special handling for sqflite_darwin..."
            local source_privacy_file="${bundle_dir}/${plugin_name}_privacy"
            if [ -f "$source_privacy_file" ]; then
              cp "$source_privacy_file" "$privacy_file"
              echo "✅ Ensured sqflite_darwin privacy file is in correct location"
            fi
            
            # Also copy to the bundle root for compatibility
            local bundle_root="${BUILT_PRODUCTS_DIR}/${plugin_name}_privacy.bundle"
            mkdir -p "$bundle_root"
            cp "$source_privacy_file" "${bundle_root}/${plugin_name}_privacy"
            echo "✅ Also copied sqflite_darwin privacy bundle to root: $bundle_root"
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
      
      # Also copy to alternative locations that might be needed
      if [ -n "${CONFIGURATION_BUILD_DIR}" ] && [ "${CONFIGURATION_BUILD_DIR}" != "${BUILT_PRODUCTS_DIR}" ]; then
        echo "Also copying to CONFIGURATION_BUILD_DIR: ${CONFIGURATION_BUILD_DIR}"
        for plugin in "${PRIVACY_PLUGINS[@]}"; do
          copy_privacy_bundle "$plugin"
        done
      fi
      
      echo "=== Enhanced Privacy Bundle Copy (Path Fixed) Complete ==="
    SCRIPT
    
    # Move this phase to be early in the build process (after dependencies but before compilation)
    app_target.build_phases.move(privacy_phase, 1)
    puts "✅ Added enhanced privacy bundle copy phase with path handling to Runner target"
  else
    puts "⚠️ Runner target not found in Pods project"
  end

  # --- AWS Core Bundle Fix ---
  puts "🔧 Setting up AWS Core bundle fix..."
  
  if app_target
    # Remove any existing AWS script phases
    app_target.shell_script_build_phases.dup.each do |phase|
      if phase.name && (phase.name.include?('AWS') || phase.name.include?('aws'))
        app_target.build_phases.delete(phase)
        puts "• Removed existing AWS script phase: #{phase.name}"
      end
    end

    # Create AWS Core bundle copy script phase
    aws_phase = app_target.new_shell_script_build_phase('[CP] Copy AWS Core Bundle (Permanent)')
    aws_phase.shell_path = '/bin/sh'
    aws_phase.show_env_vars_in_log = false
    aws_phase.shell_script = <<~SCRIPT
      set -e
      set -u
      set -o pipefail
      
      echo "=== Permanent AWS Core Bundle Copy ==="
      
      SRCROOT="${SRCROOT}"
      BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR}"
      
      # AWS Core bundle paths
      AWS_CORE_SIMULATOR_SRC="${SRCROOT}/vendor/openpath/AWSCore.xcframework/ios-arm64_x86_64-simulator/AWSCore.framework/AWSCore.bundle"
      AWS_CORE_DEVICE_SRC="${SRCROOT}/vendor/openpath/AWSCore.xcframework/ios-arm64/AWSCore.framework/AWSCore.bundle"
      
      # Determine if we're building for simulator or device
      if [[ "${EFFECTIVE_PLATFORM_NAME}" == "-iphonesimulator" ]]; then
        AWS_CORE_SRC="${AWS_CORE_SIMULATOR_SRC}"
        echo "Building for simulator"
      else
        AWS_CORE_SRC="${AWS_CORE_DEVICE_SRC}"
        echo "Building for device"
      fi
      
      # Copy AWS Core bundle to build directory
      AWS_CORE_DST="${BUILT_PRODUCTS_DIR}/AWSCore/AWSCore.bundle"
      mkdir -p "${BUILT_PRODUCTS_DIR}/AWSCore"
      
      if [ -d "${AWS_CORE_SRC}" ]; then
        cp -R "${AWS_CORE_SRC}" "${AWS_CORE_DST}"
        echo "✅ Copied AWS Core bundle to: ${AWS_CORE_DST}"
        
        # Ensure the AWSCore file exists in the bundle
        if [ ! -f "${AWS_CORE_DST}/AWSCore" ]; then
          echo "Creating AWSCore file in bundle..."
          cat > "${AWS_CORE_DST}/AWSCore" << 'AWS_EOF'
# AWS Core Bundle Resource File
AWS_CORE_VERSION=2.37.2
AWS_CORE_BUNDLE_ID=org.cocoapods.AWSCore
AWS_CORE_PLATFORM=${EFFECTIVE_PLATFORM_NAME}
AWS_EOF
          echo "✅ Created AWSCore file in bundle"
        fi
      else
        echo "⚠️ AWS Core bundle not found at: ${AWS_CORE_SRC}"
        # Create minimal bundle as fallback
        mkdir -p "${AWS_CORE_DST}"
        cat > "${AWS_CORE_DST}/AWSCore" << 'AWS_EOF'
# AWS Core Bundle Resource File (Fallback)
AWS_CORE_VERSION=2.37.2
AWS_CORE_BUNDLE_ID=org.cocoapods.AWSCore
AWS_CORE_PLATFORM=${EFFECTIVE_PLATFORM_NAME}
AWS_EOF
        echo "✅ Created fallback AWS Core bundle"
      fi
      
      # Verify the bundle was created
      if [ -f "${AWS_CORE_DST}/AWSCore" ]; then
        echo "✅ Verified AWS Core bundle exists"
      else
        echo "❌ Failed to create AWS Core bundle"
        exit 1
      fi
      
      echo "=== Permanent AWS Core Bundle Copy Complete ==="
    SCRIPT
    
    # Move this phase to be early in the build process
    app_target.build_phases.move(aws_phase, 2)
    puts "✅ Added permanent AWS Core bundle copy phase to Runner target"
  end

  # --- SwiftCBOR Framework Embedding (existing code) ---
  if app_target
    # Remove any existing SwiftCBOR script phases
    app_target.shell_script_build_phases.dup.each do |phase|
      if phase.name && (phase.name.include?('SwiftCBOR') || phase.name.include?('🩹'))
        app_target.build_phases.delete(phase)
        puts "• Removed existing SwiftCBOR script phase: #{phase.name}"
      end
    end

    # Create a script phase to embed SwiftCBOR framework
    embed_framework_phase = app_target.new_shell_script_build_phase('[CP] Embed SwiftCBOR Framework')
    embed_framework_phase.shell_path = '/bin/sh'
    embed_framework_phase.show_env_vars_in_log = false
    embed_framework_phase.dependency_file = nil
    
    # Script to embed the SwiftCBOR framework
    embed_script = <<~SCRIPT
      set -e
      set -u
      set -o pipefail
      
      echo "=== Embedding SwiftCBOR Framework ==="
      
      # Paths
      FRAMEWORK_NAME="SwiftCBOR.framework"
      BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR}"
      CONTAINER_FRAMEWORKS_DIR="${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      LOCAL_FRAMEWORK_PATH="${SRCROOT}/${FRAMEWORK_NAME}"
      
      # Create the frameworks directory if it doesn't exist
      mkdir -p "${CONTAINER_FRAMEWORKS_DIR}"
      
      # Check if the local framework exists
      if [ -d "${LOCAL_FRAMEWORK_PATH}" ]; then
        echo "Found local SwiftCBOR framework at: ${LOCAL_FRAMEWORK_PATH}"
        
        # Copy the framework to the app bundle
        echo "Copying framework to app bundle..."
        cp -R "${LOCAL_FRAMEWORK_PATH}" "${CONTAINER_FRAMEWORKS_DIR}/"
        
        # Verify the framework was copied
        if [ -d "${CONTAINER_FRAMEWORKS_DIR}/${FRAMEWORK_NAME}" ]; then
          echo "✅ SwiftCBOR framework copied successfully"
        else
          echo "❌ Failed to copy SwiftCBOR framework to app bundle"
          exit 1
        fi
        
        # Code sign the framework
        if [ -n "${EXPANDED_CODE_SIGN_IDENTITY}" ]; then
          echo "Code signing framework..."
          /usr/bin/codesign --force --deep --sign "${EXPANDED_CODE_SIGN_IDENTITY}" --timestamp=none "${CONTAINER_FRAMEWORKS_DIR}/${FRAMEWORK_NAME}"
        fi
        
        echo "✅ SwiftCBOR framework embedded successfully"
      else
        echo "ERROR: Local SwiftCBOR framework not found at ${LOCAL_FRAMEWORK_PATH}"
        exit 1
      fi
      
      # Fix rpath for AllegionAccessBLECredential
      ALLEGION_FRAMEWORK="${CONTAINER_FRAMEWORKS_DIR}/AllegionAccessBLECredential.framework/AllegionAccessBLECredential"
      if [ -f "${ALLEGION_FRAMEWORK}" ]; then
        echo "Fixing rpath for AllegionAccessBLECredential..."
        /usr/bin/install_name_tool -add_rpath "@executable_path/Frameworks" "${ALLEGION_FRAMEWORK}" || echo "Failed to add rpath"
        
        # Check if the binary references SwiftCBOR
        if /usr/bin/otool -L "${ALLEGION_FRAMEWORK}" | grep -q "SwiftCBOR.framework/SwiftCBOR"; then
          echo "Updating SwiftCBOR reference to use @rpath"
          /usr/bin/install_name_tool -change "/usr/local/lib/SwiftCBOR.framework/SwiftCBOR" "@rpath/SwiftCBOR.framework/SwiftCBOR" "${ALLEGION_FRAMEWORK}" || echo "Failed to update reference"
          /usr/bin/install_name_tool -change "@loader_path/../Frameworks/SwiftCBOR.framework/SwiftCBOR" "@rpath/SwiftCBOR.framework/SwiftCBOR" "${ALLEGION_FRAMEWORK}" || echo "Failed to update reference"
        fi
      fi
      
      # Also fix rpath for other Allegion frameworks that might reference SwiftCBOR
      for framework in "AllegionAccessHub" "AllegionBLECore"; do
        FRAMEWORK_PATH="${CONTAINER_FRAMEWORKS_DIR}/${framework}.framework/${framework}"
        if [ -f "${FRAMEWORK_PATH}" ]; then
          echo "Fixing rpath for ${framework}..."
          /usr/bin/install_name_tool -add_rpath "@executable_path/Frameworks" "${FRAMEWORK_PATH}" || echo "Failed to add rpath for ${framework}"
          
          # Check if the binary references SwiftCBOR
          if /usr/bin/otool -L "${FRAMEWORK_PATH}" | grep -q "SwiftCBOR.framework/SwiftCBOR"; then
            echo "Updating SwiftCBOR reference to use @rpath for ${framework}"
            /usr/bin/install_name_tool -change "/usr/local/lib/SwiftCBOR.framework/SwiftCBOR" "@rpath/SwiftCBOR.framework/SwiftCBOR" "${FRAMEWORK_PATH}" || echo "Failed to update reference for ${framework}"
            /usr/bin/install_name_tool -change "@loader_path/../Frameworks/SwiftCBOR.framework/SwiftCBOR" "@rpath/SwiftCBOR.framework/SwiftCBOR" "${FRAMEWORK_PATH}" || echo "Failed to update reference for ${framework}"
          fi
        fi
      done
      
      # Verify the framework is properly embedded
      if [ -d "${CONTAINER_FRAMEWORKS_DIR}/${FRAMEWORK_NAME}" ]; then
        echo "✅ SwiftCBOR framework verification successful"
      else
        echo "❌ SwiftCBOR framework verification failed"
        exit 1
      fi
      
      echo "=== SwiftCBOR Framework Embedding Complete ==="
    SCRIPT
    
    embed_framework_phase.shell_script = embed_script
    
    # Move the script phase to be the last phase
    app_target.build_phases.move(embed_framework_phase, app_target.build_phases.count - 1)
    puts "✅ Added SwiftCBOR framework embedding script phase to Runner target"
  end

  # --- Ensure Flutter module/headers are visible
  installer.pods_project.targets.each do |t|
    t.build_configurations.each do |cfg|
      # Framework search paths
      cfg.build_settings['FRAMEWORK_SEARCH_PATHS'] ||= ['$(inherited)']
      fsp = Array(cfg.build_settings['FRAMEWORK_SEARCH_PATHS'])
      fsp += [
        '$(PODS_CONFIGURATION_BUILD_DIR)/Flutter',
        File.join('${SRCROOT}', 'Flutter'),
        File.join('${SRCROOT}')
      ]
      cfg.build_settings['FRAMEWORK_SEARCH_PATHS'] = fsp.uniq

      # Header search paths
      cfg.build_settings['HEADER_SEARCH_PATHS'] ||= ['$(inherited)']
      hsp = Array(cfg.build_settings['HEADER_SEARCH_PATHS'])
      hsp += [
        '$(PODS_ROOT)/Headers/Public',
        '$(PODS_ROOT)/Headers/Public/Flutter',
        '$(PODS_CONFIGURATION_BUILD_DIR)/Flutter/Flutter.framework/Headers',
        File.join('${SRCROOT}', 'Flutter', 'Flutter.framework', 'Headers')
      ]
      cfg.build_settings['HEADER_SEARCH_PATHS'] = hsp.uniq

      cfg.build_settings['CLANG_ENABLE_MODULES'] = 'YES'
    end
  end
  
  puts "✅ Permanent privacy bundle and AWS Core bundle fix completed"
end
EOF

echo "✅ Created new Podfile with enhanced path handling"
echo ""
echo "The new Podfile includes:"
echo "1. Enhanced privacy bundle copy script with path handling"
echo "2. Special handling for url_launcher_ios and sqflite_darwin"
echo "3. Debug output to show build variables"
echo "4. Fallback creation of minimal privacy bundles"
echo ""
echo "Next steps:"
echo "1. Run 'cd ios && pod install' to apply the changes"
echo "2. Try building the iOS app again"
echo ""
echo "=== Podfile Path Fix Complete ==="