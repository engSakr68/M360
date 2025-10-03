#!/bin/bash

# Privacy Bundle Verification Script
# This script verifies that all privacy bundles are properly structured

set -e
set -u

echo "🔍 Verifying privacy bundles..."

IOS_DIR="/workspace/ios"
BUILD_DIR="${IOS_DIR}/build"
CONFIGURATIONS=(
    "Debug-dev-iphonesimulator"
    "Debug-iphonesimulator" 
    "Release-iphoneos"
    "Release-iphonesimulator"
)

ALL_GOOD=true

for config in "${CONFIGURATIONS[@]}"; do
    config_build_dir="${BUILD_DIR}/${config}"
    url_launcher_dir="${config_build_dir}/url_launcher_ios"
    bundle_dir="${url_launcher_dir}/url_launcher_ios_privacy.bundle"
    privacy_file="${bundle_dir}/url_launcher_ios_privacy"
    
    if [ -f "${privacy_file}" ]; then
        echo "✅ ${config}: Privacy bundle exists"
    else
        echo "❌ ${config}: Privacy bundle missing"
        ALL_GOOD=false
    fi
done

if [ "$ALL_GOOD" = true ]; then
    echo "🎉 All privacy bundles are properly set up!"
    exit 0
else
    echo "❌ Some privacy bundles are missing!"
    exit 1
fi
