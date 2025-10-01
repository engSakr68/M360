// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaceModelImpl _$$PlaceModelImplFromJson(Map<String, dynamic> json) =>
    _$PlaceModelImpl(
      geometry:
          GeometryModel.fromJson(json['geometry'] as Map<String, dynamic>),
      icon: json['icon'] as String,
      iconBackgroundColor: json['icon_background_color'] as String,
      iconMaskBaseUri: json['icon_mask_base_uri'] as String,
      name: json['name'] as String,
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => PhotoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      placeId: json['place_id'] as String,
      reference: json['reference'] as String,
      scope: json['scope'] as String?,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
      vicinity: json['vicinity'] as String,
    );

Map<String, dynamic> _$$PlaceModelImplToJson(_$PlaceModelImpl instance) =>
    <String, dynamic>{
      'geometry': instance.geometry.toJson(),
      'icon': instance.icon,
      'icon_background_color': instance.iconBackgroundColor,
      'icon_mask_base_uri': instance.iconMaskBaseUri,
      'name': instance.name,
      'photos': instance.photos?.map((e) => e.toJson()).toList(),
      'place_id': instance.placeId,
      'reference': instance.reference,
      'scope': instance.scope,
      'types': instance.types,
      'vicinity': instance.vicinity,
    };
