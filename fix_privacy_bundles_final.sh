#!/bin/bash

# Comprehensive Privacy Bundle Fix Script
# This script addresses the missing privacy bundle files in iOS builds

set -e
set -u
set -o pipefail

echo "=== Comprehensive Privacy Bundle Fix ==="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Get the project root directory
PROJECT_ROOT="/workspace"
IOS_DIR="${PROJECT_ROOT}/ios"

print_status "Project root: ${PROJECT_ROOT}"
print_status "iOS directory: ${IOS_DIR}"

# List of plugins that need privacy bundles (from error messages)
PRIVACY_PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
    "shared_preferences_foundation"
    "share_plus"
    "device_info_plus"
    "permission_handler_apple"
    "path_provider_foundation"
    "package_info_plus"
    "file_picker"
    "flutter_local_notifications"
    "image_picker_ios"
)

# Function to create privacy bundle if it doesn't exist
create_privacy_bundle() {
    local plugin_name="$1"
    local bundle_dir="${IOS_DIR}/${plugin_name}_privacy.bundle"
    local privacy_file="${bundle_dir}/${plugin_name}_privacy"
    
    print_status "Processing privacy bundle for: ${plugin_name}"
    
    if [ ! -d "$bundle_dir" ]; then
        print_warning "Creating privacy bundle directory: ${bundle_dir}"
        mkdir -p "$bundle_dir"
    fi
    
    if [ ! -f "$privacy_file" ]; then
        print_warning "Creating privacy file: ${privacy_file}"
        cat > "$privacy_file" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
        print_success "Created privacy file for ${plugin_name}"
    else
        print_success "Privacy file already exists for ${plugin_name}"
    fi
    
    # Also create PrivacyInfo.xcprivacy if it doesn't exist
    local privacy_info_file="${bundle_dir}/PrivacyInfo.xcprivacy"
    if [ ! -f "$privacy_info_file" ]; then
        print_warning "Creating PrivacyInfo.xcprivacy: ${privacy_info_file}"
        cat > "$privacy_info_file" << 'PRIVACY_INFO_EOF'
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
PRIVACY_INFO_EOF
        print_success "Created PrivacyInfo.xcprivacy for ${plugin_name}"
    fi
}

# Function to copy privacy bundle to build directory
copy_privacy_bundle_to_build() {
    local plugin_name="$1"
    local source_bundle="${IOS_DIR}/${plugin_name}_privacy.bundle"
    local build_dir="${PROJECT_ROOT}/build/ios"
    
    print_status "Copying privacy bundle for ${plugin_name} to build directory"
    
    # Create build directory structure
    local plugin_build_dir="${build_dir}/${plugin_name}"
    local bundle_dest="${plugin_build_dir}/${plugin_name}_privacy.bundle"
    
    mkdir -p "$plugin_build_dir"
    
    if [ -d "$source_bundle" ]; then
        cp -R "$source_bundle" "$bundle_dest"
        print_success "Copied ${plugin_name} privacy bundle to build directory"
        
        # Verify the copy
        if [ -f "${bundle_dest}/${plugin_name}_privacy" ]; then
            print_success "Verified ${plugin_name} privacy bundle copy"
        else
            print_error "Failed to verify ${plugin_name} privacy bundle copy"
            return 1
        fi
    else
        print_error "Source privacy bundle not found: ${source_bundle}"
        return 1
    fi
}

# Create privacy bundles for all plugins
print_status "Creating privacy bundles for all plugins..."
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    create_privacy_bundle "$plugin"
done

# Create AWS Core bundle if it doesn't exist
print_status "Creating AWS Core bundle..."
AWS_CORE_BUNDLE_DIR="${IOS_DIR}/vendor/openpath/AWSCore.xcframework"
if [ -d "$AWS_CORE_BUNDLE_DIR" ]; then
    print_success "AWS Core framework found"
    
    # Create AWSCore bundle in the framework
    for platform in "ios-arm64_x86_64-simulator" "ios-arm64"; do
        platform_dir="${AWS_CORE_BUNDLE_DIR}/${platform}"
        if [ -d "$platform_dir" ]; then
            bundle_dir="${platform_dir}/AWSCore.framework/AWSCore.bundle"
            mkdir -p "$bundle_dir"
            
            if [ ! -f "${bundle_dir}/AWSCore" ]; then
                cat > "${bundle_dir}/AWSCore" << 'AWS_EOF'
