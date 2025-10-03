# Post-install script to fix new_version_plus plugin issues
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    
    # Fix for new_version_plus plugin configuration
    if target.name == 'new_version_plus'
      target.build_configurations.each do |config|
        config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = 'com.codesfirst.new_version_plus'
        config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)']
        config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] << 'NEW_VERSION_PLUS_PLUGIN=1'
      end
    end
  end
end
