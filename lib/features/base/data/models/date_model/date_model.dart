import 'package:freezed_annotation/freezed_annotation.dart';

part 'date_model.freezed.dart';
part 'date_model.g.dart';

@unfreezed
@immutable
class DateModel with _$DateModel {
  const DateModel._();

  @JsonSerializable(explicitToJson: true)
  factory DateModel({
    @JsonKey(name: "dow", defaultValue: []) required List<int>? dow,
    @JsonKey(name: "start") required String start,
    @JsonKey(name: "end") required String end,
  }) = _DateModel;

  factory DateModel.fromJson(Map<String, dynamic> json) =>
      _$DateModelFromJson(json);
}
