# Additional privacy bundle fix for post_install
def fix_privacy_bundles(installer)
  puts "🔧 Additional Privacy Bundle Fix"
  
  # Get the Runner target
  app_target = installer.pods_project.targets.find { |t| t.name == 'Runner' }
  
  if app_target
    # Create a script phase to copy privacy bundles before build
    privacy_phase = app_target.new_shell_script_build_phase('[CP] Pre-Build Privacy Bundle Copy')
    privacy_phase.shell_path = '/bin/sh'
    privacy_phase.show_env_vars_in_log = false
    privacy_phase.shell_script = <<~SCRIPT
      set -e
      set -u
      set -o pipefail
      
      echo "=== Pre-Build Privacy Bundle Copy ==="
      
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
      
      # Ensure privacy bundles are copied to build directory
      for plugin in "${PRIVACY_PLUGINS[@]}"; do
        BUNDLE_SRC="${SRCROOT}/${plugin}_privacy.bundle"
        BUNDLE_DST="${BUILT_PRODUCTS_DIR}/${plugin}/${plugin}_privacy.bundle"
        
        if [ -d "${BUNDLE_SRC}" ]; then
          mkdir -p "${BUILT_PRODUCTS_DIR}/${plugin}"
          cp -R "${BUNDLE_SRC}" "${BUNDLE_DST}"
          echo "✅ Copied privacy bundle for: $plugin"
        else
          echo "⚠️ Privacy bundle not found: ${BUNDLE_SRC}"
          # Create minimal privacy bundle
          mkdir -p "${BUNDLE_DST}"
          cat > "${BUNDLE_DST}/${plugin}_privacy" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
          echo "✅ Created minimal privacy bundle for: $plugin"
        fi
      done
      
      echo "=== Pre-Build Privacy Bundle Copy Complete ==="
    SCRIPT
    
    # Move this phase to be early in the build process
    app_target.build_phases.move(privacy_phase, 0)
    puts "✅ Added pre-build privacy bundle copy phase"
  end
end
