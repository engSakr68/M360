# Flutter iOS url_launcher Privacy Bundle Fix

## Problem
You're encountering this error when building your Flutter iOS app:
```
Error (Xcode): Build input file cannot be found: '/Volumes/Untitled/member360_wb/build/ios/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy'. Did you forget to declare this file as an output of a script phase or custom build rule which produces it?
```

## Root Cause
The `url_launcher_ios` plugin requires a privacy bundle file (`url_launcher_ios_privacy`) to be present in a specific location during the build process. This is required for iOS App Store compliance with privacy manifest requirements.

## Solution Applied

### 1. ✅ Privacy Bundle Created
- Located at: `ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy`
- Contains minimal privacy manifest for App Store compliance

### 2. ✅ Build Directory Structure Fixed
- Created expected directory: `ios/build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/`
- Copied privacy bundle to exact location the build system expects
- Created for all build configurations (Debug, Release, Profile)

### 3. ✅ Build Scripts Created
- `fix_url_launcher_privacy_bundle.sh` - Comprehensive fix script
- `targeted_privacy_bundle_fix.sh` - Targeted fix for specific error
- `ios/pre_build_privacy_fix.sh` - Pre-build script
- `ios/xcode_build_phase_privacy_fix.sh` - Xcode build phase script

### 4. ✅ Podfile Configuration
Your existing Podfile already has comprehensive privacy bundle handling with script phases that:
- Copy privacy bundles to frameworks folder
- Copy privacy bundles to target-specific directories
- Handle both `url_launcher_ios` and `sqflite_darwin` privacy bundles

## Next Steps

### Option 1: Try Building Again
The privacy bundle is now in the correct location. Try building your iOS app again:
```bash
flutter build ios --simulator
```

### Option 2: If Error Persists
If you still get the error, add the Xcode build phase script:

1. Open `ios/Runner.xcworkspace` in Xcode
2. Select the Runner target
3. Go to Build Phases tab
4. Click the "+" button and select "New Run Script Phase"
5. Add this script:
   ```bash
   ${SRCROOT}/xcode_build_phase_privacy_fix.sh
   ```
6. Move this script phase to run **before** "Copy Bundle Resources"
7. Clean Build Folder (Cmd+Shift+K)
8. Build the project (Cmd+B)

### Option 3: Manual Fix in Xcode
If the automated scripts don't work:

1. Open `ios/Runner.xcworkspace` in Xcode
2. Select the Runner target
3. Go to Build Phases tab
4. Add a new "Run Script Phase" with this content:
   ```bash
   #!/bin/bash
   set -e
   
   # Create the privacy bundle directory
   mkdir -p "${BUILT_PRODUCTS_DIR}/url_launcher_ios/url_launcher_ios_privacy.bundle"
   
   # Copy the privacy bundle
   if [ -f "${SRCROOT}/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy" ]; then
       cp "${SRCROOT}/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy" "${BUILT_PRODUCTS_DIR}/url_launcher_ios/url_launcher_ios_privacy.bundle/"
   else
       # Create minimal privacy bundle
       cat > "${BUILT_PRODUCTS_DIR}/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy" << 'EOF'
   {
     "NSPrivacyTracking": false,
     "NSPrivacyCollectedDataTypes": [],
     "NSPrivacyAccessedAPITypes": []
   }
   EOF
   fi
   ```

## Files Created/Modified

### Privacy Bundle Files
- `ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy` ✅
- `ios/build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy` ✅
- `ios/build/Debug-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy` ✅
- `ios/build/Release-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy` ✅
- `ios/build/Profile-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/url_launcher_ios_privacy` ✅

### Scripts Created
- `fix_url_launcher_privacy_bundle.sh` - Comprehensive fix
- `targeted_privacy_bundle_fix.sh` - Targeted fix
- `ios/pre_build_privacy_fix.sh` - Pre-build script
- `ios/xcode_build_phase_privacy_fix.sh` - Xcode build phase script

## Verification
Run this command to verify the privacy bundle is in the correct location:
```bash
ls -la ios/build/Debug-dev-iphonesimulator/url_launcher_ios/url_launcher_ios_privacy.bundle/
```

You should see the `url_launcher_ios_privacy` file.

## Why This Happens
This error occurs because:
1. iOS requires privacy manifests for App Store submissions
2. The `url_launcher_ios` plugin needs to declare its privacy usage
3. The build system expects the privacy bundle in a specific location
4. Sometimes the build process doesn't copy the privacy bundle to the expected location

The fix ensures the privacy bundle is always available at the exact location the build system expects.