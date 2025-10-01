import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:member360/core/helpers/di.dart';
import 'package:member360/core/helpers/global_context.dart';
import 'package:member360/core/helpers/storage_helper.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GlobalNotification {
  static final StreamController<Map<String, dynamic>>
      _onMessageStreamController = StreamController.broadcast();

  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> setupNotification() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const android = AndroidInitializationSettings("@mipmap/launcher_icon");
    const ios = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: android, iOS: ios);
    _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      // onDidReceiveBackgroundNotificationResponse:(details)=> flutterNotificationClick( details.payload),
      // onDidReceiveNotificationResponse: (details)=> flutterNotificationClick( details.payload),
    );
    await Firebase.initializeApp();

    final settings = await messaging.requestPermission(
        provisional: true, sound: true, badge: true, alert: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      messaging.getToken().then((token) {
        log("token ===> $token");
      });
      messaging.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log("_____________________Message data:${message.data}");
        log("_____________________notification:${message.notification?.title}");
        if (Platform.isAndroid) {
          _showLocalNotification(message);
        }
        updateNotifyCubit();
        _onMessageStreamController.add(message.data);
        if (int.parse(message.data["type"] ?? "0") == -1) {
          StorageHelper.instance.clearSavedData();
          // AutoRouter.of(context).push(const LoginRoute());
        }
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        log('AonMessageOpenedApp event was published!');
        flutterNotificationClick(json.encode(message.data));
      });
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    log("Handling a background message: ${message.messageId}");
    await Firebase.initializeApp();
    // flutterNotificationClick(json.encode(message.data));
  }

  StreamController<Map<String, dynamic>> get notificationSubject {
    return _onMessageStreamController;
  }

  void updateNotifyCubit() {
    var context = getIt<GlobalContext>().context();
    // context.read<NotifyCubit>().increaseNotifyCount();
  }

  Future<void> _showLocalNotification(RemoteMessage? message) async {
    if (message == null) return;
    final android = AndroidNotificationDetails(
      "${DateTime.now().millisecondsSinceEpoch}",
      "Default",
      priority: Priority.high,
      importance: Importance.max,
      // shortcutId: DateTime.now().toIso8601String(),
    );
    const ios = DarwinNotificationDetails(
      presentSound: true,
      presentAlert: true,
    );
    final platform = NotificationDetails(android: android, iOS: ios);
    _flutterLocalNotificationsPlugin.show(
        DateTime.now().microsecond,
        "${message.notification?.title}",
        "${message.notification?.body}",
        platform,
        payload: json.encode(message.data));
    print("==========> ${message.notification?.title}");
  }

  static Future flutterNotificationClick(String? details) async {
    // final _data = json.decode("$payload");
    var context = getIt<GlobalContext>().context();
    // AutoRouter.of(context).push(const NoticesScreenRoute());
  }
}
