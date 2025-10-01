import 'package:member360/core/constants/enum_extension/enum_factory_extension.dart';
import 'package:member360/core/localization/translate.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'value')
enum ContractTypes {
  residential("residential"),
  commercial("commercial"),
  non("");

  final String value;

  const ContractTypes(this.value);

  factory ContractTypes.fromValue(String val) {
    try {
      return ContractTypes.values.enumFactory(val);
    } catch (_) {}
    return non;
  }

  String getLocalizedName() {
    switch (this) {
      case ContractTypes.residential:
        return Translate.s.residential;
      case ContractTypes.commercial:
        return Translate.s.commercial;
      default:
        return "";
    }
  }
}
