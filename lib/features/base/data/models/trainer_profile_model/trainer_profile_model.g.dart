// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trainer_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrainerProfileModelImpl _$$TrainerProfileModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TrainerProfileModelImpl(
      id: (json['id'] as num?)?.toInt(),
      trainerId: (json['trainer_id'] as num?)?.toInt(),
      gymId: (json['gym_id'] as num?)?.toInt(),
      intro: json['intro'] as String?,
      minBookingSlotDuration:
          (json['min_booking_slot_duration'] as num?)?.toInt(),
      price: json['price'] as String?,
      bookViaPortal: json['book_via_portal'] as bool?,
      mandatoryPayment: json['mandatory_payment'] as bool?,
      prices: (json['prices'] as List<dynamic>?)
          ?.map((e) => PriceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TrainerProfileModelImplToJson(
        _$TrainerProfileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'trainer_id': instance.trainerId,
      'gym_id': instance.gymId,
      'intro': instance.intro,
      'min_booking_slot_duration': instance.minBookingSlotDuration,
      'price': instance.price,
      'book_via_portal': instance.bookViaPortal,
      'mandatory_payment': instance.mandatoryPayment,
      'prices': instance.prices?.map((e) => e.toJson()).toList(),
    };
