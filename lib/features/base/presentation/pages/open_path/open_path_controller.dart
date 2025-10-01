part of "open_path_imports.dart";

class OpenPathController {
  OpenPathController() {
    // Listen for native status events from Android (MainActivity.emitProvisionStatus)
    _channel.setMethodCallHandler((call) async {
      if (call.method != 'provisionStatus') return;

      final args = Map<String, dynamic>.from(call.arguments as Map);
      final ok = args['ok'] == true;
      final msg = args['message'] as String?;

      // Keep the spinner on while provisioning is in-flight
      if (msg == 'provisioning_started') {
        isBusy.setValue(true);
        return;
      }

      // Stop spinner on any terminal state
      isBusy.setValue(false);

      if (ok) {
        // If native unprovision succeeded, clear state
        if ((msg ?? '').toLowerCase().contains('unprovision')) {
          credentialObs.setValue(null);
          errorObs.setValue(null);
          return;
        }

        // Mark as provisioned so the button flips to "Unprovision".
        // Android doesn't return credential details; try to extract if present.
        final parsed = _parseCredentialFromMessage(msg);
        credentialObs
            .setValue(parsed ?? <String, dynamic>{'provisioned': true});
        errorObs.setValue(null);
      } else {
        // Show error text under the button
        if (msg != null && msg.isNotEmpty) {
          errorObs.setValue(msg);
        }
      }
    });
  }

  static const _channel = MethodChannel('openpath_bridge');

  /// `null` → not provisioned | non-null → credential details
  ObsValue<Map<String, dynamic>?> credentialObs =
      ObsValue<Map<String, dynamic>?>.withInit(null);

  /// Used to flip the button text → true while we’re talking to the SDK
  ObsValue<bool> isBusy = ObsValue<bool>.withInit(false);

  /// Last error string (shown under the button)
  ObsValue<String?> errorObs = ObsValue<String?>.withInit(null);

  /* ───────────────────────────────── Permissions ───────────────────────── */
  Future<bool> _ensurePermissions() async {
    if (!Platform.isAndroid) return true;

    final sdk = (await DeviceInfoPlugin().androidInfo).version.sdkInt;

    final toRequest = <Permission>[
      if (sdk >= 31) ...[
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        // Only if you actually advertise:
        // Permission.bluetoothAdvertise,
      ] else ...[
        // Pre-Android 12 scanning maps to "location when in use"
        Permission.locationWhenInUse,
        Permission.bluetooth,
      ],
      // Recommended if your SDK shows a foreground notification:
      Permission.notification,
    ];

    final statuses = await toRequest.request();
    final denied = statuses.entries
        .where((e) => e.value.isDenied || e.value.isPermanentlyDenied)
        .map((e) => e.key)
        .toList();

    if (denied.isEmpty) return true;

    // If permanently denied, prompt to Settings (optional)
    if (denied.any((p) => statuses[p]!.isPermanentlyDenied)) {
      await openAppSettings();
    }
    return false;
  }

  /// Best-effort parse for credential details from the native message.
  Map<String, dynamic>? _parseCredentialFromMessage(String? msg) {
    if (msg == null || msg.isEmpty) return null;

    // Accept JSON-ish payloads
    try {
      final decoded = json.decode(msg);
      if (decoded is Map<String, dynamic>) {
        return <String, dynamic>{
          if (decoded.containsKey('credentialId'))
            'credentialId': decoded['credentialId'],
          if (decoded.containsKey('type')) 'type': decoded['type'],
          ...decoded,
        };
      }
    } catch (error) {
      print(error);
      // fall through to regex scanning
    }

    // Try to extract "credentialId=..." and "type=..." from toString() output
    final idMatch = RegExp(r'credentialId[:=]\s*([\w-]+)').firstMatch(msg);
    final typeMatch = RegExp(r'type[:=]\s*([\w-]+)').firstMatch(msg);

    if (idMatch != null || typeMatch != null) {
      return <String, dynamic>{
        if (idMatch != null) 'credentialId': idMatch.group(1),
        if (typeMatch != null) 'type': typeMatch.group(1),
      };
    }
    return null;
  }

  /* ─────────────────── Provision / Unprovision ─────────────────── */
  Future<void> provision(String token) async {
    final ok = await _ensurePermissions();
    if (!ok) {
      _toastError('Bluetooth permissions denied');
      return;
    }

    try {
      isBusy.setValue(true);
      errorObs.setValue(null);

      final res =
          await _channel.invokeMethod<Map?>('provision', {'token': token});

      // iOS returns a map; Android is fire-and-forget
      if (res != null) credentialObs.setValue(res.cast<String, dynamic>());
    } on PlatformException catch (e) {
      errorObs.setValue(e.message ?? 'Unknown error');
      credentialObs.setValue(null);
    } finally {
      isBusy.setValue(false);
    }
  }

  Future<void> unprovision() async {
    try {
      isBusy.setValue(true);
      errorObs.setValue(null);
      await _channel.invokeMethod('unprovision');
      credentialObs.setValue(null);
    } on PlatformException catch (e) {
      errorObs.setValue(e.message ?? 'Unknown error');
    } finally {
      isBusy.setValue(false);
    }
  }

  Future<void> onActivatePressed() async {
    // final prefs = await SharedPreferences.getInstance();
    // final saved = prefs.getString(ApplicationConstants.userOP);
    // print("saved OP token: $saved");
    // if (saved != null) {
    //   await provision(saved);
    // } else {
    await generateOP();
    // if (!ok) errorObs.setValue('Couldn’t generate token');
    // }
  }

  Future<bool> generateOP() async {
    final response = await getIt<BaseRepository>().generateOP(true);
    return _handleOPResponse(response);
  }

  bool _handleOPResponse(MyResult<String> response) => response.when(
        isSuccess: (token) {
          final context = getIt<GlobalContext>().context();
          UserHelperService.instance.saveOPData(token!);
          AutoRouter.of(context).push(OpenPathDemoRoute(token: token));
          // provision(token);
          return true;
        },
        isError: (_) => false,
      );

  void _toastError(String msg) =>
      AppSnackBar.showSimpleToast(msg: msg, type: ToastType.error);
}
