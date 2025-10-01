// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gym_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GymModelImpl _$$GymModelImplFromJson(Map<String, dynamic> json) =>
    _$GymModelImpl(
      id: (json['id'] as num?)?.toInt(),
      memberId: (json['member_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      logo: json['logo'] as String?,
      logoUrl: json['logo_url'] as String?,
    );

Map<String, dynamic> _$$GymModelImplToJson(_$GymModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'member_id': instance.memberId,
      'name': instance.name,
      'logo': instance.logo,
      'logo_url': instance.logoUrl,
    };
