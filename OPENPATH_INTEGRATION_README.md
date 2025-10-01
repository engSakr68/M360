
# OpenPath SDK Integration (v0.5.0)

This project has been automatically patched to include Openpath Mobile SDK **v0.5.0** for both Android and iOS.

## Android
* AARs placed in `android/app/libs/`
* `build.gradle` updated (flatDir + dependencies, compileSdk 34, minSdk 26)
* Added runtime permissions and a `MethodChannel` inside `MainActivity.kt`.
* Permissions added to `AndroidManifest.xml`.

## iOS
* All XCFrameworks placed in `ios/OpenPathSDK`.
* Local podspec `OpenpathMobileLocal.podspec` created and referenced in `Podfile` (platform 15.0 + `use_frameworks!`).
* `Info.plist` updated with Bluetooth, Location descriptions, and background mode.
* `OpenpathBridge.swift` registers `openpath_bridge` MethodChannel.
* `AppDelegate.swift` calls `OpenpathBridge.register`.

## Flutter layer
* `lib/openpath/openpath_service.dart` – permission & method-channel wrapper.
* `lib/openpath/openpath_screen.dart` – a demo UI to provision/unprovision and display the credential.

### How to test
```bash
flutter pub get
# iOS
cd ios && pod install && cd ..
flutter run
```
On the UI, paste your **Setup Mobile Token** and press ‘Provision’.

### Notes
* Bluetooth LE scanning does not work on simulators/emulators – test on real devices.
* Location permission is set to *WhenInUse*. If your tenant requires *Always*, add `NSLocationAlwaysAndWhenInUseUsageDescription` to Info.plist.
