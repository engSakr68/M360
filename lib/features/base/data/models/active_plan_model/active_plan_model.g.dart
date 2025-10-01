// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivePlanModelImpl _$$ActivePlanModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ActivePlanModelImpl(
      memberPlanId: (json['member_plan_id'] as num?)?.toInt(),
      planName: json['plan_name'] as String?,
      duration: json['duration'] as String?,
      durationCount: (json['duration_count'] as num?)?.toInt(),
      entryCount: (json['entry_count'] as num?)?.toInt(),
      homeGymName: json['home_gym_name'] as String?,
      membershipStart: json['membership_start'] as String?,
      membershipEnd: json['membership_end'] as String?,
      currentBalance: (json['current_balance'] as num?)?.toInt(),
      price: json['price'] as String?,
    );

Map<String, dynamic> _$$ActivePlanModelImplToJson(
        _$ActivePlanModelImpl instance) =>
    <String, dynamic>{
      'member_plan_id': instance.memberPlanId,
      'plan_name': instance.planName,
      'duration': instance.duration,
      'duration_count': instance.durationCount,
      'entry_count': instance.entryCount,
      'home_gym_name': instance.homeGymName,
      'membership_start': instance.membershipStart,
      'membership_end': instance.membershipEnd,
      'current_balance': instance.currentBalance,
      'price': instance.price,
    };
