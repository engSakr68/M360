// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'view_port_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ViewPortModel _$ViewPortModelFromJson(Map<String, dynamic> json) {
  return _ViewPortModel.fromJson(json);
}

/// @nodoc
mixin _$ViewPortModel {
  @JsonKey(name: "northeast")
  LocationModel get northeast => throw _privateConstructorUsedError;
  @JsonKey(name: "northeast")
  set northeast(LocationModel value) => throw _privateConstructorUsedError;
  @JsonKey(name: "southwest")
  LocationModel get southwest => throw _privateConstructorUsedError;
  @JsonKey(name: "southwest")
  set southwest(LocationModel value) => throw _privateConstructorUsedError;

  /// Serializes this ViewPortModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ViewPortModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ViewPortModelCopyWith<ViewPortModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ViewPortModelCopyWith<$Res> {
  factory $ViewPortModelCopyWith(
          ViewPortModel value, $Res Function(ViewPortModel) then) =
      _$ViewPortModelCopyWithImpl<$Res, ViewPortModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "northeast") LocationModel northeast,
      @JsonKey(name: "southwest") LocationModel southwest});

  $LocationModelCopyWith<$Res> get northeast;
  $LocationModelCopyWith<$Res> get southwest;
}

/// @nodoc
class _$ViewPortModelCopyWithImpl<$Res, $Val extends ViewPortModel>
    implements $ViewPortModelCopyWith<$Res> {
  _$ViewPortModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ViewPortModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? northeast = null,
    Object? southwest = null,
  }) {
    return _then(_value.copyWith(
      northeast: null == northeast
          ? _value.northeast
          : northeast // ignore: cast_nullable_to_non_nullable
              as LocationModel,
      southwest: null == southwest
          ? _value.southwest
          : southwest // ignore: cast_nullable_to_non_nullable
              as LocationModel,
    ) as $Val);
  }

  /// Create a copy of ViewPortModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationModelCopyWith<$Res> get northeast {
    return $LocationModelCopyWith<$Res>(_value.northeast, (value) {
      return _then(_value.copyWith(northeast: value) as $Val);
    });
  }

  /// Create a copy of ViewPortModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationModelCopyWith<$Res> get southwest {
    return $LocationModelCopyWith<$Res>(_value.southwest, (value) {
      return _then(_value.copyWith(southwest: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ViewPortModelImplCopyWith<$Res>
    implements $ViewPortModelCopyWith<$Res> {
  factory _$$ViewPortModelImplCopyWith(
          _$ViewPortModelImpl value, $Res Function(_$ViewPortModelImpl) then) =
      __$$ViewPortModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "northeast") LocationModel northeast,
      @JsonKey(name: "southwest") LocationModel southwest});

  @override
  $LocationModelCopyWith<$Res> get northeast;
  @override
  $LocationModelCopyWith<$Res> get southwest;
}

/// @nodoc
class __$$ViewPortModelImplCopyWithImpl<$Res>
    extends _$ViewPortModelCopyWithImpl<$Res, _$ViewPortModelImpl>
    implements _$$ViewPortModelImplCopyWith<$Res> {
  __$$ViewPortModelImplCopyWithImpl(
      _$ViewPortModelImpl _value, $Res Function(_$ViewPortModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ViewPortModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? northeast = null,
    Object? southwest = null,
  }) {
    return _then(_$ViewPortModelImpl(
      northeast: null == northeast
          ? _value.northeast
          : northeast // ignore: cast_nullable_to_non_nullable
              as LocationModel,
      southwest: null == southwest
          ? _value.southwest
          : southwest // ignore: cast_nullable_to_non_nullable
              as LocationModel,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ViewPortModelImpl extends _ViewPortModel {
  _$ViewPortModelImpl(
      {@JsonKey(name: "northeast") required this.northeast,
      @JsonKey(name: "southwest") required this.southwest})
      : super._();

  factory _$ViewPortModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ViewPortModelImplFromJson(json);

  @override
  @JsonKey(name: "northeast")
  LocationModel northeast;
  @override
  @JsonKey(name: "southwest")
  LocationModel southwest;

  @override
  String toString() {
    return 'ViewPortModel(northeast: $northeast, southwest: $southwest)';
  }

  /// Create a copy of ViewPortModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ViewPortModelImplCopyWith<_$ViewPortModelImpl> get copyWith =>
      __$$ViewPortModelImplCopyWithImpl<_$ViewPortModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ViewPortModelImplToJson(
      this,
    );
  }
}

abstract class _ViewPortModel extends ViewPortModel {
  factory _ViewPortModel(
          {@JsonKey(name: "northeast") required LocationModel northeast,
          @JsonKey(name: "southwest") required LocationModel southwest}) =
      _$ViewPortModelImpl;
  _ViewPortModel._() : super._();

  factory _ViewPortModel.fromJson(Map<String, dynamic> json) =
      _$ViewPortModelImpl.fromJson;

  @override
  @JsonKey(name: "northeast")
  LocationModel get northeast;
  @JsonKey(name: "northeast")
  set northeast(LocationModel value);
  @override
  @JsonKey(name: "southwest")
  LocationModel get southwest;
  @JsonKey(name: "southwest")
  set southwest(LocationModel value);

  /// Create a copy of ViewPortModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ViewPortModelImplCopyWith<_$ViewPortModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
