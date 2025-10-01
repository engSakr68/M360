import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:member360/features/base/data/models/date_model/date_model.dart';
import 'package:member360/features/base/data/models/trainer_profile_model/trainer_profile_model.dart';

part 'trainer_model.freezed.dart';
part 'trainer_model.g.dart';

@unfreezed
@immutable
class TrainerModel with _$TrainerModel {
  const TrainerModel._();

  @JsonSerializable(explicitToJson: true)
  factory TrainerModel({
    @JsonKey(name: "id") required int? id,
    @JsonKey(name: "title") required String? title,
    @JsonKey(name: "full_name") required String? name,
    @JsonKey(name: "photo_url", nullable: true, defaultValue: "") required String? photoUrl,
    @JsonKey(name: "min_slot_duration") required int? minSlotDuration,
    // @JsonKey(name: "openTimesPerDay", nullable: true) required Map<String, DateModel>? openTimesPerDay,
    @JsonKey(name: "openTimesPerDay", nullable: true) required List<DateModel>? openTimesPerDay,
    @JsonKey(name: "businessHours", nullable: true) required DateModel? businessHours,
    @JsonKey(name: "profile", nullable: true) required TrainerProfileModel? profile,
  }) = _TrainerModel;

  factory TrainerModel.fromJson(Map<String, dynamic> json) =>
      _$TrainerModelFromJson(json);
}
