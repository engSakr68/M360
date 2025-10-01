import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:member360/features/base/data/models/price_model/price_model.dart';

part 'trainer_profile_model.freezed.dart';
part 'trainer_profile_model.g.dart';

@unfreezed
@immutable
class TrainerProfileModel with _$TrainerProfileModel {
  const TrainerProfileModel._();

  @JsonSerializable(explicitToJson: true)
  factory TrainerProfileModel({
    @JsonKey(name: "id") required int? id,
    @JsonKey(name: "trainer_id") required int? trainerId,
    @JsonKey(name: "gym_id") required int? gymId,
    @JsonKey(name: "intro") required String? intro,
    @JsonKey(name: "min_booking_slot_duration") required int? minBookingSlotDuration,
    @JsonKey(name: "price") required String? price,
    @JsonKey(name: "book_via_portal") required bool? bookViaPortal,
    @JsonKey(name: "mandatory_payment") required bool? mandatoryPayment,
    @JsonKey(name: "prices") required List<PriceModel>? prices,
  }) = _TrainerProfileModel;

  factory TrainerProfileModel.fromJson(Map<String, dynamic> json) =>
      _$TrainerProfileModelFromJson(json);
}
