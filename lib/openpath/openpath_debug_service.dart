import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:member360/features/base/presentation/pages/demo/openpath_bridge.dart';

/// Comprehensive debugging service for OpenPath SDK
class OpenpathDebugService {
  static const _channel = MethodChannel('openpath');
  
  /// Detailed SDK status information
  static Future<Map<String, dynamic>> getDetailedStatus() async {
    final status = <String, dynamic>{};
    
    try {
      // 1. Permission Status
      final permissions = await OpenpathBridge.getPermissionStatus();
      status['permissions'] = permissions;
      
      // 2. Provision Status
      final provisionStatus = await OpenpathBridge.checkProvisionStatus();
      status['provision'] = provisionStatus.toJson();
      
      // 3. Available Methods
      final methods = await OpenpathBridge.getAvailableMethods();
      status['availableMethods'] = methods;
      
      // 4. User OPAL
      final userOpal = await OpenpathBridge.getUserOpal();
      status['userOpal'] = userOpal;
      
      // 5. Service Status (Android specific)
      try {
        final serviceStatus = await _channel.invokeMethod<Map>('getServiceStatus');
        status['serviceStatus'] = serviceStatus;
      } catch (e) {
        status['serviceStatus'] = {'error': e.toString()};
      }
      
      // 6. SDK Version Info
      try {
        final versionInfo = await _channel.invokeMethod<Map>('getSDKVersion');
        status['sdkVersion'] = versionInfo;
      } catch (e) {
        status['sdkVersion'] = {'error': 'Version info not available'};
      }
      
      // 7. Bluetooth Status
      try {
        final bluetoothStatus = await _channel.invokeMethod<Map>('getBluetoothStatus');
        status['bluetoothStatus'] = bluetoothStatus;
      } catch (e) {
        status['bluetoothStatus'] = {'error': e.toString()};
      }
      
      // 8. Location Status
      try {
        final locationStatus = await _channel.invokeMethod<Map>('getLocationStatus');
        status['locationStatus'] = locationStatus;
      } catch (e) {
        status['locationStatus'] = {'error': e.toString()};
      }
      
    } catch (e) {
      status['error'] = e.toString();
    }
    
    status['timestamp'] = DateTime.now().toIso8601String();
    return status;
  }
  
