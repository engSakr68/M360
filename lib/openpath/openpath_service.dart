
import 'package:flutter/services.dart';
import 'package:member360/core/helpers/di.dart';
import 'package:member360/core/helpers/user_helper_service.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:member360/features/base/domain/repositories/base_repository.dart';
import 'package:member360/features/base/presentation/pages/demo/openpath_bridge.dart';
import 'package:permission_handler/permission_handler.dart';

class OpenpathService {
  static const _channel = MethodChannel('openpath');

  static Future<bool> _ensurePermissions() async {
    // Use the native plugin's permission handling instead of permission_handler
    // to avoid conflicts and ensure proper OpenPath SDK integration
    try {
      return await _channel.invokeMethod<bool>('requestPermissions') ?? false;
    } catch (e) {
      print('Failed to request permissions via native plugin: $e');
      return false;
    }
  }

  static Future<Map<String,dynamic>?> provision(String token) async {
    // Always check permissions first, regardless of which provision method we use
    if (!await _ensurePermissions()) {
      throw Exception('Permissions denied');
    }
    
    // Use the improved bridge for provisioning
    try {
      final success = await OpenpathBridge.provisionWhenReady(token);
      
      if (success) {
        return {'success': true, 'message': 'Provisioned successfully'};
      } else {
        throw Exception('Provision failed after retries');
      }
    } catch (e) {
      // Fallback to original method if bridge fails
      print('Bridge provisioning failed, using fallback: $e');
      final res = await _channel.invokeMethod<Map>('provision', {'token': token});
      return res?.cast<String,dynamic>();
    }
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
