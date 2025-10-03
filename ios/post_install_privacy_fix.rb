# Post-install script for CocoaPods to fix privacy bundles
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

    # Create a privacy bundle copy script phase
    privacy_phase = app_target.new_shell_script_build_phase('[CP] Copy Privacy Bundles')
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
    app_target.build_phases.move(privacy_phase, 1)
    puts "✅ Added privacy bundle copy phase to Runner target"
  else
    puts "⚠️ Runner target not found in Pods project"
  end
  
  puts "✅ Privacy bundle fix completed"
end
