// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trainer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrainerModel _$TrainerModelFromJson(Map<String, dynamic> json) {
  return _TrainerModel.fromJson(json);
}

/// @nodoc
mixin _$TrainerModel {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "id")
  set id(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  set title(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "full_name")
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: "full_name")
  set name(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
  String? get photoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
  set photoUrl(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "min_slot_duration")
  int? get minSlotDuration => throw _privateConstructorUsedError;
  @JsonKey(name: "min_slot_duration")
  set minSlotDuration(int? value) =>
      throw _privateConstructorUsedError; // @JsonKey(name: "openTimesPerDay", nullable: true) required Map<String, DateModel>? openTimesPerDay,
  @JsonKey(name: "openTimesPerDay", nullable: true)
  List<DateModel>? get openTimesPerDay =>
      throw _privateConstructorUsedError; // @JsonKey(name: "openTimesPerDay", nullable: true) required Map<String, DateModel>? openTimesPerDay,
  @JsonKey(name: "openTimesPerDay", nullable: true)
  set openTimesPerDay(List<DateModel>? value) =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "businessHours", nullable: true)
  DateModel? get businessHours => throw _privateConstructorUsedError;
  @JsonKey(name: "businessHours", nullable: true)
  set businessHours(DateModel? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "profile", nullable: true)
  TrainerProfileModel? get profile => throw _privateConstructorUsedError;
  @JsonKey(name: "profile", nullable: true)
  set profile(TrainerProfileModel? value) => throw _privateConstructorUsedError;

  /// Serializes this TrainerModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrainerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrainerModelCopyWith<TrainerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainerModelCopyWith<$Res> {
  factory $TrainerModelCopyWith(
          TrainerModel value, $Res Function(TrainerModel) then) =
      _$TrainerModelCopyWithImpl<$Res, TrainerModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "full_name") String? name,
      @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
      String? photoUrl,
      @JsonKey(name: "min_slot_duration") int? minSlotDuration,
      @JsonKey(name: "openTimesPerDay", nullable: true)
      List<DateModel>? openTimesPerDay,
      @JsonKey(name: "businessHours", nullable: true) DateModel? businessHours,
      @JsonKey(name: "profile", nullable: true) TrainerProfileModel? profile});

  $DateModelCopyWith<$Res>? get businessHours;
  $TrainerProfileModelCopyWith<$Res>? get profile;
}

/// @nodoc
class _$TrainerModelCopyWithImpl<$Res, $Val extends TrainerModel>
    implements $TrainerModelCopyWith<$Res> {
  _$TrainerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrainerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? name = freezed,
    Object? photoUrl = freezed,
    Object? minSlotDuration = freezed,
    Object? openTimesPerDay = freezed,
    Object? businessHours = freezed,
    Object? profile = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      minSlotDuration: freezed == minSlotDuration
          ? _value.minSlotDuration
          : minSlotDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      openTimesPerDay: freezed == openTimesPerDay
          ? _value.openTimesPerDay
          : openTimesPerDay // ignore: cast_nullable_to_non_nullable
              as List<DateModel>?,
      businessHours: freezed == businessHours
          ? _value.businessHours
          : businessHours // ignore: cast_nullable_to_non_nullable
              as DateModel?,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as TrainerProfileModel?,
    ) as $Val);
  }

  /// Create a copy of TrainerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DateModelCopyWith<$Res>? get businessHours {
    if (_value.businessHours == null) {
      return null;
    }

    return $DateModelCopyWith<$Res>(_value.businessHours!, (value) {
      return _then(_value.copyWith(businessHours: value) as $Val);
    });
  }

  /// Create a copy of TrainerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TrainerProfileModelCopyWith<$Res>? get profile {
    if (_value.profile == null) {
      return null;
    }

    return $TrainerProfileModelCopyWith<$Res>(_value.profile!, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TrainerModelImplCopyWith<$Res>
    implements $TrainerModelCopyWith<$Res> {
  factory _$$TrainerModelImplCopyWith(
          _$TrainerModelImpl value, $Res Function(_$TrainerModelImpl) then) =
      __$$TrainerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "full_name") String? name,
      @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
      String? photoUrl,
      @JsonKey(name: "min_slot_duration") int? minSlotDuration,
      @JsonKey(name: "openTimesPerDay", nullable: true)
      List<DateModel>? openTimesPerDay,
      @JsonKey(name: "businessHours", nullable: true) DateModel? businessHours,
      @JsonKey(name: "profile", nullable: true) TrainerProfileModel? profile});

  @override
  $DateModelCopyWith<$Res>? get businessHours;
  @override
  $TrainerProfileModelCopyWith<$Res>? get profile;
}

