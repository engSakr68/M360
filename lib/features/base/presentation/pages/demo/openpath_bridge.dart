import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

/// =========================
/// Event model
/// =========================
class OpenpathEvent {
  final String event;
  final dynamic data;

  OpenpathEvent({required this.event, this.data});

  factory OpenpathEvent.fromJson(Map<String, dynamic> json) {
    return OpenpathEvent(
      event: json['event'] ?? 'unknown',
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event': event,
      'data': _encodeForJson(data),
    };
  }

  static dynamic _encodeForJson(dynamic value) {
    if (value == null || value is num || value is bool || value is String) {
      return value;
    }
    if (value is Map) {
      return value.map((key, v) => MapEntry(key.toString(), _encodeForJson(v)));
    }
    if (value is Iterable) {
      return value.map(_encodeForJson).toList();
    }
    try {
      final dynamic maybeToJson = (value as dynamic).toJson;
      if (maybeToJson is Function) {
        return maybeToJson();
      }
    } catch (_) {}
    return value.toString();
  }

  @override
  String toString() => 'OpenpathEvent(event: $event, data: $data)';
}

/// =========================
/// Provision status model
/// =========================
class ProvisionStatus {
  final bool isProvisioned;
  final String? userOpal;
  final List<String> userOpals;
  final List<String> availableMethods;
  final bool hasProvisionMethod;
  final bool hasUnprovisionMethod;
  final bool hasGetUserOpalMethod;
  final String? error;

  ProvisionStatus({
    required this.isProvisioned,
    this.userOpal,
    this.userOpals = const [],
    this.availableMethods = const [],
    this.hasProvisionMethod = false,
    this.hasUnprovisionMethod = false,
    this.hasGetUserOpalMethod = false,
    this.error,
  });

  Map<String, dynamic> toJson() {
    return {
      'isProvisioned': isProvisioned,
      'userOpal': userOpal,
      'userOpals': userOpals,
      'availableMethods': availableMethods,
      'hasProvisionMethod': hasProvisionMethod,
      'hasUnprovisionMethod': hasUnprovisionMethod,
      'hasGetUserOpalMethod': hasGetUserOpalMethod,
      'error': error,
    };
  }

  @override
  String toString() => toJson().toString();
}

/// =========================
/// Bridge
/// =========================
class OpenpathBridge {
  OpenpathBridge._(); // Private constructor
  static final OpenpathBridge instance = OpenpathBridge._(); // Singleton instance

  static const _method = MethodChannel('openpath');
  static const _events = EventChannel('openpath_events');

  // 🔹 Raw events as Map
  static Stream<Map<String, dynamic>> get _rawEvents =>
      _events.receiveBroadcastStream().map((e) {
        if (e is String) {
          try {
            return json.decode(e) as Map<String, dynamic>;
          } catch (_) {
            return <String, dynamic>{'raw': e};
          }
        } else if (e is Map) {
          return Map<String, dynamic>.from(e);
        }
        return <String, dynamic>{'unknown': e.toString()};
      });

  // 🔹 Typed events
  static Stream<OpenpathEvent> get events =>
      _rawEvents.map((m) => OpenpathEvent.fromJson(m));

  // ----- Permissions / toggles -----
  /// ✅ dummy permissions always return ok because v0.5.0 SDK doesn’t handle them
  static Future<bool> requestPermissions() async {
    try {
      return await _method.invokeMethod<bool>('requestPermissions') ?? true;
    } catch (_) {
      return true;
    }
  }

  static Future<Map<String, dynamic>> getPermissionStatus() async {
    try {
      return Map<String, dynamic>.from(
        await _method.invokeMethod('getPermissionStatus'),
      );
    } catch (_) {
      // fallback dummy data
      return {
        'btOn': true,
        'locationOn': true,
        'notificationsOn': true,
        'baseOk': true,
        'bgOk': true,
      };
    }
  }

  static Future<void> promptEnableBluetooth() async {
    try {
      await _method.invokeMethod('promptEnableBluetooth');
    } catch (_) {}
  }

  static Future<void> openLocationSettings() async {
    try {
      await _method.invokeMethod('openLocationSettings');
    } catch (_) {}
  }

  // ----- Provisioning -----
  static String? extractOpalFromJwt(String jwt) {
    try {
      final parts = jwt.split('.');
      if (parts.length != 3) return null;
      String b64 = parts[1].replaceAll('-', '+').replaceAll('_', '/');
      while (b64.length % 4 != 0) {
        b64 += '=';
      }
      final payload =
          json.decode(utf8.decode(base64.decode(b64))) as Map<String, dynamic>;
      return payload['userOpal'] as String?;
    } catch (_) {
      return null;
    }
  }

  static Future<bool> provisionWhenReady(
    String jwt, {
    String? opal,
    String? deviceToken,
  }) async {
    final args = <String, dynamic>{
      'jwt': jwt.trim(),
      'opal': opal ?? extractOpalFromJwt(jwt),
      'deviceToken': deviceToken ?? "flutter-test-device",
    };

    // Ensure the SDK foreground service is started before provisioning
    await initialize();
    await Future.delayed(const Duration(milliseconds: 400));

    const backoff = <Duration>[
      Duration(milliseconds: 300),
      Duration(milliseconds: 600),
      Duration(milliseconds: 900),
      Duration(milliseconds: 1300),
      Duration(milliseconds: 2000),
    ];

    for (int i = 0; i < backoff.length; i++) {
      try {
        print("Provision args: $args");
        final ok = await _method.invokeMethod<bool>('provision', args) ?? false;
        if (ok) return true;
      } catch (e) {
        print('Provision attempt $i failed: $e');
      }
      await Future.delayed(backoff[i]);
    }
    return false;
  }

  static Future<bool> unprovision(String opal) async {
    try {
      return await _method.invokeMethod<bool>('unprovision', {'opal': opal}) ??
          false;
    } catch (_) {
      return false;
    }
  }

  // ----- Status Checking -----
  static Future<List<String>> getAvailableMethods() async {
    try {
      final methods =
          await _method.invokeMethod<List<dynamic>>('getAvailableMethods');
      return methods?.map((e) => e.toString()).toList() ?? [];
    } catch (_) {
      return [];
    }
  }

  static Future<String?> getUserOpal() async {
    try {
      return await _method.invokeMethod<String?>('getUserOpal');
    } catch (_) {
      return null;
    }
  }

  static Future<ProvisionStatus> checkProvisionStatus() async {
    try {
      final userOpal = await getUserOpal();
      final methods = await getAvailableMethods();

      return ProvisionStatus(
        isProvisioned: userOpal != null && userOpal.isNotEmpty,
        userOpal: userOpal,
        userOpals: [],
        availableMethods: methods,
        hasProvisionMethod: methods.contains('provision'),
        hasUnprovisionMethod: methods.contains('unprovision'),
        hasGetUserOpalMethod: methods.contains('getUserOpal'),
      );
    } catch (e) {
      return ProvisionStatus(
        isProvisioned: false,
        userOpal: null,
        userOpals: [],
        availableMethods: [],
        error: e.toString(),
      );
    }
  }

  // Add `initialize` method here to initialize the SDK
  static Future<bool> initialize() async {
    try {
      final result = await _method.invokeMethod('initialize');
      return result ?? false;
    } catch (_) {
      return false;
    }
  }
}
