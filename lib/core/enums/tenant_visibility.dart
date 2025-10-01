import 'dart:ui';

import 'package:member360/core/constants/enum_extension/enum_factory_extension.dart';
import 'package:member360/core/localization/translate.dart';
import 'package:member360/core/theme/colors/app_colors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'value')
enum TenantVisibility {
  active("active"),
  inactive("inactive"),
  closed("closed"),
  expired("expired"),
  registered("registered"),
  non("");

  final String value;

  const TenantVisibility(this.value);

  factory TenantVisibility.fromValue(String val) {
    try {
      return TenantVisibility.values.enumFactory(val);
    } catch (_) {}
    return non;
  }

  String getLocalizedName() {
    switch (this) {
      case TenantVisibility.active:
        return Translate.s.active;
      case TenantVisibility.inactive:
        return Translate.s.inactive;
      case TenantVisibility.closed:
        return Translate.s.closed;
      case TenantVisibility.expired:
        return Translate.s.expired;
      case TenantVisibility.registered:
        return Translate.s.registered;
      default:
        return "";
    }
  }

  Color getColor() {
    switch (this) {
      case TenantVisibility.inactive:
        return AppColors.fixedColors.secondary;
      default:
        return AppColors.fixedColors.primary;
    }
  }
}
