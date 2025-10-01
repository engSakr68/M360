
import 'package:flutter/services.dart';
import 'package:member360/core/helpers/di.dart';
import 'package:member360/core/helpers/user_helper_service.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:member360/features/base/domain/repositories/base_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class OpenpathService {
  static const _channel = MethodChannel('openpath_bridge');

  static Future<bool> _ensurePermissions() async {
    if (await Permission.bluetooth.isGranted &&
        await Permission.bluetoothScan.isGranted &&
        await Permission.bluetoothConnect.isGranted) return true;
    final statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
      Permission.notification,
    ].request();
    return statuses.values.every((s) => s.isGranted);
  }

  static Future<Map<String,dynamic>?> provision(String token) async {
    if (!await _ensurePermissions()) {
      throw Exception('Permissions denied');
    }
    final res = await _channel.invokeMethod<Map>('provision', {'token': token});
    return res?.cast<String,dynamic>();
  }

  static Future<void> unprovision() {
    return _channel.invokeMethod('unprovision');
  }

  static Future<bool> generateOP() async {
    var opResponse = await getIt<BaseRepository>().generateOP(true);
    return _handleOPResponse(opResponse);
  }

 static bool _handleOPResponse(MyResult<String> response) {
    return response.when(isSuccess: (token) {
      UserHelperService.instance.saveOPData(token!);
      provision(token);
      return true;
    }, isError: (error) {
      return false;
    });
  }
}
