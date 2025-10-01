// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DateModelImpl _$$DateModelImplFromJson(Map<String, dynamic> json) =>
    _$DateModelImpl(
      dow: (json['dow'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      start: json['start'] as String,
      end: json['end'] as String,
    );

Map<String, dynamic> _$$DateModelImplToJson(_$DateModelImpl instance) =>
    <String, dynamic>{
      'dow': instance.dow,
      'start': instance.start,
      'end': instance.end,
    };
