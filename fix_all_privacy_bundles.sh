#!/bin/bash

echo "🔧 Comprehensive Flutter iOS Privacy Bundle Fix"
echo "=============================================="

# List of plugins that need privacy bundles
PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
    "permission_handler_apple"
    "shared_preferences_foundation"
    "share_plus"
    "path_provider_foundation"
    "package_info_plus"
)

# Create iOS directory if it doesn't exist
mkdir -p ios

echo "📦 Creating privacy bundles for all plugins..."

for plugin in "${PLUGINS[@]}"; do
    echo "Creating privacy bundle for: $plugin"
    
    # Create the privacy bundle directory
    mkdir -p "ios/${plugin}_privacy.bundle"
    
    # Create the privacy manifest file
    cat > "ios/${plugin}_privacy.bundle/${plugin}_privacy" << 'EOF'
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

    echo "✅ Created privacy bundle for $plugin"
done

echo ""
echo "🔧 Creating build directory structure..."

# Create build directories for all configurations
CONFIGURATIONS=("Debug-dev-iphonesimulator" "Debug-iphonesimulator" "Release-iphonesimulator" "Profile-iphonesimulator")

for config in "${CONFIGURATIONS[@]}"; do
    echo "Creating build directory for: $config"
    
    for plugin in "${PLUGINS[@]}"; do
        mkdir -p "ios/build/${config}/${plugin}/${plugin}_privacy.bundle"
        
        # Copy privacy bundle to build directory
        if [ -f "ios/${plugin}_privacy.bundle/${plugin}_privacy" ]; then
            cp "ios/${plugin}_privacy.bundle/${plugin}_privacy" "ios/build/${config}/${plugin}/${plugin}_privacy.bundle/"
        fi
    done
done

echo ""
echo "🔧 Creating comprehensive Podfile script..."

# Create a comprehensive Podfile script
cat > ios/privacy_bundle_fix.rb << 'EOF'
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
EOF

echo ""
echo "🔧 Creating Xcode build phase script..."

# Create Xcode build phase script
cat > ios/xcode_privacy_bundle_fix.sh << 'EOF'
#!/bin/bash
set -e

echo "🔧 Running privacy bundle fix for iOS build..."

# List of plugins that need privacy bundles
PLUGINS=(
    "url_launcher_ios"
    "sqflite_darwin"
    "permission_handler_apple"
    "shared_preferences_foundation"
    "share_plus"
    "path_provider_foundation"
    "package_info_plus"
)

# Create privacy bundle directories and copy files
for plugin in "${PLUGINS[@]}"; do
    echo "Processing privacy bundle for: $plugin"
    
    # Create the privacy bundle directory
    mkdir -p "${BUILT_PRODUCTS_DIR}/${plugin}/${plugin}_privacy.bundle"
    
    # Copy privacy bundle if it exists
    if [ -f "${SRCROOT}/${plugin}_privacy.bundle/${plugin}_privacy" ]; then
        cp "${SRCROOT}/${plugin}_privacy.bundle/${plugin}_privacy" "${BUILT_PRODUCTS_DIR}/${plugin}/${plugin}_privacy.bundle/"
        echo "✅ Copied privacy bundle for $plugin"
    else
        # Create minimal privacy bundle
        cat > "${BUILT_PRODUCTS_DIR}/${plugin}/${plugin}_privacy.bundle/${plugin}_privacy" << 'PRIVACY_EOF'
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
PRIVACY_EOF
        echo "✅ Created privacy bundle for $plugin"
    fi
done

echo "✅ Privacy bundle fix completed"
EOF

chmod +x ios/xcode_privacy_bundle_fix.sh

echo ""
echo "✅ Privacy bundle fix completed!"
echo ""
echo "📋 Next steps:"
echo "1. Run: cd ios && pod install --repo-update"
echo "2. Add Xcode build phase script (see instructions below)"
echo "3. Run: flutter build ios --simulator"
echo ""
echo "🔧 To add Xcode build phase script:"
echo "1. Open ios/Runner.xcworkspace in Xcode"
echo "2. Select Runner target"
echo "3. Go to Build Phases tab"
echo "4. Add new 'Run Script Phase' BEFORE 'Copy Bundle Resources'"
echo "5. Add script: \${SRCROOT}/xcode_privacy_bundle_fix.sh"
echo "6. Clean Build Folder (Cmd+Shift+K)"
echo "7. Build project (Cmd+B)"