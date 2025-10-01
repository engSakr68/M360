import 'package:member360/core/constants/enum_extension/enum_factory_extension.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'value')
enum DateTypes {
  normal("cal_gr"),
  hj("cal_hj"),
  non("");

  final String value;

  const DateTypes(this.value);

  factory DateTypes.fromValue(String val) {
    try {
      return DateTypes.values.enumFactory(val);
    } catch (_) {}
    return non;
  }
}
