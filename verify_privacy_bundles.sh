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
