// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_trainer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EventTrainerModel _$EventTrainerModelFromJson(Map<String, dynamic> json) {
  return _EventTrainerModel.fromJson(json);
}

/// @nodoc
mixin _$EventTrainerModel {
  @JsonKey(name: "id")
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: "id")
  set id(int value) => throw _privateConstructorUsedError;
  @JsonKey(name: "memberid")
  String get memberId => throw _privateConstructorUsedError;
  @JsonKey(name: "memberid")
  set memberId(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: "fname")
  String get fname => throw _privateConstructorUsedError;
  @JsonKey(name: "fname")
  set fname(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: "sname")
  String get sname => throw _privateConstructorUsedError;
  @JsonKey(name: "sname")
  set sname(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: "email", nullable: true, defaultValue: "")
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: "email", nullable: true, defaultValue: "")
  set email(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: "mobilephone", nullable: true, defaultValue: "")
  String? get phone => throw _privateConstructorUsedError;
  @JsonKey(name: "mobilephone", nullable: true, defaultValue: "")
  set phone(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "dob", nullable: true, defaultValue: "")
  String? get dob => throw _privateConstructorUsedError;
  @JsonKey(name: "dob", nullable: true, defaultValue: "")
  set dob(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "gender", nullable: true, defaultValue: "")
  String? get gender => throw _privateConstructorUsedError;
  @JsonKey(name: "gender", nullable: true, defaultValue: "")
  set gender(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "full_name", nullable: true, defaultValue: "")
  String? get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: "full_name", nullable: true, defaultValue: "")
  set fullName(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
  String? get photoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
  set photoUrl(String? value) => throw _privateConstructorUsedError;

  /// Serializes this EventTrainerModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventTrainerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventTrainerModelCopyWith<EventTrainerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventTrainerModelCopyWith<$Res> {
  factory $EventTrainerModelCopyWith(
          EventTrainerModel value, $Res Function(EventTrainerModel) then) =
      _$EventTrainerModelCopyWithImpl<$Res, EventTrainerModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "memberid") String memberId,
      @JsonKey(name: "fname") String fname,
      @JsonKey(name: "sname") String sname,
      @JsonKey(name: "email", nullable: true, defaultValue: "") String email,
      @JsonKey(name: "mobilephone", nullable: true, defaultValue: "")
      String? phone,
      @JsonKey(name: "dob", nullable: true, defaultValue: "") String? dob,
      @JsonKey(name: "gender", nullable: true, defaultValue: "") String? gender,
      @JsonKey(name: "full_name", nullable: true, defaultValue: "")
      String? fullName,
      @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
      String? photoUrl});
}

/// @nodoc
class _$EventTrainerModelCopyWithImpl<$Res, $Val extends EventTrainerModel>
    implements $EventTrainerModelCopyWith<$Res> {
  _$EventTrainerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventTrainerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? memberId = null,
    Object? fname = null,
    Object? sname = null,
    Object? email = null,
    Object? phone = freezed,
    Object? dob = freezed,
    Object? gender = freezed,
    Object? fullName = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      fname: null == fname
          ? _value.fname
          : fname // ignore: cast_nullable_to_non_nullable
              as String,
      sname: null == sname
          ? _value.sname
          : sname // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventTrainerModelImplCopyWith<$Res>
    implements $EventTrainerModelCopyWith<$Res> {
  factory _$$EventTrainerModelImplCopyWith(_$EventTrainerModelImpl value,
          $Res Function(_$EventTrainerModelImpl) then) =
      __$$EventTrainerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "memberid") String memberId,
      @JsonKey(name: "fname") String fname,
      @JsonKey(name: "sname") String sname,
      @JsonKey(name: "email", nullable: true, defaultValue: "") String email,
      @JsonKey(name: "mobilephone", nullable: true, defaultValue: "")
      String? phone,
      @JsonKey(name: "dob", nullable: true, defaultValue: "") String? dob,
      @JsonKey(name: "gender", nullable: true, defaultValue: "") String? gender,
      @JsonKey(name: "full_name", nullable: true, defaultValue: "")
      String? fullName,
      @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
      String? photoUrl});
}

