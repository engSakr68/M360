import 'package:flutter/services.dart';

class OpenpathPlugin {
  static const _channel = MethodChannel('openpath_plugin');

  static Future<bool> provision(String token, {String? deviceToken}) async {
    final args = {
      'token': token.trim(),
      'deviceToken': deviceToken ?? "flutter-device",
    };
    return await _channel.invokeMethod<bool>('provision', args) ?? false;
  }

  static Future<bool> unprovision() async {
    return await _channel.invokeMethod<bool>('unprovision') ?? false;
  }

  static Future<String?> getUserOpal() async {
    return await _channel.invokeMethod<String?>('getUserOpal');
  }
}
