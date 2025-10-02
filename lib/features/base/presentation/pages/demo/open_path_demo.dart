import 'dart:async';
import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member360/core/constants/gaps.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';
import 'package:member360/core/widgets/app_button.dart';
import 'package:member360/core/widgets/default_app_bar.dart';
import 'openpath_bridge.dart';

@RoutePage(name: "OpenpathDemoAppRoute")
class OpenpathDemoApp extends StatefulWidget {
  final String token;
  const OpenpathDemoApp({super.key, required this.token});

  @override
  State<OpenpathDemoApp> createState() => _OpenpathDemoAppState();
}

class _OpenpathDemoAppState extends State<OpenpathDemoApp> {
  Map<String, dynamic>? permissionStatus;
  ProvisionStatus? provisionStatus;
  String log = '';
  bool isProvisioning = false;
  StreamSubscription? _sub;

  final ScrollController _logController = ScrollController();
  String? pushToken;

  @override
  void initState() {
    super.initState();

    _sub = OpenpathBridge.events.listen((event) async {
      setState(() {
        log += '[evt] ${jsonEncode(event)}\n';
        _autoScrollLog();
      });

      final name = event.event;
      if (name == 'provisioning_started') {
        if (!mounted) return;
        setState(() => isProvisioning = true);
      } else if (name == 'provision_success') {
        if (!mounted) return;
        setState(() => isProvisioning = false);
        // Reflect success in UI
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Provisioned successfully')),
        );
        await _refreshProvisionStatus();
      } else if (name == 'provision_failed') {
        if (!mounted) return;
        setState(() => isProvisioning = false);
        final data = event.data;
        final msg = (data is Map && data['error'] != null)
            ? data['error'].toString()
            : 'Provisioning failed';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), backgroundColor: Colors.red),
        );
        await _refreshProvisionStatus();
      }
    });

    _refreshPermissionStatus();
  }

  @override
  void dispose() {
    _sub?.cancel();
    _logController.dispose();
    super.dispose();
  }

  void _autoScrollLog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_logController.hasClients) {
        _logController.jumpTo(_logController.position.maxScrollExtent);
      }
    });
  }

  Future<void> _refreshPermissionStatus() async {
    final status = await OpenpathBridge.getPermissionStatus();
    setState(() => permissionStatus = status);
  }

  Future<void> _refreshProvisionStatus() async {
    final status = await OpenpathBridge.checkProvisionStatus();
    setState(() {
      provisionStatus = status;
      log += 'Provision Status: ${status.toJson()}\n';
      _autoScrollLog();
    });
  }

  Future<void> _ensureReady() async {
    await OpenpathBridge.requestPermissions();
    await OpenpathBridge.initialize();
    await _refreshPermissionStatus();
  }

  Future<String?> _getPushToken() async {
    // If using FCM, you can uncomment:
    // try { return await FirebaseMessaging.instance.getToken(); } catch (_) {}
    return null;
  }

  Future<void> _provision() async {
    if (isProvisioning) return;

    setState(() {
      isProvisioning = true;
      log += 'Starting provisioning process...\n';
      _autoScrollLog();
    });

    try {
      final opal = OpenpathBridge.extractOpalFromJwt(widget.token);
      await _ensureReady();
      pushToken = await _getPushToken();

      setState(() {
        log += 'Extracted opal: $opal\n';
        log += 'Push token: ${pushToken ?? "null"}\n';
      });

      final ok = await OpenpathBridge.provisionWhenReady(
        widget.token,
        opal: opal,
        deviceToken: pushToken,
      );

      setState(() {
        log += 'Provision result: $ok\n';
        if (!ok) {
          log += '⚠️ JWT tokens are single-use. Might need a fresh token.\n';
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  "⚠️ Provisioning failed: token may be expired or already used"),
              backgroundColor: Colors.red,
            ),
          );
        }
      });

      await _refreshProvisionStatus();

      final userOpal = await OpenpathBridge.getUserOpal();
      setState(() {
        log += 'Current User Opal: $userOpal\n';
      });

      final methods = await OpenpathBridge.getAvailableMethods();
      setState(() {
        log += 'Available SDK methods: $methods\n';
      });
    } catch (e) {
      setState(() {
        log += 'Provisioning error: $e\n';
      });
    } finally {
      setState(() {
        isProvisioning = false;
        _autoScrollLog();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = permissionStatus;
    final p = provisionStatus;

    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'OpenPath',
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: s == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Icon(Icons.lock_open_rounded,
                      size: 96.h, color: context.colors.primary),
                  Gaps.vGap16,
                  Text(
                    'Press the button to activate your Digital Card',
                    style: AppTextStyle.s18_w500(color: context.colors.black),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.vGap32,
                  AppTextButton.maxCustom(
                    onPressed: isProvisioning ? null : _provision,
                    text: isProvisioning ? 'Provisioning...' : 'Provision',
                    bgColor: context.colors.secondary,
                    txtColor: context.colors.white,
                    textSize: 15.sp,
                    maxHeight: 52.h,
                  ),
                  Gaps.vGap16,

                  /// Permission card simplified ✅
                  StatusCard(
                    title: 'Permission Status',
                    children: [
                      _row('Bluetooth ON', s['btOn'] == true),
                      _row('Location ON', s['locationOn'] == true),
                      _row('Notifications ON', s['notificationsOn'] == true),
                    ],
                  ),
                  Gaps.vGap16,

                  if (p != null)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Provision Status',
                                style: AppTextStyle.s16_w700(
                                    color: context.colors.black)),
                            Gaps.vGap8,
                            _row('Is Provisioned', p.isProvisioned),
                            if (p.userOpal != null)
                              Text('User Opal: ${p.userOpal}',
                                  style: AppTextStyle.s14_w400(
                                      color: context.colors.black)),
                            if (p.error != null)
                              Text('Error: ${p.error}',
                                  style: AppTextStyle.s14_w400(
                                      color: context.colors.secondary)),
                          ],
                        ),
                      ),
                    ),
                  Gaps.vGap16,

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SingleChildScrollView(
                        controller: _logController,
                        child: Text(
                          log,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _row(String label, bool ok) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            ok ? Icons.check_circle : Icons.cancel,
            color: ok ? Colors.green : Colors.red,
            size: 16,
          ),
          const SizedBox(width: 8),
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

class StatusCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const StatusCard({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: AppTextStyle.s16_w700(color: context.colors.black)),
            Gaps.vGap8,
            ...children,
          ],
        ),
      ),
    );
  }
}
