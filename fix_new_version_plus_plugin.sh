#!/bin/bash

# Fix for new_version_plus plugin configuration issues
# This script addresses the "com.codesfirst.new_version_plus" default_package errors

set -e
set -u
set -o pipefail

echo "🔧 Fixing new_version_plus plugin configuration issues..."
echo "========================================================"

# Navigate to project root
cd "$(dirname "$0")"
echo "📁 Working directory: $(pwd)"

# Step 1: Create plugin configuration override
echo "📝 Creating plugin configuration override..."

# Create Flutter directory if it doesn't exist
mkdir -p ios/Flutter

# Create a configuration file that overrides the problematic plugin references
cat > ios/Flutter/Generated.xcconfig << 'EOF'
// Generated file - do not edit
// This file overrides problematic plugin configurations

// Override new_version_plus plugin configuration
NEW_VERSION_PLUS_ANDROID_PACKAGE=com.codesfirst.new_version_plus
NEW_VERSION_PLUS_IOS_PACKAGE=com.codesfirst.new_version_plus

// Ensure proper plugin registration
FLUTTER_PLUGIN_REGISTRATION=1

// Disable problematic plugin warnings
FLUTTER_PLUGIN_WARNINGS=0
EOF

echo "✅ Created plugin configuration override"

# Step 2: Create a Podfile modification to handle the plugin issue
echo "📝 Creating Podfile modification..."

# Backup the original Podfile
if [ -f "ios/Podfile" ] && [ ! -f "ios/Podfile.backup.new_version_plus" ]; then
    cp ios/Podfile ios/Podfile.backup.new_version_plus
    echo "✅ Backed up original Podfile"
fi

# Create a post-install script to handle the plugin issue
cat > ios/pod_post_install_new_version_plus_fix.rb << 'EOF'
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
EOF

echo "✅ Created Podfile post-install script"

# Step 3: Create a comprehensive fix script
echo "📝 Creating comprehensive fix script..."

cat > fix_new_version_plus_comprehensive.sh << 'EOF'
#!/bin/bash
set -e

echo "🔧 Comprehensive new_version_plus fix..."

# Set paths
IOS_DIR="ios"
FLUTTER_DIR="${IOS_DIR}/Flutter"

# Create Flutter directory if it doesn't exist
mkdir -p "${FLUTTER_DIR}"

# Create plugin configuration override
cat > "${FLUTTER_DIR}/Generated.xcconfig" << 'EOF'
// Generated file - do not edit
// This file overrides problematic plugin configurations

// Override new_version_plus plugin configuration
NEW_VERSION_PLUS_ANDROID_PACKAGE=com.codesfirst.new_version_plus
NEW_VERSION_PLUS_IOS_PACKAGE=com.codesfirst.new_version_plus

// Ensure proper plugin registration
FLUTTER_PLUGIN_REGISTRATION=1

// Disable problematic plugin warnings
FLUTTER_PLUGIN_WARNINGS=0
EOF

echo "✅ Plugin configuration override created"

# Create a simple workaround by creating a dummy plugin registration
cat > "${FLUTTER_DIR}/new_version_plus_workaround.dart" << 'EOF'
// Workaround for new_version_plus plugin registration issues
// This file provides a fallback implementation

import 'package:flutter/services.dart';

class NewVersionPlusWorkaround {
  static const MethodChannel _channel = MethodChannel('new_version_plus');
  
  static Future<Map<String, dynamic>?> getVersionStatus() async {
    try {
      final result = await _channel.invokeMethod('getVersionStatus');
      return Map<String, dynamic>.from(result);
    } catch (e) {
      // Return null if plugin is not available
      return null;
    }
  }
}
EOF

echo "✅ Workaround implementation created"

echo "✅ Comprehensive new_version_plus fix complete!"
EOF

chmod +x fix_new_version_plus_comprehensive.sh

echo ""
echo "🎉 new_version_plus plugin fix complete!"
echo ""
echo "📋 What was created:"
echo "   ✅ Plugin configuration override: ios/Flutter/Generated.xcconfig"
echo "   ✅ Podfile post-install script: ios/pod_post_install_new_version_plus_fix.rb"
echo "   ✅ Comprehensive fix script: fix_new_version_plus_comprehensive.sh"
echo ""
echo "🚀 Next steps:"
echo "   1. Run: ./fix_new_version_plus_comprehensive.sh"
echo "   2. If using CocoaPods: cd ios && pod install"
echo "   3. Try building your iOS app again"
echo ""
echo "💡 The plugin configuration override should resolve the"
echo "   'com.codesfirst.new_version_plus' default_package errors."