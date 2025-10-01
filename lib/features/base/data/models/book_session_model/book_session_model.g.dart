// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookSessionModelImpl _$$BookSessionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BookSessionModelImpl(
      id: (json['id'] as num?)?.toInt(),
      trainerId: (json['trainer_id'] as num?)?.toInt(),
      memberId: (json['member_id'] as num?)?.toInt(),
      gymId: (json['gym_id'] as num?)?.toInt(),
      invoiceId: (json['oinvoice_id'] as num?)?.toInt(),
      title: json['title'] as String?,
      startTime: json['starttime'] as String?,
      endTime: json['endtime'] as String?,
    );

Map<String, dynamic> _$$BookSessionModelImplToJson(
        _$BookSessionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'trainer_id': instance.trainerId,
      'member_id': instance.memberId,
      'gym_id': instance.gymId,
      'oinvoice_id': instance.invoiceId,
      'title': instance.title,
      'starttime': instance.startTime,
      'endtime': instance.endTime,
    };
