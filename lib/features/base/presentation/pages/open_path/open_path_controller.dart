part of "open_path_imports.dart";

class OpenPathController {
  OpenPathController() {
    // Listen for native status events from Android (emitProvisionStatus)
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

    // Also listen to broadcast events for fine-grained status
    _eventSub = _events.receiveBroadcastStream().listen((evt) {
      try {
        final map = evt is Map
            ? Map<String, dynamic>.from(evt)
            : <String, dynamic>{'event': evt.toString()};
        final name = (map['event'] ?? '').toString();
        if (name == 'provisioning_started') {
          isBusy.setValue(true);
        } else if (name == 'provision_success') {
          isBusy.setValue(false);
          final data = map['data'];
          final parsed =
              data is Map ? Map<String, dynamic>.from(data) : null;
          credentialObs.setValue(<String, dynamic>{
            'provisioned': true,
            if (parsed != null && parsed['opal'] != null)
              'opal': parsed['opal'],
          });
          errorObs.setValue(null);
        } else if (name == 'provision_failed') {
          isBusy.setValue(false);
          final data = map['data'];
          final err = (data is Map && data['error'] != null)
              ? data['error'].toString()
              : 'Provision failed';
          errorObs.setValue(err);
        }
      } catch (_) {}
    });
  }

  static const _channel = MethodChannel('openpath');
  static const _events = EventChannel('openpath_events');

  /// `null` → not provisioned | non-null → credential details
  ObsValue<Map<String, dynamic>?> credentialObs =
      ObsValue<Map<String, dynamic>?>.withInit(null);

  /// Used to flip the button text → true while we’re talking to the SDK
  ObsValue<bool> isBusy = ObsValue<bool>.withInit(false);

  /// Last error string (shown under the button)
  ObsValue<String?> errorObs = ObsValue<String?>.withInit(null);

  StreamSubscription? _eventSub;

  /* ───────────────────────────────── Permissions ───────────────────────── */
  Future<bool> _ensurePermissions() async {
    if (!Platform.isAndroid) return true;

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
          _toastError('Please enable Bluetooth and try again');
        }
        
        // Check if Location needs to be enabled
        if (newPermissionStatus['locationOn'] != true) {
          print('Location not enabled, opening settings');
          await _channel.invokeMethod('openLocationSettings');
          _toastError('Please enable Location services and try again');
        }
        
        return false;
      }
      
      return true;
    } catch (e) {
      print('Failed to request permissions via native plugin: $e');
      return false;
    }
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
    final idMatch = RegExp(r'credentialId[:\s=]\s*([\w-]+)').firstMatch(msg);
    final typeMatch = RegExp(r'type[:\s=]\s*([\w-]+)').firstMatch(msg);

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
      _toastError('Required permissions denied. Please grant Bluetooth and Location permissions.');
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
