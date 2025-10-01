// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gym_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GymModel _$GymModelFromJson(Map<String, dynamic> json) {
  return _GymModel.fromJson(json);
}

/// @nodoc
mixin _$GymModel {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "id")
  set id(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "member_id")
  int? get memberId => throw _privateConstructorUsedError;
  @JsonKey(name: "member_id")
  set memberId(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  set name(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "logo")
  String? get logo => throw _privateConstructorUsedError;
  @JsonKey(name: "logo")
  set logo(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "logo_url")
  String? get logoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: "logo_url")
  set logoUrl(String? value) => throw _privateConstructorUsedError;

  /// Serializes this GymModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GymModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GymModelCopyWith<GymModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GymModelCopyWith<$Res> {
  factory $GymModelCopyWith(GymModel value, $Res Function(GymModel) then) =
      _$GymModelCopyWithImpl<$Res, GymModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "member_id") int? memberId,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "logo") String? logo,
      @JsonKey(name: "logo_url") String? logoUrl});
}

/// @nodoc
class _$GymModelCopyWithImpl<$Res, $Val extends GymModel>
    implements $GymModelCopyWith<$Res> {
  _$GymModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GymModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? memberId = freezed,
    Object? name = freezed,
    Object? logo = freezed,
    Object? logoUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GymModelImplCopyWith<$Res>
    implements $GymModelCopyWith<$Res> {
  factory _$$GymModelImplCopyWith(
          _$GymModelImpl value, $Res Function(_$GymModelImpl) then) =
      __$$GymModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "member_id") int? memberId,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "logo") String? logo,
      @JsonKey(name: "logo_url") String? logoUrl});
}

/// @nodoc
class __$$GymModelImplCopyWithImpl<$Res>
    extends _$GymModelCopyWithImpl<$Res, _$GymModelImpl>
    implements _$$GymModelImplCopyWith<$Res> {
  __$$GymModelImplCopyWithImpl(
      _$GymModelImpl _value, $Res Function(_$GymModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GymModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? memberId = freezed,
    Object? name = freezed,
    Object? logo = freezed,
    Object? logoUrl = freezed,
  }) {
    return _then(_$GymModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$GymModelImpl extends _GymModel {
  _$GymModelImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "member_id") required this.memberId,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "logo") required this.logo,
      @JsonKey(name: "logo_url") required this.logoUrl})
      : super._();

  factory _$GymModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GymModelImplFromJson(json);

  @override
  @JsonKey(name: "id")
  int? id;
  @override
  @JsonKey(name: "member_id")
  int? memberId;
  @override
  @JsonKey(name: "name")
  String? name;
  @override
  @JsonKey(name: "logo")
  String? logo;
  @override
  @JsonKey(name: "logo_url")
  String? logoUrl;

  @override
  String toString() {
    return 'GymModel(id: $id, memberId: $memberId, name: $name, logo: $logo, logoUrl: $logoUrl)';
  }

  /// Create a copy of GymModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GymModelImplCopyWith<_$GymModelImpl> get copyWith =>
      __$$GymModelImplCopyWithImpl<_$GymModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GymModelImplToJson(
      this,
    );
  }
}

abstract class _GymModel extends GymModel {
  factory _GymModel(
      {@JsonKey(name: "id") required int? id,
      @JsonKey(name: "member_id") required int? memberId,
      @JsonKey(name: "name") required String? name,
      @JsonKey(name: "logo") required String? logo,
      @JsonKey(name: "logo_url") required String? logoUrl}) = _$GymModelImpl;
  _GymModel._() : super._();

  factory _GymModel.fromJson(Map<String, dynamic> json) =
      _$GymModelImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @JsonKey(name: "id")
  set id(int? value);
  @override
  @JsonKey(name: "member_id")
  int? get memberId;
  @JsonKey(name: "member_id")
  set memberId(int? value);
  @override
  @JsonKey(name: "name")
  String? get name;
  @JsonKey(name: "name")
  set name(String? value);
  @override
  @JsonKey(name: "logo")
  String? get logo;
  @JsonKey(name: "logo")
  set logo(String? value);
  @override
  @JsonKey(name: "logo_url")
  String? get logoUrl;
  @JsonKey(name: "logo_url")
  set logoUrl(String? value);

  /// Create a copy of GymModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GymModelImplCopyWith<_$GymModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
