#!/bin/bash

# Fix URL Launcher iOS Privacy Bundle Issue
# This script ensures the url_launcher_ios_privacy.bundle is properly copied to the expected location

set -e
set -u
set -o pipefail

echo "=== Fixing URL Launcher iOS Privacy Bundle ==="

# Get the current directory (should be ios/)
IOS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$IOS_DIR")"

# Define the build directory pattern
BUILD_DIR_PATTERN="${IOS_DIR}/build/Debug-dev-iphonesimulator"

# Check if build directory exists
if [ ! -d "$BUILD_DIR_PATTERN" ]; then
    echo "Build directory not found: $BUILD_DIR_PATTERN"
    echo "This script should be run after a Flutter build attempt."
    exit 1
fi

# Source privacy bundle
SOURCE_BUNDLE="${IOS_DIR}/url_launcher_ios_privacy.bundle"
SOURCE_FILE="${SOURCE_BUNDLE}/url_launcher_ios_privacy"

# Expected destination
DEST_DIR="${BUILD_DIR_PATTERN}/url_launcher_ios/url_launcher_ios_privacy.bundle"
DEST_FILE="${DEST_DIR}/url_launcher_ios_privacy"

echo "Source bundle: $SOURCE_BUNDLE"
echo "Source file: $SOURCE_FILE"
echo "Destination directory: $DEST_DIR"
echo "Destination file: $DEST_FILE"

# Check if source exists
if [ ! -f "$SOURCE_FILE" ]; then
    echo "❌ Source privacy file not found: $SOURCE_FILE"
    exit 1
fi

# Create destination directory
mkdir -p "$DEST_DIR"

# Copy the privacy file
cp "$SOURCE_FILE" "$DEST_FILE"

# Verify the copy
if [ -f "$DEST_FILE" ]; then
    echo "✅ Successfully copied url_launcher_ios_privacy to: $DEST_FILE"
    
    # Show file contents for verification
    echo "Privacy bundle contents:"
    cat "$DEST_FILE"
else
    echo "❌ Failed to copy privacy file"
    exit 1
fi

# Also ensure the bundle directory structure is correct
# Some build systems expect the bundle to contain the privacy file directly
BUNDLE_ROOT="${BUILD_DIR_PATTERN}/url_launcher_ios_privacy.bundle"
mkdir -p "$BUNDLE_ROOT"
cp "$SOURCE_FILE" "${BUNDLE_ROOT}/url_launcher_ios_privacy"

echo "✅ Also copied to bundle root: ${BUNDLE_ROOT}/url_launcher_ios_privacy"

# Verify both locations
echo "Verifying both locations:"
if [ -f "$DEST_FILE" ]; then
    echo "✅ Nested location exists: $DEST_FILE"
else
    echo "❌ Nested location missing: $DEST_FILE"
fi

if [ -f "${BUNDLE_ROOT}/url_launcher_ios_privacy" ]; then
    echo "✅ Bundle root location exists: ${BUNDLE_ROOT}/url_launcher_ios_privacy"
else
    echo "❌ Bundle root location missing: ${BUNDLE_ROOT}/url_launcher_ios_privacy"
fi

echo "=== URL Launcher iOS Privacy Bundle Fix Complete ==="