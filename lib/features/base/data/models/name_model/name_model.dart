import 'package:freezed_annotation/freezed_annotation.dart';

part 'name_model.freezed.dart';
part 'name_model.g.dart';

@unfreezed
@immutable
class NameModel with _$NameModel {
  const NameModel._();

  @JsonSerializable(explicitToJson: true)
  factory NameModel({
    @JsonKey(name: "en") required String? en,
  }) = _NameModel;

  factory NameModel.fromJson(Map<String, dynamic> json) =>
      _$NameModelFromJson(json);
}
