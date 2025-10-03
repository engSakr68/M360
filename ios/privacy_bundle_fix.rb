# Privacy Bundle Fix for Flutter iOS
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    
    # Add privacy bundle copy script for all plugins
    privacy_plugins = [
      'url_launcher_ios',
      'sqflite_darwin', 
      'permission_handler_apple',
      'shared_preferences_foundation',
      'share_plus',
      'path_provider_foundation',
      'package_info_plus'
    ]
    
    privacy_plugins.each do |plugin|
      if target.name == plugin
        target.build_phases.each do |phase|
          if phase.is_a?(Xcodeproj::Project::Object::PBXShellScriptBuildPhase)
            if phase.name == 'Copy Privacy Bundles'
              phase.shell_script = <<~SCRIPT
                #!/bin/bash
                set -e
                
                # Create privacy bundle directory
                mkdir -p "${BUILT_PRODUCTS_DIR}/${plugin}/${plugin}_privacy.bundle"
                
                # Copy privacy bundle if it exists
                if [ -f "${SRCROOT}/${plugin}_privacy.bundle/${plugin}_privacy" ]; then
                    cp "${SRCROOT}/${plugin}_privacy.bundle/${plugin}_privacy" "${BUILT_PRODUCTS_DIR}/${plugin}/${plugin}_privacy.bundle/"
                else
                    # Create minimal privacy bundle
                    cat > "${BUILT_PRODUCTS_DIR}/${plugin}/${plugin}_privacy.bundle/${plugin}_privacy" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
                fi
              SCRIPT
              break
            end
          end
        end
      end
    end
  end
end
