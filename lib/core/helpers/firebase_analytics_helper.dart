import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseAnalyticsHelper {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> userLogin(String phone) async {
    await analytics.logEvent(
      name: 'user_login_click',
      parameters: {
        'user_phone': phone,
      },
    );
  }

  Future<void> userRegister(String name, String phone) async {
    await analytics.logEvent(
      name: 'user_register-click',
      parameters: {
        'user_name': name,
        "user_phone": phone,
      },
    );
  }

  Future<void> startAVideoCallEvent(String phone) async {
    await analytics.logEvent(
      name: 'forget_password_click',
      parameters: {
        'user_phone': phone,
      },
    );
  }
}
