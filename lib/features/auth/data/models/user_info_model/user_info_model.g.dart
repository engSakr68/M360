// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserInfoModelImpl _$$UserInfoModelImplFromJson(Map<String, dynamic> json) =>
    _$UserInfoModelImpl(
      id: (json['id'] as num?)?.toInt(),
      fname: json['fname'] as String,
      sname: json['sname'] as String,
      email: json['email'] as String? ?? '',
      photoUrl: json['photo_url'] as String? ?? '',
      phone: json['mobilephone'] as String? ?? '',
      dob: json['dob'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      plans: json['plans'] as String? ?? '',
      currentBalance: (json['current_balance'] as num?)?.toDouble() ?? 0,
      gym: json['gym'] == null
          ? null
          : GymModel.fromJson(json['gym'] as Map<String, dynamic>),
      activeGyms: (json['active_gyms'] as List<dynamic>?)
              ?.map((e) => GymModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      memberId: json['memberid'] as String,
    );

Map<String, dynamic> _$$UserInfoModelImplToJson(_$UserInfoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fname': instance.fname,
      'sname': instance.sname,
      'email': instance.email,
      'photo_url': instance.photoUrl,
      'mobilephone': instance.phone,
      'dob': instance.dob,
      'gender': instance.gender,
      'plans': instance.plans,
      'current_balance': instance.currentBalance,
      'gym': instance.gym?.toJson(),
      'active_gyms': instance.activeGyms?.map((e) => e.toJson()).toList(),
      'memberid': instance.memberId,
    };
