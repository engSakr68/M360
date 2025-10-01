import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member360/core/bloc/device_cubit/device_cubit.dart';
import 'package:member360/core/helpers/global_notification.dart';
import 'package:member360/core/helpers/services/current_version_helper.dart';
import 'package:member360/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/helpers/di.dart';
import 'core/routes/router_imports.dart';
import 'features/base/presentation/pages/demo/openpath_bridge.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "Member360",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  await OpenpathBridge.instance.initialize(); // Initialize OpenPath SDK here
  getIt.registerSingleton(SharedPreferences.getInstance());
  getIt.registerSingleton(AppRouter());
  await configureDependencies();
  await CurrentVersionHelper.instance.init();
  getIt<GlobalNotification>().setupNotification();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(
    BlocProvider(
      create: (BuildContext context) => DeviceCubit(),
      child: const MyApp(),
    ),
  );
}
