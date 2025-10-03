#!/bin/bash

set -e
set -u
set -o pipefail

echo "=== Pre-Build Privacy Bundle Fix ==="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Get the project root (assuming this script is in ios/)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IOS_DIR="${PROJECT_ROOT}/ios"

print_status "Project root: ${PROJECT_ROOT}"
print_status "iOS directory: ${IOS_DIR}"

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

# Ensure all privacy bundles exist and are properly formatted
for plugin in "${PRIVACY_PLUGINS[@]}"; do
    BUNDLE_DIR="${IOS_DIR}/${plugin}_privacy.bundle"
    BUNDLE_FILE="${BUNDLE_DIR}/${plugin}_privacy"
    
    print_status "Processing privacy bundle for: ${plugin}"
    
    # Create bundle directory if it doesn't exist
    if [ ! -d "${BUNDLE_DIR}" ]; then
        print_warning "Creating privacy bundle directory for ${plugin}..."
        mkdir -p "${BUNDLE_DIR}"
    fi
    
    # Create privacy manifest if it doesn't exist
    if [ ! -f "${BUNDLE_FILE}" ]; then
        print_warning "Creating privacy manifest for ${plugin}..."
        cat > "${BUNDLE_FILE}" << EOF
{
  "NSPrivacyTracking": false,
  "NSPrivacyCollectedDataTypes": [],
  "NSPrivacyAccessedAPITypes": []
}
EOF
        print_status "Created privacy manifest for ${plugin}"
    else
        print_status "Privacy manifest for ${plugin} already exists"
    fi
    
    # Verify the file is valid JSON
    if command -v python3 >/dev/null 2>&1; then
        if python3 -m json.tool "${BUNDLE_FILE}" >/dev/null 2>&1; then
            print_status "Privacy manifest for ${plugin} is valid JSON"
        else
            print_error "Privacy manifest for ${plugin} is not valid JSON"
            exit 1
        fi
    fi
done

print_status "All privacy bundles are ready for build"

# If we're in a build context, also copy to the expected build location
if [ -n "${BUILT_PRODUCTS_DIR:-}" ] && [ -n "${CONFIGURATION:-}" ]; then
    print_status "Build context detected, copying privacy bundles to build directory..."
    
    for plugin in "${PRIVACY_PLUGINS[@]}"; do
        BUNDLE_SRC="${IOS_DIR}/${plugin}_privacy.bundle"
        BUNDLE_DST="${BUILT_PRODUCTS_DIR}/${plugin}/${plugin}_privacy.bundle"
        
        if [ -d "${BUNDLE_SRC}" ]; then
            mkdir -p "$(dirname "${BUNDLE_DST}")"
            cp -R "${BUNDLE_SRC}" "${BUNDLE_DST}"
            print_status "Copied ${plugin} privacy bundle to build directory"
        else
            print_error "Source privacy bundle not found: ${BUNDLE_SRC}"
            exit 1
        fi
    done
fi

print_status "Pre-build privacy bundle fix completed successfully!"