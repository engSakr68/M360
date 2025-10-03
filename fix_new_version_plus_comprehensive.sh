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
