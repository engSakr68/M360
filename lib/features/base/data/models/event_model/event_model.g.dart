// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventModelImpl _$$EventModelImplFromJson(Map<String, dynamic> json) =>
    _$EventModelImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      trainer: json['trainer'] == null
          ? null
          : EventTrainerModel.fromJson(json['trainer'] as Map<String, dynamic>),
      resourceId: (json['resourceId'] as num?)?.toInt(),
      start: json['start'] as String?,
      end: json['end'] as String?,
      color: json['color'] as String?,
      date: json['date'] as String?,
      unavailability: json['unavailability'] as bool?,
      alreadyBooked: json['already_booked'] as bool? ?? false,
      recurring: json['recurring'] as bool?,
    );

Map<String, dynamic> _$$EventModelImplToJson(_$EventModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'trainer': instance.trainer?.toJson(),
      'resourceId': instance.resourceId,
      'start': instance.start,
      'end': instance.end,
      'color': instance.color,
      'date': instance.date,
      'unavailability': instance.unavailability,
      'already_booked': instance.alreadyBooked,
      'recurring': instance.recurring,
    };
