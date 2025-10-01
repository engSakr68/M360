import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member360/core/bloc/device_cubit/device_cubit.dart';
import 'package:member360/core/constants/app_config.dart';
import 'package:member360/core/helpers/di.dart';
import 'package:member360/core/helpers/global_context.dart';
import 'package:member360/core/helpers/shared_pref_service.dart';

class LanguageService {
  static const _langKey = 'lang';

  LanguageService._();

  static final LanguageService instance = LanguageService._();

  Future<void> changeLanguage(Languages language) async {
    var context = getIt<GlobalContext>().context();
    context.read<DeviceCubit>().updateLanguage(language.locale);
    getIt<SharedPrefService>().saveString(_langKey, language.code);
  }

  Future<void> initLanguage() async {
    var context = getIt<GlobalContext>().context();
    await getIt<SharedPrefService>().getString(_langKey).then((langCode) {
      if (langCode == null) {
        context.read<DeviceCubit>().updateLanguage(Languages.arabic.locale);
      } else {
        Languages lang =
            Languages.values.firstWhere((element) => element.code == langCode);
        context.read<DeviceCubit>().updateLanguage(lang.locale);
      }
    });
  }

  Future<void> changeLanguageWithRestart(Languages language) async {
    await changeLanguage(language);
    AppConfig.instance.restartApp();
  }
}

enum Languages {
  arabic('ar'),
  english('en');

  final String code;

  const Languages(this.code);

  Locale get locale {
    switch (this) {
      case Languages.english:
        return const Locale('en');
      case Languages.arabic:
        return const Locale('ar');
      default:
        return const Locale('en');
    }
  }

  String get name {
    switch (this) {
      case Languages.arabic:
        return "العربية";
      default:
        return "English";
    }
  }
}
