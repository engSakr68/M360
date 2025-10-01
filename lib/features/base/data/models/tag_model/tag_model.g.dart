// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TagModelImpl _$$TagModelImplFromJson(Map<String, dynamic> json) =>
    _$TagModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] == null
          ? null
          : NameModel.fromJson(json['name'] as Map<String, dynamic>),
      slug: json['slug'] == null
          ? null
          : NameModel.fromJson(json['slug'] as Map<String, dynamic>),
      type: json['type'] as String?,
      orderColumn: (json['order_column'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$TagModelImplToJson(_$TagModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name?.toJson(),
      'slug': instance.slug?.toJson(),
      'type': instance.type,
      'order_column': instance.orderColumn,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
