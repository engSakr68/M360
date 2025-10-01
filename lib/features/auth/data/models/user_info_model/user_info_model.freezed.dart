// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) {
  return _UserInfoModel.fromJson(json);
}

/// @nodoc
mixin _$UserInfoModel {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "id")
  set id(int? value) => throw _privateConstructorUsedError;
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
  @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
  String get photoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
  set photoUrl(String value) => throw _privateConstructorUsedError;
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
  @JsonKey(name: "plans", nullable: true, defaultValue: "")
  String? get plans => throw _privateConstructorUsedError;
  @JsonKey(name: "plans", nullable: true, defaultValue: "")
  set plans(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "current_balance", nullable: true, defaultValue: 0)
  double? get currentBalance => throw _privateConstructorUsedError;
  @JsonKey(name: "current_balance", nullable: true, defaultValue: 0)
  set currentBalance(double? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "gym", nullable: true)
  GymModel? get gym => throw _privateConstructorUsedError;
  @JsonKey(name: "gym", nullable: true)
  set gym(GymModel? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "active_gyms", nullable: true, defaultValue: [])
  List<GymModel>? get activeGyms => throw _privateConstructorUsedError;
  @JsonKey(name: "active_gyms", nullable: true, defaultValue: [])
  set activeGyms(List<GymModel>? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "memberid")
  String get memberId => throw _privateConstructorUsedError;
  @JsonKey(name: "memberid")
  set memberId(String value) => throw _privateConstructorUsedError;

  /// Serializes this UserInfoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserInfoModelCopyWith<UserInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoModelCopyWith<$Res> {
  factory $UserInfoModelCopyWith(
          UserInfoModel value, $Res Function(UserInfoModel) then) =
      _$UserInfoModelCopyWithImpl<$Res, UserInfoModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "fname") String fname,
      @JsonKey(name: "sname") String sname,
      @JsonKey(name: "email", nullable: true, defaultValue: "") String email,
      @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
      String photoUrl,
      @JsonKey(name: "mobilephone", nullable: true, defaultValue: "")
      String? phone,
      @JsonKey(name: "dob", nullable: true, defaultValue: "") String? dob,
      @JsonKey(name: "gender", nullable: true, defaultValue: "") String? gender,
      @JsonKey(name: "plans", nullable: true, defaultValue: "") String? plans,
      @JsonKey(name: "current_balance", nullable: true, defaultValue: 0)
      double? currentBalance,
      @JsonKey(name: "gym", nullable: true) GymModel? gym,
      @JsonKey(name: "active_gyms", nullable: true, defaultValue: [])
      List<GymModel>? activeGyms,
      @JsonKey(name: "memberid") String memberId});

  $GymModelCopyWith<$Res>? get gym;
}

