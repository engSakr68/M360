import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum LogOutEnum {
  success("success"),
  failed("failed");

  final String value;

  const LogOutEnum(this.value);
}
