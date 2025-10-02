import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member360/core/constants/gaps.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';
import 'package:member360/core/widgets/app_button.dart';
import 'package:member360/core/widgets/default_app_bar.dart';
import 'openpath_debug_service.dart';

class OpenpathDebugScreen extends StatefulWidget {
  const OpenpathDebugScreen({super.key});

  @override
  State<OpenpathDebugScreen> createState() => _OpenpathDebugScreenState();
}

class _OpenpathDebugScreenState extends State<OpenpathDebugScreen> {
  Map<String, dynamic>? _detailedStatus;
  Map<String, dynamic>? _testResults;
  String _logs = '';
  bool _isRunningTests = false;
  bool _isGeneratingReport = false;
  StreamSubscription? _monitoringSubscription;
  bool _isMonitoring = false;
  
  final ScrollController _logController = ScrollController();

  @override
  void initState() {
    super.initState();
    _refreshStatus();
  }

  @override
  void dispose() {
    _monitoringSubscription?.cancel();
    _logController.dispose();
    super.dispose();
  }

  void _addLog(String message) {
    setState(() {
      final timestamp = DateTime.now().toIso8601String().substring(11, 19);
      _logs += '[$timestamp] $message\n';
    });
    _autoScrollLog();
  }

  void _autoScrollLog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_logController.hasClients) {
        _logController.jumpTo(_logController.position.maxScrollExtent);
      }
    });
  }

  Future<void> _refreshStatus() async {
    _addLog('Refreshing SDK status...');
    try {
      final status = await OpenpathDebugService.getDetailedStatus();
      setState(() {
        _detailedStatus = status;
      });
      _addLog('✅ Status refreshed successfully');
    } catch (e) {
      _addLog('❌ Failed to refresh status: $e');
    }
  }

  Future<void> _runTests() async {
    if (_isRunningTests) return;
    
    setState(() {
      _isRunningTests = true;
    });
    
    _addLog('🔍 Starting comprehensive SDK tests...');
    
    try {
      final results = await OpenpathDebugService.runSDKTests();
      setState(() {
        _testResults = results;
      });
      
      final summary = results['summary'] as Map<String, dynamic>?;
      if (summary != null) {
        _addLog('📊 Tests completed: ${summary['passedTests']}/${summary['totalTests']} passed');
        _addLog('🏥 Health Score: ${summary['healthScore']}% (${summary['overallStatus']})');
      }
    } catch (e) {
      _addLog('❌ Test execution failed: $e');
    } finally {
      setState(() {
        _isRunningTests = false;
      });
    }
  }

  Future<void> _generateReport() async {
    if (_isGeneratingReport) return;
    
    setState(() {
      _isGeneratingReport = true;
    });
    
    _addLog('📋 Generating comprehensive SDK report...');
    
    try {
      final report = await OpenpathDebugService.generateSDKReport();
      
      // Show report in a dialog
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('OpenPath SDK Report'),
            content: SizedBox(
              width: double.maxFinite,
              height: 400.h,
              child: SingleChildScrollView(
                child: Text(
                  report,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      }
      
      _addLog('✅ Report generated successfully');
    } catch (e) {
      _addLog('❌ Report generation failed: $e');
    } finally {
      setState(() {
        _isGeneratingReport = false;
      });
    }
  }

  void _toggleMonitoring() {
    if (_isMonitoring) {
      _monitoringSubscription?.cancel();
      _monitoringSubscription = null;
      setState(() {
        _isMonitoring = false;
      });
      _addLog('🔍 Stopped continuous monitoring');
    } else {
      _monitoringSubscription = OpenpathDebugService.monitorSDKStatus(
        interval: const Duration(seconds: 30),
      ).listen(
        (status) {
          setState(() {
            _detailedStatus = status;
          });
          _addLog('📊 Status updated via monitoring');
        },
        onError: (error) {
          _addLog('❌ Monitoring error: $error');
        },
      );
      setState(() {
        _isMonitoring = true;
      });
      _addLog('🔍 Started continuous monitoring (30s intervals)');
    }
  }

  void _clearLogs() {
    setState(() {
      _logs = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'OpenPath SDK Debug',
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Control buttons
            Row(
              children: [
                Expanded(
                  child: AppTextButton.maxCustom(
                    onPressed: _refreshStatus,
                    text: 'Refresh Status',
                    bgColor: context.colors.primary,
                    txtColor: context.colors.white,
                    textSize: 12.sp,
                    maxHeight: 40.h,
                  ),
                ),
                Gaps.hGap8,
                Expanded(
                  child: AppTextButton.maxCustom(
                    onPressed: _isRunningTests ? null : _runTests,
                    text: _isRunningTests ? 'Testing...' : 'Run Tests',
                    bgColor: context.colors.secondary,
                    txtColor: context.colors.white,
                    textSize: 12.sp,
                    maxHeight: 40.h,
                  ),
                ),
              ],
            ),
            Gaps.vGap8,
            Row(
              children: [
                Expanded(
                  child: AppTextButton.maxCustom(
                    onPressed: _isGeneratingReport ? null : _generateReport,
                    text: _isGeneratingReport ? 'Generating...' : 'Generate Report',
                    bgColor: Colors.green,
                    txtColor: context.colors.white,
                    textSize: 12.sp,
                    maxHeight: 40.h,
                  ),
                ),
                Gaps.hGap8,
                Expanded(
                  child: AppTextButton.maxCustom(
                    onPressed: _toggleMonitoring,
                    text: _isMonitoring ? 'Stop Monitor' : 'Start Monitor',
                    bgColor: _isMonitoring ? Colors.orange : Colors.blue,
                    txtColor: context.colors.white,
                    textSize: 12.sp,
                    maxHeight: 40.h,
                  ),
                ),
              ],
            ),
            Gaps.vGap16,

            // Status cards
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Overall Health Card
                    if (_testResults != null) _buildHealthCard(),
                    
                    Gaps.vGap16,
                    
                    // Permission Status Card
                    if (_detailedStatus?['permissions'] != null)
                      _buildPermissionCard(),
                    
                    Gaps.vGap16,
                    
                    // Service Status Card
                    if (_detailedStatus?['serviceStatus'] != null)
                      _buildServiceCard(),
                    
                    Gaps.vGap16,
                    
                    // Test Results Card
                    if (_testResults != null) _buildTestResultsCard(),
                    
                    Gaps.vGap16,
                    
                    // Logs Card
                    _buildLogsCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthCard() {
    final summary = _testResults!['summary'] as Map<String, dynamic>;
    final healthScore = summary['healthScore'] as int;
    final status = summary['overallStatus'] as String;
    
    Color statusColor;
    IconData statusIcon;
    
    switch (status) {
      case 'HEALTHY':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'DEGRADED':
        statusColor = Colors.orange;
        statusIcon = Icons.warning;
        break;
      case 'CRITICAL':
        statusColor = Colors.red;
        statusIcon = Icons.error;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help;
    }
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(statusIcon, color: statusColor, size: 24),
                Gaps.hGap8,
                Text(
                  'SDK Health: $healthScore%',
                  style: AppTextStyle.s16_w700(color: context.colors.black),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: AppTextStyle.s12_w600(color: Colors.white),
                  ),
                ),
              ],
            ),
            Gaps.vGap8,
            LinearProgressIndicator(
              value: healthScore / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
            ),
            Gaps.vGap8,
            Text(
              'Tests: ${summary['passedTests']}/${summary['totalTests']} passed',
              style: AppTextStyle.s14_w400(color: context.colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionCard() {
    final permissions = _detailedStatus!['permissions'] as Map<String, dynamic>;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Permissions',
              style: AppTextStyle.s16_w700(color: context.colors.black),
            ),
            Gaps.vGap8,
            _buildStatusRow('Bluetooth', permissions['btOn'] == true),
            _buildStatusRow('Location', permissions['locationOn'] == true),
            _buildStatusRow('Notifications', permissions['notificationsOn'] == true),
            _buildStatusRow('Overall OK', permissions['baseOk'] == true),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard() {
    final serviceStatus = _detailedStatus!['serviceStatus'] as Map<String, dynamic>;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Service Status',
              style: AppTextStyle.s16_w700(color: context.colors.black),
            ),
            Gaps.vGap8,
            _buildStatusRow('Service Running', serviceStatus['isRunning'] == true),
            _buildStatusRow('Service Bound', serviceStatus['isBound'] == true),
            _buildStatusRow('Has Instance', serviceStatus['hasServiceInstance'] == true),
            if (serviceStatus['error'] != null)
              Text(
                'Error: ${serviceStatus['error']}',
                style: AppTextStyle.s12_w400(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestResultsCard() {
    final tests = Map<String, dynamic>.from(_testResults!)
      ..remove('summary');
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Test Results',
              style: AppTextStyle.s16_w700(color: context.colors.black),
            ),
            Gaps.vGap8,
            ...tests.entries.map((entry) {
              final testName = entry.key.replaceAll('Test', '').replaceAll(RegExp(r'([A-Z])'), ' \$1').trim();
              final testData = entry.value as Map<String, dynamic>;
              final passed = testData['passed'] == true;
              
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Icon(
                      passed ? Icons.check_circle : Icons.cancel,
                      color: passed ? Colors.green : Colors.red,
                      size: 16,
                    ),
                    Gaps.hGap8,
                    Expanded(
                      child: Text(
                        testName,
                        style: AppTextStyle.s14_w400(color: context.colors.black),
                      ),
                    ),
                    if (testData['error'] != null)
                      Icon(Icons.info_outline, color: Colors.orange, size: 16),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Debug Logs',
                  style: AppTextStyle.s16_w700(color: context.colors.black),
                ),
                const Spacer(),
                TextButton(
                  onPressed: _clearLogs,
                  child: Text(
                    'Clear',
                    style: AppTextStyle.s12_w400(color: context.colors.primary),
                  ),
                ),
              ],
            ),
            Gaps.vGap8,
            Container(
              height: 200.h,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: SingleChildScrollView(
                controller: _logController,
                child: Text(
                  _logs.isEmpty ? 'No logs yet...' : _logs,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.sp,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, bool status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            status ? Icons.check_circle : Icons.cancel,
            color: status ? Colors.green : Colors.red,
            size: 16,
          ),
          Gaps.hGap8,
          Expanded(
            child: Text(
              label,
              style: AppTextStyle.s14_w400(color: context.colors.black),
            ),
          ),
        ],
      ),
    );
  }
}