  /// Test SDK core functionality
  static Future<Map<String, dynamic>> runSDKTests() async {
    final results = <String, dynamic>{};
    
    print('🔍 Starting OpenPath SDK Tests...');
    
    // Test 1: Permission Check
    try {
      final permissions = await OpenpathBridge.getPermissionStatus();
      results['permissionTest'] = {
        'passed': permissions['baseOk'] == true,
        'details': permissions,
      };
      print('✅ Permission Test: ${results['permissionTest']['passed'] ? 'PASSED' : 'FAILED'}');
    } catch (e) {
      results['permissionTest'] = {'passed': false, 'error': e.toString()};
      print('❌ Permission Test: FAILED - $e');
    }
    
    // Test 2: Service Initialization
    try {
      final initResult = await OpenpathBridge.initialize();
      results['initializationTest'] = {
        'passed': initResult,
        'details': 'SDK initialization returned: $initResult',
      };
      print('✅ Initialization Test: ${initResult ? 'PASSED' : 'FAILED'}');
    } catch (e) {
      results['initializationTest'] = {'passed': false, 'error': e.toString()};
      print('❌ Initialization Test: FAILED - $e');
    }
    
    // Test 3: Method Availability
    try {
      final methods = await OpenpathBridge.getAvailableMethods();
      final requiredMethods = ['provision', 'unprovision', 'getUserOpal'];
      final hasAllMethods = requiredMethods.every((method) => methods.contains(method));
      
      results['methodAvailabilityTest'] = {
        'passed': hasAllMethods,
        'availableMethods': methods,
        'requiredMethods': requiredMethods,
        'missingMethods': requiredMethods.where((m) => !methods.contains(m)).toList(),
      };
      print('✅ Method Availability Test: ${hasAllMethods ? 'PASSED' : 'FAILED'}');
      if (!hasAllMethods) {
        print('   Missing methods: ${results['methodAvailabilityTest']['missingMethods']}');
      }
    } catch (e) {
      results['methodAvailabilityTest'] = {'passed': false, 'error': e.toString()};
      print('❌ Method Availability Test: FAILED - $e');
    }
    
    // Test 4: Service Binding (Android)
    try {
      final serviceStatus = await _channel.invokeMethod<Map>('getServiceStatus');
      final isServiceBound = serviceStatus?['isBound'] == true;
      final isServiceRunning = serviceStatus?['isRunning'] == true;
      
      results['serviceBindingTest'] = {
        'passed': isServiceBound && isServiceRunning,
        'details': serviceStatus,
      };
      print('✅ Service Binding Test: ${results['serviceBindingTest']['passed'] ? 'PASSED' : 'FAILED'}');
      if (!results['serviceBindingTest']['passed']) {
        print('   Service bound: $isServiceBound, Service running: $isServiceRunning');
      }
    } catch (e) {
      results['serviceBindingTest'] = {'passed': false, 'error': e.toString()};
      print('❌ Service Binding Test: FAILED - $e');
    }
    
    // Test 5: Bluetooth Scanning Capability
    try {
      final bluetoothTest = await _channel.invokeMethod<bool>('testBluetoothScanning');
      results['bluetoothScanTest'] = {
        'passed': bluetoothTest == true,
        'details': 'Bluetooth scanning capability: $bluetoothTest',
      };
      print('✅ Bluetooth Scan Test: ${bluetoothTest == true ? 'PASSED' : 'FAILED'}');
    } catch (e) {
      results['bluetoothScanTest'] = {'passed': false, 'error': e.toString()};
      print('❌ Bluetooth Scan Test: FAILED - $e');
    }
    
    // Test 6: Event Stream
    try {
      final streamTest = await _testEventStream();
      results['eventStreamTest'] = streamTest;
      print('✅ Event Stream Test: ${streamTest['passed'] ? 'PASSED' : 'FAILED'}');
    } catch (e) {
      results['eventStreamTest'] = {'passed': false, 'error': e.toString()};
      print('❌ Event Stream Test: FAILED - $e');
    }
    
    // Overall SDK Health Score
    final passedTests = results.values.where((test) => test['passed'] == true).length;
    final totalTests = results.length;
    final healthScore = (passedTests / totalTests * 100).round();
    
    results['summary'] = {
      'totalTests': totalTests,
      'passedTests': passedTests,
      'failedTests': totalTests - passedTests,
      'healthScore': healthScore,
      'overallStatus': healthScore >= 80 ? 'HEALTHY' : healthScore >= 60 ? 'DEGRADED' : 'CRITICAL',
    };
    
    print('📊 SDK Health Score: $healthScore% (${results['summary']['overallStatus']})');
    print('🔍 OpenPath SDK Tests Complete\n');
    
    return results;
  }
  
  /// Test event stream functionality
  static Future<Map<String, dynamic>> _testEventStream() async {
    try {
      final completer = Completer<Map<String, dynamic>>();
      StreamSubscription? subscription;
      
      // Set a timeout for the test
      Timer(const Duration(seconds: 5), () {
        if (!completer.isCompleted) {
          subscription?.cancel();
          completer.complete({
            'passed': false,
            'error': 'Event stream test timed out',
          });
        }
      });
      
      subscription = OpenpathBridge.events.listen(
        (event) {
          if (!completer.isCompleted) {
            subscription?.cancel();
            completer.complete({
              'passed': true,
              'details': 'Event stream is working, received: ${event.event}',
            });
          }
        },
        onError: (error) {
          if (!completer.isCompleted) {
            subscription?.cancel();
            completer.complete({
              'passed': false,
              'error': 'Event stream error: $error',
            });
          }
        },
      );
      
      // Trigger a test event
      try {
        await _channel.invokeMethod('triggerTestEvent');
      } catch (e) {
        // If we can't trigger a test event, just check if stream is listening
        await Future.delayed(const Duration(seconds: 2));
        if (!completer.isCompleted) {
          subscription?.cancel();
          completer.complete({
            'passed': true,
            'details': 'Event stream is listening (no test event triggered)',
          });
        }
      }
      
      return await completer.future;
    } catch (e) {
      return {
        'passed': false,
        'error': e.toString(),
      };
    }
  }
  