/// @nodoc
class _$UserInfoModelCopyWithImpl<$Res, $Val extends UserInfoModel>
    implements $UserInfoModelCopyWith<$Res> {
  _$UserInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fname = null,
    Object? sname = null,
    Object? email = null,
    Object? photoUrl = null,
    Object? phone = freezed,
    Object? dob = freezed,
    Object? gender = freezed,
    Object? plans = freezed,
    Object? currentBalance = freezed,
    Object? gym = freezed,
    Object? activeGyms = freezed,
    Object? memberId = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
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
      plans: freezed == plans
          ? _value.plans
          : plans // ignore: cast_nullable_to_non_nullable
              as String?,
      currentBalance: freezed == currentBalance
          ? _value.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as double?,
      gym: freezed == gym
          ? _value.gym
          : gym // ignore: cast_nullable_to_non_nullable
              as GymModel?,
      activeGyms: freezed == activeGyms
          ? _value.activeGyms
          : activeGyms // ignore: cast_nullable_to_non_nullable
              as List<GymModel>?,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of UserInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GymModelCopyWith<$Res>? get gym {
    if (_value.gym == null) {
      return null;
    }

    return $GymModelCopyWith<$Res>(_value.gym!, (value) {
      return _then(_value.copyWith(gym: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserInfoModelImplCopyWith<$Res>
    implements $UserInfoModelCopyWith<$Res> {
  factory _$$UserInfoModelImplCopyWith(
          _$UserInfoModelImpl value, $Res Function(_$UserInfoModelImpl) then) =
      __$$UserInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "fname") String fname,
      @JsonKey(name: "sname") String sname,
      @JsonKey(name: "email", nullable: true, defaultValue: "") String email,
      @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
      String photoUrl,
      @JsonKey(name: "mobilephone", nullable: true, defaultValue: "")
      String? phone,
      @JsonKey(name: "dob", nullable: true, defaultValue: "") String? dob,
      @JsonKey(name: "gender", nullable: true, defaultValue: "") String? gender,
      @JsonKey(name: "plans", nullable: true, defaultValue: "") String? plans,
      @JsonKey(name: "current_balance", nullable: true, defaultValue: 0)
      double? currentBalance,
      @JsonKey(name: "gym", nullable: true) GymModel? gym,
      @JsonKey(name: "active_gyms", nullable: true, defaultValue: [])
      List<GymModel>? activeGyms,
      @JsonKey(name: "memberid") String memberId});

  @override
  $GymModelCopyWith<$Res>? get gym;
}

/// @nodoc
class __$$UserInfoModelImplCopyWithImpl<$Res>
    extends _$UserInfoModelCopyWithImpl<$Res, _$UserInfoModelImpl>
    implements _$$UserInfoModelImplCopyWith<$Res> {
  __$$UserInfoModelImplCopyWithImpl(
      _$UserInfoModelImpl _value, $Res Function(_$UserInfoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fname = null,
    Object? sname = null,
    Object? email = null,
    Object? photoUrl = null,
    Object? phone = freezed,
    Object? dob = freezed,
    Object? gender = freezed,
    Object? plans = freezed,
    Object? currentBalance = freezed,
    Object? gym = freezed,
    Object? activeGyms = freezed,
    Object? memberId = null,
  }) {
    return _then(_$UserInfoModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
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
      plans: freezed == plans
          ? _value.plans
          : plans // ignore: cast_nullable_to_non_nullable
              as String?,
      currentBalance: freezed == currentBalance
          ? _value.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as double?,
      gym: freezed == gym
          ? _value.gym
          : gym // ignore: cast_nullable_to_non_nullable
              as GymModel?,
      activeGyms: freezed == activeGyms
          ? _value.activeGyms
          : activeGyms // ignore: cast_nullable_to_non_nullable
              as List<GymModel>?,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$UserInfoModelImpl extends _UserInfoModel {
  _$UserInfoModelImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "fname") required this.fname,
      @JsonKey(name: "sname") required this.sname,
      @JsonKey(name: "email", nullable: true, defaultValue: "")
      required this.email,
      @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
      required this.photoUrl,
      @JsonKey(name: "mobilephone", nullable: true, defaultValue: "")
      required this.phone,
      @JsonKey(name: "dob", nullable: true, defaultValue: "") required this.dob,
      @JsonKey(name: "gender", nullable: true, defaultValue: "")
      required this.gender,
      @JsonKey(name: "plans", nullable: true, defaultValue: "")
      required this.plans,
      @JsonKey(name: "current_balance", nullable: true, defaultValue: 0)
      required this.currentBalance,
      @JsonKey(name: "gym", nullable: true) required this.gym,
      @JsonKey(name: "active_gyms", nullable: true, defaultValue: [])
      required this.activeGyms,
      @JsonKey(name: "memberid") required this.memberId})
      : super._();

  factory _$UserInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserInfoModelImplFromJson(json);

  @override
  @JsonKey(name: "id")
  int? id;
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
  @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
  String photoUrl;
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
  @JsonKey(name: "plans", nullable: true, defaultValue: "")
  String? plans;
  @override
  @JsonKey(name: "current_balance", nullable: true, defaultValue: 0)
  double? currentBalance;
  @override
  @JsonKey(name: "gym", nullable: true)
  GymModel? gym;
  @override
  @JsonKey(name: "active_gyms", nullable: true, defaultValue: [])
  List<GymModel>? activeGyms;
  @override
  @JsonKey(name: "memberid")
  String memberId;

  @override
  String toString() {
    return 'UserInfoModel(id: $id, fname: $fname, sname: $sname, email: $email, photoUrl: $photoUrl, phone: $phone, dob: $dob, gender: $gender, plans: $plans, currentBalance: $currentBalance, gym: $gym, activeGyms: $activeGyms, memberId: $memberId)';
  }

  /// Create a copy of UserInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserInfoModelImplCopyWith<_$UserInfoModelImpl> get copyWith =>
      __$$UserInfoModelImplCopyWithImpl<_$UserInfoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserInfoModelImplToJson(
      this,
    );
  }
}

abstract class _UserInfoModel extends UserInfoModel {
  factory _UserInfoModel(
          {@JsonKey(name: "id") required int? id,
          @JsonKey(name: "fname") required String fname,
          @JsonKey(name: "sname") required String sname,
          @JsonKey(name: "email", nullable: true, defaultValue: "")
          required String email,
          @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
          required String photoUrl,
          @JsonKey(name: "mobilephone", nullable: true, defaultValue: "")
          required String? phone,
          @JsonKey(name: "dob", nullable: true, defaultValue: "")
          required String? dob,
          @JsonKey(name: "gender", nullable: true, defaultValue: "")
          required String? gender,
          @JsonKey(name: "plans", nullable: true, defaultValue: "")
          required String? plans,
          @JsonKey(name: "current_balance", nullable: true, defaultValue: 0)
          required double? currentBalance,
          @JsonKey(name: "gym", nullable: true) required GymModel? gym,
          @JsonKey(name: "active_gyms", nullable: true, defaultValue: [])
          required List<GymModel>? activeGyms,
          @JsonKey(name: "memberid") required String memberId}) =
      _$UserInfoModelImpl;
  _UserInfoModel._() : super._();

  factory _UserInfoModel.fromJson(Map<String, dynamic> json) =
      _$UserInfoModelImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @JsonKey(name: "id")
  set id(int? value);
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
  @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
  String get photoUrl;
  @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
  set photoUrl(String value);
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
  @JsonKey(name: "plans", nullable: true, defaultValue: "")
  String? get plans;
  @JsonKey(name: "plans", nullable: true, defaultValue: "")
  set plans(String? value);
  @override
  @JsonKey(name: "current_balance", nullable: true, defaultValue: 0)
  double? get currentBalance;
  @JsonKey(name: "current_balance", nullable: true, defaultValue: 0)
  set currentBalance(double? value);
  @override
  @JsonKey(name: "gym", nullable: true)
  GymModel? get gym;
  @JsonKey(name: "gym", nullable: true)
  set gym(GymModel? value);
  @override
  @JsonKey(name: "active_gyms", nullable: true, defaultValue: [])
  List<GymModel>? get activeGyms;
  @JsonKey(name: "active_gyms", nullable: true, defaultValue: [])
  set activeGyms(List<GymModel>? value);
  @override
  @JsonKey(name: "memberid")
  String get memberId;
  @JsonKey(name: "memberid")
  set memberId(String value);

  /// Create a copy of UserInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserInfoModelImplCopyWith<_$UserInfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
