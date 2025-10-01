// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'openpath_bridge.dart';

// class OpPrereqGuard {
//   /// Ensure BLE + (when required) Location are ON for local/nearby unlocks.
//   /// Returns true if all good; otherwise shows dialog/toast and returns false.
//   static Future<bool> ensureForLocalUnlock(BuildContext context, {bool toastIfBlocked = true}) async {
//     final st = await OpenpathBridge.instance.getTransportStatuses();
//     final int sdk = (st['sdk'] as int?) ?? 0;
//     final bool bleOn = st['bleOn'] == true;

//     // On Android < 31, Location toggle is required for BLE scanning.
//     final bool needsLocation = Platform.isAndroid && sdk < 31;
//     final bool locationOn = st['locationOn'] == true;

//     final bool ok = bleOn && (!needsLocation || locationOn);
//     if (ok) return true;

//     if (toastIfBlocked) {
//       await OpenpathBridge.instance.showToast(
//         _explain(bleOn: bleOn, needsLocation: needsLocation, locationOn: locationOn),
//       );
//     }
//     if (!context.mounted) return false;

//     await showDialog<void>(
//       context: context,
//       builder: (ctx) {
//         return AlertDialog(
//           title: const Text('Enable required services'),
//           content: Text(_explain(bleOn: bleOn, needsLocation: needsLocation, locationOn: locationOn)),
//           actions: [
//             if (!bleOn)
//               TextButton(
//                 onPressed: () {
//                   OpenpathBridge.instance.openBluetoothSettings();
//                   Navigator.of(ctx).pop();
//                 },
//                 child: const Text('Bluetooth settings'),
//               ),
//             if (needsLocation && !locationOn)
//               TextButton(
//                 onPressed: () {
//                   OpenpathBridge.instance.openLocationSettings();
//                   Navigator.of(ctx).pop();
//                 },
//                 child: const Text('Location settings'),
//               ),
//             TextButton(
//               onPressed: () => Navigator.of(ctx).pop(),
//               child: const Text('Close'),
//             ),
//           ],
//         );
//       },
//     );

//     return false;
//   }

//   static String _explain({
//     required bool bleOn,
//     required bool needsLocation,
//     required bool locationOn,
//   }) {
//     if (!bleOn && needsLocation && !locationOn) {
//       return 'To use your Openpath mobile credential nearby, turn ON Bluetooth and Location.';
//     }
//     if (!bleOn) return 'Turn ON Bluetooth to use your Openpath mobile credential nearby.';
//     if (needsLocation && !locationOn) {
//       return 'Android requires Location to be ON for Bluetooth scanning on this device. Please enable Location.';
//     }
//     return 'Bluetooth/Location requirements not met.';
//   }
// }
