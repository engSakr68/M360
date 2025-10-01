// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookModelImpl _$$BookModelImplFromJson(Map<String, dynamic> json) =>
    _$BookModelImpl(
      id: (json['id'] as num?)?.toInt(),
      trainingProgramScheduleId:
          (json['training_program_schedule_id'] as num?)?.toInt(),
      memberId: (json['member_id'] as num?)?.toInt(),
      fname: json['fname'] as String?,
      sname: json['sname'] as String?,
      mobilenumber: json['mobilenumber'] as String?,
      email: json['email'] as String?,
      uitem: (json['uitem'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$BookModelImplToJson(_$BookModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'training_program_schedule_id': instance.trainingProgramScheduleId,
      'member_id': instance.memberId,
      'fname': instance.fname,
      'sname': instance.sname,
      'mobilenumber': instance.mobilenumber,
      'email': instance.email,
      'uitem': instance.uitem,
    };
