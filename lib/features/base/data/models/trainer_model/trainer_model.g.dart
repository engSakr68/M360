// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trainer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrainerModelImpl _$$TrainerModelImplFromJson(Map<String, dynamic> json) =>
    _$TrainerModelImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      name: json['full_name'] as String?,
      photoUrl: json['photo_url'] as String? ?? '',
      minSlotDuration: (json['min_slot_duration'] as num?)?.toInt(),
      openTimesPerDay: (json['openTimesPerDay'] as List<dynamic>?)
          ?.map((e) => DateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      businessHours: json['businessHours'] == null
          ? null
          : DateModel.fromJson(json['businessHours'] as Map<String, dynamic>),
      profile: json['profile'] == null
          ? null
          : TrainerProfileModel.fromJson(
              json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TrainerModelImplToJson(_$TrainerModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'full_name': instance.name,
      'photo_url': instance.photoUrl,
      'min_slot_duration': instance.minSlotDuration,
      'openTimesPerDay':
          instance.openTimesPerDay?.map((e) => e.toJson()).toList(),
      'businessHours': instance.businessHours?.toJson(),
      'profile': instance.profile?.toJson(),
    };
