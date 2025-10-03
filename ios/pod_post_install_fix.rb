# CocoaPods post-install script to fix privacy bundle issues

post_install do |installer|
  puts "🔧 Running privacy bundle post-install fix..."
  
  # Get the project
  project = installer.pods_project
  
  # List of plugins that need privacy bundles
  privacy_plugins = [
    'url_launcher_ios',
    'sqflite_darwin',
    'image_picker_ios',
    'permission_handler_apple',
    'shared_preferences_foundation',
    'share_plus',
    'path_provider_foundation',
    'package_info_plus'
  ]
  
  # Add privacy bundle script phase to each plugin target
  project.targets.each do |target|
    if privacy_plugins.include?(target.name)
      puts "Adding privacy bundle script phase to #{target.name}"
      
      # Remove existing privacy script phases
      target.shell_script_build_phases.dup.each do |phase|
        if phase.name.to_s.downcase.include?('privacy')
          target.build_phases.delete(phase)
        end
      end
      
      # Add new privacy bundle script phase
      privacy_phase = target.new_shell_script_build_phase('[CP] Copy Privacy Bundle')
      privacy_phase.shell_path = '/bin/sh'
      privacy_phase.show_env_vars_in_log = false
      privacy_phase.shell_script = <<~SCRIPT
        set -e
        set -u
        set -o pipefail
        
        echo "=== Copying #{target.name} Privacy Bundle ==="
        
        SRCROOT="${SRCROOT}"
        BUILT_PRODUCTS_DIR="${BUILT_PRODUCTS_DIR}"
        FRAMEWORKS_FOLDER_PATH="${FRAMEWORKS_FOLDER_PATH}"
        
        PRIVACY_BUNDLE_SRC="${SRCROOT}/#{target.name}_privacy.bundle"
        PRIVACY_BUNDLE_DST="${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/#{target.name}_privacy.bundle"
        TARGET_DST="${BUILT_PRODUCTS_DIR}/#{target.name}/#{target.name}_privacy.bundle"
        
        if [ -d "${PRIVACY_BUNDLE_SRC}" ]; then
          echo "Copying privacy bundle from ${PRIVACY_BUNDLE_SRC}"
          
          # Copy to frameworks folder
          mkdir -p "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"
          cp -R "${PRIVACY_BUNDLE_SRC}" "${PRIVACY_BUNDLE_DST}"
          echo "✅ Copied to frameworks folder: ${PRIVACY_BUNDLE_DST}"
          
          # Copy to target-specific directory
          mkdir -p "${BUILT_PRODUCTS_DIR}/#{target.name}"
          cp -R "${PRIVACY_BUNDLE_SRC}" "${TARGET_DST}"
          echo "✅ Copied to target directory: ${TARGET_DST}"
          
          echo "✅ #{target.name} privacy bundle copied successfully"
        else
          echo "⚠️ Privacy bundle not found at ${PRIVACY_BUNDLE_SRC}"
          # Create minimal privacy bundle as fallback
          mkdir -p "${TARGET_DST}"
          cat > "${TARGET_DST}/#{target.name}_privacy" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
          echo "✅ Created minimal privacy bundle for #{target.name}"
        fi
      SCRIPT
      
      puts "✅ Added privacy bundle script phase for #{target.name}"
    end
  end
  
  puts "✅ Privacy bundle post-install fix complete"
end
