import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member360/core/bloc/device_cubit/device_cubit.dart';
import 'package:member360/core/constants/app_config.dart';
import 'package:member360/core/helpers/di.dart';
import 'package:member360/core/helpers/global_context.dart';

/// how to use ?
/// @JsonKey(name: "name", ) required final LocalizedNameModel localizedName,
class LocalizedNameModel {
  final dynamic jsonValue;

  const LocalizedNameModel([this.jsonValue]);

  factory LocalizedNameModel.empty() {
    return const LocalizedNameModel();
  }

  factory LocalizedNameModel.fromStrings(
      {required String ar, required String en}) {
    return LocalizedNameModel.fromJson({'en': en, "ar": ar});
  }

  factory LocalizedNameModel.fromString(String? str) {
    final contentJson = {AppConfig.instance.defaultLanguage: str};
    contentJson.putIfAbsent(AppConfig.instance.defaultLanguage, () => str);
    return LocalizedNameModel(contentJson);
  }

  factory LocalizedNameModel.fromJson(json) {
    return LocalizedNameModel(json);
  }

  Map<String, String> toJson() {
    if (jsonValue is Map) {
      return ((jsonValue ?? <String, String>{}) as Map).cast<String, String>();
    } else {
      return <String, String>{};
    }
  }

  String? getStringByLangCode(String langCode) {
    if (jsonValue is Map) {
      // ignore: avoid_dynamic_calls
      return jsonValue[langCode];
    }
    return null;
  }

  /// [LocalizedStringType] it comes from field model and it will be Map of String
  /// [key] is the key of the language
  /// [values] is the value of the language
  /// this function will return the correct localized based on device language
  String get getLocalizedString {
    var context = getIt<GlobalContext>().context();
    var lang = context.watch<DeviceCubit>().state.model.locale.languageCode;
    try {
      if (jsonValue == null) return "";
      if (jsonValue is String) return jsonValue;
      return (jsonValue as Map<String, String>)[lang] ?? "";
    } catch (_) {
      return '';
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalizedNameModel &&
          runtimeType == other.runtimeType &&
          () {
            if (jsonValue is Map && other.jsonValue is Map) {
              return const DeepCollectionEquality()
                  .equals(jsonValue, other.jsonValue);
            } else {
              return jsonValue == other.jsonValue;
            }
          }();

  @override
  int get hashCode => jsonValue.hashCode;
}

LocalizedNameModel localizedNameModelFromJson(dynamic json) {
  return LocalizedNameModel(json);
}

Map<String, dynamic>? localizedNameModelToJson(LocalizedNameModel? map) {
  if (map == null) return null;
  return map.jsonValue;
}
