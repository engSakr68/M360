#!/bin/bash

set -e
set -u
set -o pipefail

echo "=== Privacy Bundle Verification ==="

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

# Navigate to project root
cd /workspace

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

echo "Checking privacy bundles in ios/ directory..."

ALL_GOOD=true

for plugin in "${PRIVACY_PLUGINS[@]}"; do
    BUNDLE_DIR="ios/${plugin}_privacy.bundle"
    BUNDLE_FILE="${BUNDLE_DIR}/${plugin}_privacy"
    
    if [ -d "${BUNDLE_DIR}" ]; then
        if [ -f "${BUNDLE_FILE}" ]; then
            # Check if it's valid JSON
            if command -v python3 >/dev/null 2>&1; then
                if python3 -m json.tool "${BUNDLE_FILE}" >/dev/null 2>&1; then
                    print_status "${plugin} privacy bundle exists and is valid JSON"
                else
                    print_error "${plugin} privacy bundle exists but is not valid JSON"
                    ALL_GOOD=false
                fi
            else
                print_status "${plugin} privacy bundle exists"
            fi
        else
            print_error "${plugin} privacy bundle directory exists but manifest file is missing"
            ALL_GOOD=false
        fi
    else
        print_error "${plugin} privacy bundle directory is missing"
        ALL_GOOD=false
    fi
done

echo ""
echo "=== Podfile Check ==="

if [ -f "ios/Podfile" ]; then
    if grep -q "Pre-Build Privacy Bundle Fix" ios/Podfile; then
        print_status "Podfile contains pre-build privacy fix"
    else
        print_warning "Podfile may not contain pre-build privacy fix"
    fi
    
    if grep -q "Copy Privacy Bundles" ios/Podfile; then
        print_status "Podfile contains privacy bundle copy script"
    else
        print_warning "Podfile may not contain privacy bundle copy script"
    fi
else
    print_error "Podfile not found"
    ALL_GOOD=false
fi

echo ""
echo "=== Summary ==="

if [ "$ALL_GOOD" = true ]; then
    print_status "All privacy bundles are properly configured!"
    echo ""
    echo "Next steps:"
    echo "1. Run 'cd ios && pod install' to apply the Podfile changes"
    echo "2. Build your iOS app - the privacy bundle errors should be resolved"
else
    print_error "Some privacy bundles are missing or invalid"
    echo ""
    echo "Run the comprehensive fix script:"
    echo "./fix_privacy_bundles_comprehensive.sh"
fi