/// @nodoc
class __$$EventTrainerModelImplCopyWithImpl<$Res>
    extends _$EventTrainerModelCopyWithImpl<$Res, _$EventTrainerModelImpl>
    implements _$$EventTrainerModelImplCopyWith<$Res> {
  __$$EventTrainerModelImplCopyWithImpl(_$EventTrainerModelImpl _value,
      $Res Function(_$EventTrainerModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventTrainerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? memberId = null,
    Object? fname = null,
    Object? sname = null,
    Object? email = null,
    Object? phone = freezed,
    Object? dob = freezed,
    Object? gender = freezed,
    Object? fullName = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(_$EventTrainerModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      fname: null == fname
          ? _value.fname
          : fname // ignore: cast_nullable_to_non_nullable
              as String,
      sname: null == sname
          ? _value.sname
          : sname // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$EventTrainerModelImpl extends _EventTrainerModel {
  _$EventTrainerModelImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "memberid") required this.memberId,
      @JsonKey(name: "fname") required this.fname,
      @JsonKey(name: "sname") required this.sname,
      @JsonKey(name: "email", nullable: true, defaultValue: "")
      required this.email,
      @JsonKey(name: "mobilephone", nullable: true, defaultValue: "")
      required this.phone,
      @JsonKey(name: "dob", nullable: true, defaultValue: "") required this.dob,
      @JsonKey(name: "gender", nullable: true, defaultValue: "")
      required this.gender,
      @JsonKey(name: "full_name", nullable: true, defaultValue: "")
      required this.fullName,
      @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
      required this.photoUrl})
      : super._();

  factory _$EventTrainerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventTrainerModelImplFromJson(json);

  @override
  @JsonKey(name: "id")
  int id;
  @override
  @JsonKey(name: "memberid")
  String memberId;
  @override
  @JsonKey(name: "fname")
  String fname;
  @override
  @JsonKey(name: "sname")
  String sname;
  @override
  @JsonKey(name: "email", nullable: true, defaultValue: "")
  String email;
  @override
  @JsonKey(name: "mobilephone", nullable: true, defaultValue: "")
  String? phone;
  @override
  @JsonKey(name: "dob", nullable: true, defaultValue: "")
  String? dob;
  @override
  @JsonKey(name: "gender", nullable: true, defaultValue: "")
  String? gender;
  @override
  @JsonKey(name: "full_name", nullable: true, defaultValue: "")
  String? fullName;
  @override
  @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
  String? photoUrl;

  @override
  String toString() {
    return 'EventTrainerModel(id: $id, memberId: $memberId, fname: $fname, sname: $sname, email: $email, phone: $phone, dob: $dob, gender: $gender, fullName: $fullName, photoUrl: $photoUrl)';
  }

  /// Create a copy of EventTrainerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventTrainerModelImplCopyWith<_$EventTrainerModelImpl> get copyWith =>
      __$$EventTrainerModelImplCopyWithImpl<_$EventTrainerModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventTrainerModelImplToJson(
      this,
    );
  }
}

abstract class _EventTrainerModel extends EventTrainerModel {
  factory _EventTrainerModel(
      {@JsonKey(name: "id") required int id,
      @JsonKey(name: "memberid") required String memberId,
      @JsonKey(name: "fname") required String fname,
      @JsonKey(name: "sname") required String sname,
      @JsonKey(name: "email", nullable: true, defaultValue: "")
      required String email,
      @JsonKey(name: "mobilephone", nullable: true, defaultValue: "")
      required String? phone,
      @JsonKey(name: "dob", nullable: true, defaultValue: "")
      required String? dob,
      @JsonKey(name: "gender", nullable: true, defaultValue: "")
      required String? gender,
      @JsonKey(name: "full_name", nullable: true, defaultValue: "")
      required String? fullName,
      @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
      required String? photoUrl}) = _$EventTrainerModelImpl;
  _EventTrainerModel._() : super._();

  factory _EventTrainerModel.fromJson(Map<String, dynamic> json) =
      _$EventTrainerModelImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int get id;
  @JsonKey(name: "id")
  set id(int value);
  @override
  @JsonKey(name: "memberid")
  String get memberId;
  @JsonKey(name: "memberid")
  set memberId(String value);
  @override
  @JsonKey(name: "fname")
  String get fname;
  @JsonKey(name: "fname")
  set fname(String value);
  @override
  @JsonKey(name: "sname")
  String get sname;
  @JsonKey(name: "sname")
  set sname(String value);
  @override
  @JsonKey(name: "email", nullable: true, defaultValue: "")
  String get email;
  @JsonKey(name: "email", nullable: true, defaultValue: "")
  set email(String value);
  @override
  @JsonKey(name: "mobilephone", nullable: true, defaultValue: "")
  String? get phone;
  @JsonKey(name: "mobilephone", nullable: true, defaultValue: "")
  set phone(String? value);
  @override
  @JsonKey(name: "dob", nullable: true, defaultValue: "")
  String? get dob;
  @JsonKey(name: "dob", nullable: true, defaultValue: "")
  set dob(String? value);
  @override
  @JsonKey(name: "gender", nullable: true, defaultValue: "")
  String? get gender;
  @JsonKey(name: "gender", nullable: true, defaultValue: "")
  set gender(String? value);
  @override
  @JsonKey(name: "full_name", nullable: true, defaultValue: "")
  String? get fullName;
  @JsonKey(name: "full_name", nullable: true, defaultValue: "")
  set fullName(String? value);
  @override
  @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
  String? get photoUrl;
  @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
  set photoUrl(String? value);

  /// Create a copy of EventTrainerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventTrainerModelImplCopyWith<_$EventTrainerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
