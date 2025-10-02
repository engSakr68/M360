
import 'package:flutter/services.dart';
import 'package:member360/core/helpers/di.dart';
import 'package:member360/core/helpers/user_helper_service.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:member360/features/base/domain/repositories/base_repository.dart';
import 'package:member360/features/base/presentation/pages/demo/openpath_bridge.dart';

class OpenpathService {
  static const _channel = MethodChannel('openpath');

  static Future<bool> _ensurePermissions() async {
    try {
      // First check current permission status
      final status = await _channel.invokeMethod<Map>('getPermissionStatus');
      final permissionStatus = Map<String, dynamic>.from(status ?? {});
      
      print('Current permission status: $permissionStatus');
      
      // If permissions are already granted, return true
      if (permissionStatus['baseOk'] == true) {
        return true;
      }
      
      // Request permissions if not granted
      final permissionsGranted = await _channel.invokeMethod<bool>('requestPermissions') ?? false;
      
      if (!permissionsGranted) {
        print('Permission request failed or denied');
        return false;
      }
      
      // Check status again after requesting permissions
      final newStatus = await _channel.invokeMethod<Map>('getPermissionStatus');
      final newPermissionStatus = Map<String, dynamic>.from(newStatus ?? {});
      
      print('Permission status after request: $newPermissionStatus');
      
      // If still not working, guide user to enable services
      if (newPermissionStatus['baseOk'] != true) {
        // Check if Bluetooth needs to be enabled
        if (newPermissionStatus['btOn'] != true) {
          print('Bluetooth not enabled, prompting user');
          await _channel.invokeMethod('promptEnableBluetooth');
        }
        
        // Check if Location needs to be enabled
        if (newPermissionStatus['locationOn'] != true) {
          print('Location not enabled, opening settings');
          await _channel.invokeMethod('openLocationSettings');
        }
        
        return false;
      }
      
      return true;
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
