import 'package:member360/core/constants/enum_extension/enum_factory_extension.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum UserTypes {
  owner("owner"),
  client("client"),
  non("");

  final String value;

  const UserTypes(this.value);

  factory UserTypes.fromValue(String val) {
    try {
      return UserTypes.values.enumFactory(val);
    } catch (_) {}
    return non;
  }
}