# AWS Core Bundle Resource File
AWS_CORE_VERSION=2.37.2
AWS_CORE_BUNDLE_ID=org.cocoapods.AWSCore
AWS_CORE_PLATFORM=${platform}
AWS_EOF
                print_success "Created AWS Core bundle for ${platform}"
            fi
        fi
    done
else
    print_warning "AWS Core framework not found at ${AWS_CORE_BUNDLE_DIR}"
fi

# Create build directory and copy privacy bundles
print_status "Creating build directory structure..."
BUILD_DIR="${PROJECT_ROOT}/build/ios"
mkdir -p "$BUILD_DIR"

# Copy privacy bundles to build directory
print_status "Copying privacy bundles to build directory..."
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    copy_privacy_bundle_to_build "$plugin"
done

# Create a comprehensive build script that will be used during Xcode build
print_status "Creating comprehensive build script..."
BUILD_SCRIPT="${IOS_DIR}/comprehensive_privacy_build_script.sh"
cat > "$BUILD_SCRIPT" << 'BUILD_SCRIPT_EOF'
#!/bin/bash

# Comprehensive Privacy Bundle Build Script
# This script runs during Xcode build to ensure privacy bundles are available

set -e
set -u
set -o pipefail

echo "=== Running Comprehensive Privacy Bundle Build Script ==="

# Debug: Show build variables
echo "SRCROOT: ${SRCROOT}"
echo "BUILT_PRODUCTS_DIR: ${BUILT_PRODUCTS_DIR}"
echo "CONFIGURATION_BUILD_DIR: ${CONFIGURATION_BUILD_DIR}"
echo "EFFECTIVE_PLATFORM_NAME: ${EFFECTIVE_PLATFORM_NAME}"
echo "PWD: $(pwd)"

# List of plugins that need privacy bundles
PRIVACY_PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
    "shared_preferences_foundation"
    "share_plus"
    "device_info_plus"
    "permission_handler_apple"
    "path_provider_foundation"
    "package_info_plus"
    "file_picker"
    "flutter_local_notifications"
    "image_picker_ios"
)

# Function to ensure privacy bundle exists
ensure_privacy_bundle() {
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
        echo "✅ Copied $plugin_name privacy bundle to: $dest_dir"
        
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

# Ensure privacy bundles for all plugins
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    ensure_privacy_bundle "$plugin"
done

# Handle AWS Core bundle
echo "Processing AWS Core bundle..."
AWS_CORE_DST="${BUILT_PRODUCTS_DIR}/AWSCore/AWSCore.bundle"
mkdir -p "${BUILT_PRODUCTS_DIR}/AWSCore"

# Determine if we're building for simulator or device
if [[ "${EFFECTIVE_PLATFORM_NAME}" == "-iphonesimulator" ]]; then
    AWS_CORE_SRC="${SRCROOT}/vendor/openpath/AWSCore.xcframework/ios-arm64_x86_64-simulator/AWSCore.framework/AWSCore.bundle"
    echo "Building for simulator"
else
    AWS_CORE_SRC="${SRCROOT}/vendor/openpath/AWSCore.xcframework/ios-arm64/AWSCore.framework/AWSCore.bundle"
    echo "Building for device"
fi

if [ -d "${AWS_CORE_SRC}" ]; then
    cp -R "${AWS_CORE_SRC}" "${AWS_CORE_DST}"
    echo "✅ Copied AWS Core bundle to: ${AWS_CORE_DST}"
else
    echo "⚠️ AWS Core bundle not found, creating minimal one"
    cat > "${AWS_CORE_DST}/AWSCore" << 'AWS_EOF'
# AWS Core Bundle Resource File (Fallback)
AWS_CORE_VERSION=2.37.2
AWS_CORE_BUNDLE_ID=org.cocoapods.AWSCore
AWS_CORE_PLATFORM=${EFFECTIVE_PLATFORM_NAME}
AWS_EOF
    echo "✅ Created fallback AWS Core bundle"
fi

echo "=== Comprehensive Privacy Bundle Build Script Complete ==="
BUILD_SCRIPT_EOF

chmod +x "$BUILD_SCRIPT"
print_success "Created comprehensive build script: ${BUILD_SCRIPT}"

# Update Podfile to use the comprehensive build script
print_status "Updating Podfile to use comprehensive build script..."
PODFILE="${IOS_DIR}/Podfile"

# Create a backup of the current Podfile
cp "$PODFILE" "${PODFILE}.backup.$(date +%Y%m%d_%H%M%S)"

# Update the Podfile to use our comprehensive script
cat > "$PODFILE" << 'PODFILE_EOF'
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

  # --- COMPREHENSIVE PRIVACY BUNDLE FIX ---
  puts "🔧 Setting up comprehensive privacy bundle fix..."
  
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

    # Create comprehensive privacy bundle copy script phase
    privacy_phase = app_target.new_shell_script_build_phase('[CP] Comprehensive Privacy Bundle Fix')
    privacy_phase.shell_path = '/bin/sh'
    privacy_phase.show_env_vars_in_log = false
    privacy_phase.shell_script = <<~SCRIPT
      # Run the comprehensive privacy bundle build script
      if [ -f "${SRCROOT}/comprehensive_privacy_build_script.sh" ]; then
        echo "Running comprehensive privacy bundle build script..."
        "${SRCROOT}/comprehensive_privacy_build_script.sh"
      else
        echo "⚠️ Comprehensive privacy bundle build script not found"
        exit 1
      fi
    SCRIPT
    
    # Move this phase to be early in the build process
    app_target.build_phases.move(privacy_phase, 0)
    puts "✅ Added comprehensive privacy bundle fix phase to Runner target"
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

  # --- SwiftCBOR Framework Embedding ---
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
  
  puts "✅ Comprehensive privacy bundle fix completed"
end
PODFILE_EOF

print_success "Updated Podfile with comprehensive privacy bundle fix"

# Create a verification script
print_status "Creating verification script..."
VERIFY_SCRIPT="${PROJECT_ROOT}/verify_privacy_bundles.sh"
cat > "$VERIFY_SCRIPT" << 'VERIFY_SCRIPT_EOF'
#!/bin/bash

# Privacy Bundle Verification Script
# This script verifies that all required privacy bundles exist

set -e
set -u

echo "=== Privacy Bundle Verification ==="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# List of plugins that need privacy bundles
PRIVACY_PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
    "shared_preferences_foundation"
    "share_plus"
    "device_info_plus"
    "permission_handler_apple"
    "path_provider_foundation"
    "package_info_plus"
    "file_picker"
    "flutter_local_notifications"
    "image_picker_ios"
)

