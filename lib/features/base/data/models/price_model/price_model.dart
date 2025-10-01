import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_model.freezed.dart';
part 'price_model.g.dart';

@unfreezed
@immutable
class PriceModel with _$PriceModel {
  const PriceModel._();

  @JsonSerializable(explicitToJson: true)
  factory PriceModel({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "trainer_gym_profile_id") required int trainerGymProfileId,
    @JsonKey(name: "price") required String price,
    @JsonKey(name: "minutes") required int minutes,
    @JsonKey(name: "label") required String label,
  }) = _PriceModel;

  factory PriceModel.fromJson(Map<String, dynamic> json) =>
      _$PriceModelFromJson(json);
}
