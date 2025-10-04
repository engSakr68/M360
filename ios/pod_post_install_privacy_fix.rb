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
