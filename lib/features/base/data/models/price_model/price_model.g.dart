// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PriceModelImpl _$$PriceModelImplFromJson(Map<String, dynamic> json) =>
    _$PriceModelImpl(
      id: (json['id'] as num).toInt(),
      trainerGymProfileId: (json['trainer_gym_profile_id'] as num).toInt(),
      price: json['price'] as String,
      minutes: (json['minutes'] as num).toInt(),
      label: json['label'] as String,
    );

Map<String, dynamic> _$$PriceModelImplToJson(_$PriceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'trainer_gym_profile_id': instance.trainerGymProfileId,
      'price': instance.price,
      'minutes': instance.minutes,
      'label': instance.label,
    };
