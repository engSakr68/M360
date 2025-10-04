#!/bin/bash

# iOS Build Script with Privacy Bundle Fix
# This script ensures privacy bundles are ready before building iOS

set -e
set -u
set -o pipefail

echo "=== iOS Build with Privacy Bundle Fix ==="

# Run the privacy bundle preparation script
echo "Preparing privacy bundles..."
/workspace/prepare_privacy_bundles.sh

echo "Privacy bundles prepared successfully!"
echo "You can now run your iOS build command."
echo ""
echo "Example commands:"
echo "  flutter build ios --simulator"
echo "  flutter build ios --release"
echo "  flutter run -d ios"
echo ""
echo "The privacy bundle files are now available in the build directory."