#!/bin/bash

# Final iOS Build Script with Complete Privacy Bundle Fix
set -e
set -u
set -o pipefail

echo "🚀 Final iOS Build with Complete Privacy Bundle Fix"
echo "=================================================="

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Change to project root
cd /workspace

# Step 1: Run pre-build privacy fix
print_status "Step 1: Running pre-build privacy fix..."
if [ -f "ios/pre_build_privacy_fix.sh" ]; then
    cd ios
    ./pre_build_privacy_fix.sh
    cd ..
    print_success "Pre-build privacy fix completed"
else
    print_warning "Pre-build script not found, skipping"
fi

# Step 2: Clean and get dependencies
print_status "Step 2: Getting Flutter dependencies..."
if command -v flutter >/dev/null 2>&1; then
    flutter clean
    flutter pub get
    print_success "Flutter dependencies updated"
else
    print_warning "Flutter not available, skipping pub get"
fi

# Step 3: Install CocoaPods dependencies
print_status "Step 3: Installing CocoaPods dependencies..."
cd ios
if command -v pod >/dev/null 2>&1; then
    pod install --repo-update
    print_success "CocoaPods dependencies installed"
else
    print_warning "CocoaPods not available, skipping pod install"
fi
cd ..

# Step 4: Build for iOS simulator
print_status "Step 4: Building for iOS simulator..."
if command -v flutter >/dev/null 2>&1; then
    flutter build ios --simulator --debug --flavor dev
    print_success "iOS build completed successfully"
else
    print_warning "Flutter not available, build script ready for manual execution"
    print_status "To build manually, run: flutter build ios --simulator --debug --flavor dev"
fi

echo "✅ Final build process completed!"
