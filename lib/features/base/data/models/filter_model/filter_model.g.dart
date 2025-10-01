// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FilterModelImpl _$$FilterModelImplFromJson(Map<String, dynamic> json) =>
    _$FilterModelImpl(
      trainers: (json['trainers'] as List<dynamic>?)
          ?.map((e) => TrainerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      classes: (json['trainingPrograms'] as List<dynamic>?)
          ?.map((e) => ProgramModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['availableTags'] as List<dynamic>?)
          ?.map((e) => TagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FilterModelImplToJson(_$FilterModelImpl instance) =>
    <String, dynamic>{
      'trainers': instance.trainers?.map((e) => e.toJson()).toList(),
      'trainingPrograms': instance.classes?.map((e) => e.toJson()).toList(),
      'availableTags': instance.tags?.map((e) => e.toJson()).toList(),
    };
