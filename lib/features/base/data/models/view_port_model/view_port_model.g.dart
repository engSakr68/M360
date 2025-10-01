// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_port_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ViewPortModelImpl _$$ViewPortModelImplFromJson(Map<String, dynamic> json) =>
    _$ViewPortModelImpl(
      northeast:
          LocationModel.fromJson(json['northeast'] as Map<String, dynamic>),
      southwest:
          LocationModel.fromJson(json['southwest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ViewPortModelImplToJson(_$ViewPortModelImpl instance) =>
    <String, dynamic>{
      'northeast': instance.northeast.toJson(),
      'southwest': instance.southwest.toJson(),
    };
