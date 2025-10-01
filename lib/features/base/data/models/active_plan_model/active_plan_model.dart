import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_plan_model.freezed.dart';
part 'active_plan_model.g.dart';

@unfreezed
@immutable
class ActivePlanModel with _$ActivePlanModel {
  const ActivePlanModel._();

  @JsonSerializable(explicitToJson: true)
  factory ActivePlanModel({
    @JsonKey(name: "member_plan_id") required int? memberPlanId,
    @JsonKey(name: "plan_name") required String? planName,
    @JsonKey(name: "duration") required String? duration,
    @JsonKey(name: "duration_count") required int? durationCount,
    @JsonKey(name: "entry_count") required int? entryCount,
    @JsonKey(name: "home_gym_name") required String? homeGymName,
    @JsonKey(name: "membership_start") required String? membershipStart,
    @JsonKey(name: "membership_end") required String? membershipEnd,
    @JsonKey(name: "current_balance") required int? currentBalance,
    @JsonKey(name: "price") required String? price,
  }) = _ActivePlanModel;

  factory ActivePlanModel.fromJson(Map<String, dynamic> json) =>
      _$ActivePlanModelFromJson(json);
}
