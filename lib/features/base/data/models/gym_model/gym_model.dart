import 'package:freezed_annotation/freezed_annotation.dart';

part 'gym_model.freezed.dart';
part 'gym_model.g.dart';

@unfreezed
@immutable
class GymModel with _$GymModel {
  const GymModel._();

  @JsonSerializable(explicitToJson: true)
  factory GymModel({
    @JsonKey(name: "id") required int? id,
    @JsonKey(name: "member_id") required int? memberId,
    @JsonKey(name: "name") required String? name,
    @JsonKey(name: "logo") required String? logo,
    @JsonKey(name: "logo_url") required String? logoUrl,
  }) = _GymModel;

  factory GymModel.fromJson(Map<String, dynamic> json) =>
      _$GymModelFromJson(json);
}
