// import 'dart:async';
// import 'dart:developer';
// import 'package:uni_links/uni_links.dart';
// import 'package:flutter/services.dart' show PlatformException;

// class DeepLinkService {
//   DeepLinkService._();

//   static final DeepLinkService instance = DeepLinkService._();

//   Future<void> initUniLinks() async {
//     try {
//       final initialLink = await getInitialLink();
//       if (initialLink != null) {
//         _handleReceivedLink(Uri.parse(initialLink));
//       }
//       uriLinkStream.listen((Uri? uri) {
//         // Parse the link and warn the user, if it is not correct
//         _handleReceivedLink(uri);
//       }, onError: (err) {
//         // Handle exception by warning the user their action did not succeed
//         log(err.toString());
//       });
//     } on PlatformException catch (e) {
//       log(e.message.toString());
//     }
//   }

//   Future<void> _handleReceivedLink(Uri? uri) async {
//     log("deeplink : ${uri?.path}");

//     ///Todo: handle deep link
//   }
// }