  /// Monitor SDK status continuously
  static Stream<Map<String, dynamic>> monitorSDKStatus({
    Duration interval = const Duration(seconds: 30),
  }) async* {
    while (true) {
      try {
        final status = await getDetailedStatus();
        yield status;
      } catch (e) {
        yield {
          'error': e.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        };
      }
      await Future.delayed(interval);
    }
  }
  
  /// Generate a comprehensive SDK report
  static Future<String> generateSDKReport() async {
    final buffer = StringBuffer();
    
    buffer.writeln('=== OpenPath SDK Debug Report ===');
    buffer.writeln('Generated: ${DateTime.now().toIso8601String()}');
    buffer.writeln();
    
    // Detailed Status
    buffer.writeln('--- Detailed Status ---');
    final status = await getDetailedStatus();
    buffer.writeln(const JsonEncoder.withIndent('  ').convert(status));
    buffer.writeln();
    
    // Test Results
    buffer.writeln('--- SDK Tests ---');
    final testResults = await runSDKTests();
    buffer.writeln(const JsonEncoder.withIndent('  ').convert(testResults));
    buffer.writeln();
    
    // Recommendations
    buffer.writeln('--- Recommendations ---');
    final recommendations = _generateRecommendations(status, testResults);
    for (final rec in recommendations) {
      buffer.writeln('• $rec');
    }
    
    return buffer.toString();
  }
  
  /// Generate recommendations based on status and test results
  static List<String> _generateRecommendations(
    Map<String, dynamic> status,
    Map<String, dynamic> testResults,
  ) {
    final recommendations = <String>[];
    
    // Check permissions
    final permissions = status['permissions'] as Map<String, dynamic>?;
    if (permissions?['baseOk'] != true) {
      recommendations.add('Grant all required permissions (Bluetooth, Location, Notifications)');
    }
    
    // Check service binding
    final serviceTest = testResults['serviceBindingTest'] as Map<String, dynamic>?;
    if (serviceTest?['passed'] != true) {
      recommendations.add('Fix service binding issues - restart app or check native implementation');
    }
    
    // Check method availability
    final methodTest = testResults['methodAvailabilityTest'] as Map<String, dynamic>?;
    if (methodTest?['passed'] != true) {
      recommendations.add('Ensure all required SDK methods are properly implemented');
    }
    
    // Check provisioning
    final provision = status['provision'] as Map<String, dynamic>?;
    if (provision?['isProvisioned'] != true) {
      recommendations.add('Complete SDK provisioning with a valid JWT token');
    }
    
    // Check Bluetooth
    final bluetoothTest = testResults['bluetoothScanTest'] as Map<String, dynamic>?;
    if (bluetoothTest?['passed'] != true) {
      recommendations.add('Verify Bluetooth is enabled and scanning permissions are granted');
    }
    
    // Overall health
    final summary = testResults['summary'] as Map<String, dynamic>?;
    final healthScore = summary?['healthScore'] as int? ?? 0;
    if (healthScore < 80) {
      recommendations.add('SDK health is below optimal - address failing tests');
    }
    
    if (recommendations.isEmpty) {
      recommendations.add('SDK appears to be functioning correctly');
    }
    
    return recommendations;
  }
  
  /// Log SDK events with detailed information
  static void logEvent(String event, [dynamic data]) {
    final timestamp = DateTime.now().toIso8601String();
    print('[$timestamp] OpenPath SDK: $event');
    if (data != null) {
      print('  Data: ${jsonEncode(data)}');
    }
  }
}