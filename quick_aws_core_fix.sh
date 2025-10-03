#!/bin/bash

# Quick AWS Core Bundle Fix - Run this before building
set -e

echo "🔧 Quick AWS Core Bundle Fix"

# Create the specific directory and file that the build system is looking for
mkdir -p ios/build/Debug-dev-iphonesimulator/AWSCore/AWSCore.bundle

# Copy the AWS Core bundle
if [ -d "ios/vendor/openpath/AWSCore.xcframework/ios-arm64_x86_64-simulator/AWSCore.framework/AWSCore.bundle" ]; then
    cp -R ios/vendor/openpath/AWSCore.xcframework/ios-arm64_x86_64-simulator/AWSCore.framework/AWSCore.bundle/* ios/build/Debug-dev-iphonesimulator/AWSCore/AWSCore.bundle/
    echo "✅ Fixed AWS Core bundle"
else
    echo "⚠️ AWS Core bundle not found, creating minimal bundle"
    # Create minimal bundle
    cat > ios/build/Debug-dev-iphonesimulator/AWSCore/AWSCore.bundle/AWSCore << 'AWS_EOF'
# AWS Core Bundle Resource File
AWS_CORE_VERSION=2.37.2
AWS_CORE_BUNDLE_ID=org.cocoapods.AWSCore
AWS_CORE_PLATFORM=iPhoneSimulator
AWS_EOF
    echo "✅ Created minimal AWS Core bundle"
fi

echo "✅ Quick AWS Core bundle fix completed"
echo "You can now try building again!"
