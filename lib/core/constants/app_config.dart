import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:member360/core/constants/app_constants.dart';
import 'package:member360/core/helpers/di.dart';
import 'package:member360/core/helpers/global_context.dart';
import 'package:member360/core/helpers/global_state.dart';
import 'package:member360/core/routes/router_imports.gr.dart';

class AppConfig {
  AppConfig._();

  static AppConfig instance = AppConfig._();

  String get defaultLanguage => 'ar';

  String? get token => GlobalState.instance.get(ApplicationConstants.keyToken);

  String get baseUrl => 
  // "https://manage.staging.member360.au/";
  "https://manage.gymvue.com.au/";

  // String imageBaseUrl(String imagePath) => "$baseUrl$imagePath?token=$token";

  String imageBaseUrl(String imagePath) =>
      "https://cdn.thiqeel.com/apps/sharingpath/thiqeel/uploads/Member360App/$imagePath";

  String get baseAPIUrl => 
  // "https://manage.staging.member360.au/";
  "https://manage.gymvue.com.au/";

  static BoxConstraints get textFieldConstrains =>
      const BoxConstraints(minHeight: 50, maxHeight: 50);

  static BoxConstraints? fromHeight(double? height) => height != null
      ? BoxConstraints(minHeight: height, maxHeight: height)
      : null;

  Future<void> restartApp() async {
    AutoRouter.of(getIt<GlobalContext>().context()).pushAndPopUntil(
      const SplashRoute(),
      predicate: (_) => false,
    );
  }
}
