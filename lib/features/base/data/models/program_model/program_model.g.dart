// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProgramModelImpl _$$ProgramModelImplFromJson(Map<String, dynamic> json) =>
    _$ProgramModelImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      color: json['color'] as String?,
      photo: json['class_photo_url'] as String?,
      description: json['description'] as String?,
      trainer: json['trainer'] == null
          ? null
          : TrainerModel.fromJson(json['trainer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProgramModelImplToJson(_$ProgramModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'color': instance.color,
      'class_photo_url': instance.photo,
      'description': instance.description,
      'trainer': instance.trainer?.toJson(),
    };