/// @nodoc
class __$$TrainerModelImplCopyWithImpl<$Res>
    extends _$TrainerModelCopyWithImpl<$Res, _$TrainerModelImpl>
    implements _$$TrainerModelImplCopyWith<$Res> {
  __$$TrainerModelImplCopyWithImpl(
      _$TrainerModelImpl _value, $Res Function(_$TrainerModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TrainerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? name = freezed,
    Object? photoUrl = freezed,
    Object? minSlotDuration = freezed,
    Object? openTimesPerDay = freezed,
    Object? businessHours = freezed,
    Object? profile = freezed,
  }) {
    return _then(_$TrainerModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      minSlotDuration: freezed == minSlotDuration
          ? _value.minSlotDuration
          : minSlotDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      openTimesPerDay: freezed == openTimesPerDay
          ? _value.openTimesPerDay
          : openTimesPerDay // ignore: cast_nullable_to_non_nullable
              as List<DateModel>?,
      businessHours: freezed == businessHours
          ? _value.businessHours
          : businessHours // ignore: cast_nullable_to_non_nullable
              as DateModel?,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as TrainerProfileModel?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TrainerModelImpl extends _TrainerModel {
  _$TrainerModelImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "title") required this.title,
      @JsonKey(name: "full_name") required this.name,
      @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
      required this.photoUrl,
      @JsonKey(name: "min_slot_duration") required this.minSlotDuration,
      @JsonKey(name: "openTimesPerDay", nullable: true)
      required this.openTimesPerDay,
      @JsonKey(name: "businessHours", nullable: true)
      required this.businessHours,
      @JsonKey(name: "profile", nullable: true) required this.profile})
      : super._();

  factory _$TrainerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrainerModelImplFromJson(json);

  @override
  @JsonKey(name: "id")
  int? id;
  @override
  @JsonKey(name: "title")
  String? title;
  @override
  @JsonKey(name: "full_name")
  String? name;
  @override
  @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
  String? photoUrl;
  @override
  @JsonKey(name: "min_slot_duration")
  int? minSlotDuration;
// @JsonKey(name: "openTimesPerDay", nullable: true) required Map<String, DateModel>? openTimesPerDay,
  @override
  @JsonKey(name: "openTimesPerDay", nullable: true)
  List<DateModel>? openTimesPerDay;
  @override
  @JsonKey(name: "businessHours", nullable: true)
  DateModel? businessHours;
  @override
  @JsonKey(name: "profile", nullable: true)
  TrainerProfileModel? profile;

  @override
  String toString() {
    return 'TrainerModel(id: $id, title: $title, name: $name, photoUrl: $photoUrl, minSlotDuration: $minSlotDuration, openTimesPerDay: $openTimesPerDay, businessHours: $businessHours, profile: $profile)';
  }

  /// Create a copy of TrainerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainerModelImplCopyWith<_$TrainerModelImpl> get copyWith =>
      __$$TrainerModelImplCopyWithImpl<_$TrainerModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrainerModelImplToJson(
      this,
    );
  }
}

abstract class _TrainerModel extends TrainerModel {
  factory _TrainerModel(
      {@JsonKey(name: "id") required int? id,
      @JsonKey(name: "title") required String? title,
      @JsonKey(name: "full_name") required String? name,
      @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
      required String? photoUrl,
      @JsonKey(name: "min_slot_duration") required int? minSlotDuration,
      @JsonKey(name: "openTimesPerDay", nullable: true)
      required List<DateModel>? openTimesPerDay,
      @JsonKey(name: "businessHours", nullable: true)
      required DateModel? businessHours,
      @JsonKey(name: "profile", nullable: true)
      required TrainerProfileModel? profile}) = _$TrainerModelImpl;
  _TrainerModel._() : super._();

  factory _TrainerModel.fromJson(Map<String, dynamic> json) =
      _$TrainerModelImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @JsonKey(name: "id")
  set id(int? value);
  @override
  @JsonKey(name: "title")
  String? get title;
  @JsonKey(name: "title")
  set title(String? value);
  @override
  @JsonKey(name: "full_name")
  String? get name;
  @JsonKey(name: "full_name")
  set name(String? value);
  @override
  @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
  String? get photoUrl;
  @JsonKey(name: "photo_url", nullable: true, defaultValue: "")
  set photoUrl(String? value);
  @override
  @JsonKey(name: "min_slot_duration")
  int? get minSlotDuration;
  @JsonKey(name: "min_slot_duration")
  set minSlotDuration(
      int?
          value); // @JsonKey(name: "openTimesPerDay", nullable: true) required Map<String, DateModel>? openTimesPerDay,
  @override
  @JsonKey(name: "openTimesPerDay", nullable: true)
  List<DateModel>?
      get openTimesPerDay; // @JsonKey(name: "openTimesPerDay", nullable: true) required Map<String, DateModel>? openTimesPerDay,
  @JsonKey(name: "openTimesPerDay", nullable: true)
  set openTimesPerDay(List<DateModel>? value);
  @override
  @JsonKey(name: "businessHours", nullable: true)
  DateModel? get businessHours;
  @JsonKey(name: "businessHours", nullable: true)
  set businessHours(DateModel? value);
  @override
  @JsonKey(name: "profile", nullable: true)
  TrainerProfileModel? get profile;
  @JsonKey(name: "profile", nullable: true)
  set profile(TrainerProfileModel? value);

  /// Create a copy of TrainerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrainerModelImplCopyWith<_$TrainerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