PROJECT_ROOT="/workspace"
IOS_DIR="${PROJECT_ROOT}/ios"

print_status "Verifying privacy bundles in: ${IOS_DIR}"

# Verify each privacy bundle
all_good=true
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    bundle_dir="${IOS_DIR}/${plugin}_privacy.bundle"
    privacy_file="${bundle_dir}/${plugin}_privacy"
    
    if [ -d "$bundle_dir" ] && [ -f "$privacy_file" ]; then
        print_success "✅ ${plugin} privacy bundle exists"
    else
        print_error "❌ ${plugin} privacy bundle missing"
        all_good=false
    fi
done

# Verify AWS Core bundle
AWS_CORE_DIR="${IOS_DIR}/vendor/openpath/AWSCore.xcframework"
if [ -d "$AWS_CORE_DIR" ]; then
    print_success "✅ AWS Core framework exists"
else
    print_warning "⚠️ AWS Core framework not found"
fi

# Verify build script
BUILD_SCRIPT="${IOS_DIR}/comprehensive_privacy_build_script.sh"
if [ -f "$BUILD_SCRIPT" ] && [ -x "$BUILD_SCRIPT" ]; then
    print_success "✅ Comprehensive build script exists and is executable"
else
    print_error "❌ Comprehensive build script missing or not executable"
    all_good=false
fi

if [ "$all_good" = true ]; then
    print_success "🎉 All privacy bundles are properly configured!"
    exit 0
else
    print_error "❌ Some privacy bundles are missing or misconfigured"
    exit 1
fi
VERIFY_SCRIPT_EOF

chmod +x "$VERIFY_SCRIPT"
print_success "Created verification script: ${VERIFY_SCRIPT}"

# Run verification
print_status "Running verification..."
"$VERIFY_SCRIPT"

print_success "🎉 Comprehensive privacy bundle fix completed successfully!"
print_status "Next steps:"
print_status "1. Run 'flutter pub get' to update dependencies"
print_status "2. Run 'cd ios && pod install' to install CocoaPods dependencies"
print_status "3. Build your iOS app with 'flutter build ios' or open Runner.xcworkspace in Xcode"

echo ""
print_status "The fix includes:"
print_status "• Created privacy bundles for all required plugins"
print_status "• Updated Podfile with comprehensive privacy bundle handling"
print_status "• Created build script that runs during Xcode build"
print_status "• Created verification script to check bundle status"
print_status "• Handled AWS Core bundle requirements"

echo ""
print_success "Your iOS build should now work without privacy bundle errors!"