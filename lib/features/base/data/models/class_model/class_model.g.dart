// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassModelImpl _$$ClassModelImplFromJson(Map<String, dynamic> json) =>
    _$ClassModelImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      start: json['start'] as String?,
      end: json['end'] as String?,
      programId: (json['program_id'] as num?)?.toInt(),
      imageUrl: json['image_url'] as String?,
      description: json['description'] as String?,
      maxSlots: (json['max_slots'] as num?)?.toInt(),
      availableSpots: (json['available_spots'] as num?)?.toInt(),
      waitList: json['wait_list'] as bool?,
      attendancesCount: (json['attendances_count'] as num?)?.toInt(),
      color: json['color'] as String?,
      price: json['price'] as String?,
      trainer: json['trainer'] as String?,
      scheduleTitle: json['schedule_title'] as String?,
      slots: json['slots'] as String?,
      trainerId: (json['trainer_id'] as num?)?.toInt(),
      resourceId: (json['resourceId'] as num?)?.toInt(),
      alreadyBooked: json['already_booked'] as bool?,
      trainingProgramSession: json['training_program_session'] as bool?,
      mandatoryPayment: json['mandatory_payment'] as bool?,
      gymId: (json['gym_id'] as num?)?.toInt(),
      gymName: json['gym_name'] as String?,
      waitLimit: (json['wait_list_limit'] as num?)?.toInt() ?? 0,
      waitSpots: (json['wait_spots'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ClassModelImplToJson(_$ClassModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'start': instance.start,
      'end': instance.end,
      'program_id': instance.programId,
      'image_url': instance.imageUrl,
      'description': instance.description,
      'max_slots': instance.maxSlots,
      'available_spots': instance.availableSpots,
      'wait_list': instance.waitList,
      'attendances_count': instance.attendancesCount,
      'color': instance.color,
      'price': instance.price,
      'trainer': instance.trainer,
      'schedule_title': instance.scheduleTitle,
      'slots': instance.slots,
      'trainer_id': instance.trainerId,
      'resourceId': instance.resourceId,
      'already_booked': instance.alreadyBooked,
      'training_program_session': instance.trainingProgramSession,
      'mandatory_payment': instance.mandatoryPayment,
      'gym_id': instance.gymId,
      'gym_name': instance.gymName,
      'wait_list_limit': instance.waitLimit,
      'wait_spots': instance.waitSpots,
    };
