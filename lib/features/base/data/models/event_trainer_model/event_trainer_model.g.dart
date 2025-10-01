// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_trainer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventTrainerModelImpl _$$EventTrainerModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EventTrainerModelImpl(
      id: (json['id'] as num).toInt(),
      memberId: json['memberid'] as String,
      fname: json['fname'] as String,
      sname: json['sname'] as String,
      email: json['email'] as String? ?? '',
      phone: json['mobilephone'] as String? ?? '',
      dob: json['dob'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      photoUrl: json['photo_url'] as String? ?? '',
    );

Map<String, dynamic> _$$EventTrainerModelImplToJson(
        _$EventTrainerModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'memberid': instance.memberId,
      'fname': instance.fname,
      'sname': instance.sname,
      'email': instance.email,
      'mobilephone': instance.phone,
      'dob': instance.dob,
      'gender': instance.gender,
      'full_name': instance.fullName,
      'photo_url': instance.photoUrl,
    };
