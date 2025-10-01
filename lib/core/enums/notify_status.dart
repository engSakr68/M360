import 'package:member360/core/constants/enum_extension/enum_factory_extension.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum NotifyStatus {
  read("1"),
  unRead("0"),
  non("");

  final String value;

  const NotifyStatus(this.value);

  factory NotifyStatus.fromValue(String val) {
    try {
      return NotifyStatus.values.enumFactory(val);
    } catch (_) {}
    return non;
  }
}
