#!/bin/bash

# AWS Core Bundle Copy Script
set -e

echo "🔧 Copying AWS Core Bundle to Build Directory"

# Create build directories
mkdir -p build/Debug-dev-iphonesimulator/AWSCore
mkdir -p build/Release-iphoneos/AWSCore

# Source paths
AWS_CORE_SIMULATOR_SRC="vendor/openpath/AWSCore.xcframework/ios-arm64_x86_64-simulator/AWSCore.framework/AWSCore.bundle"
AWS_CORE_DEVICE_SRC="vendor/openpath/AWSCore.xcframework/ios-arm64/AWSCore.framework/AWSCore.bundle"

# Copy to simulator build directory
if [ -d "$AWS_CORE_SIMULATOR_SRC" ]; then
    cp -R "$AWS_CORE_SIMULATOR_SRC" "build/Debug-dev-iphonesimulator/AWSCore/"
    echo "✅ Copied AWS Core bundle to simulator build directory"
else
    echo "⚠️ AWS Core simulator bundle not found: $AWS_CORE_SIMULATOR_SRC"
fi

# Copy to device build directory
if [ -d "$AWS_CORE_DEVICE_SRC" ]; then
    cp -R "$AWS_CORE_DEVICE_SRC" "build/Release-iphoneos/AWSCore/"
    echo "✅ Copied AWS Core bundle to device build directory"
else
    echo "⚠️ AWS Core device bundle not found: $AWS_CORE_DEVICE_SRC"
fi

echo "✅ AWS Core bundle copy completed"
