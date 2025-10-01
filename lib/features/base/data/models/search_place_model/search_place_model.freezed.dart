// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_place_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SearchPlaceModel _$SearchPlaceModelFromJson(Map<String, dynamic> json) {
  return _SearchPlaceModel.fromJson(json);
}

/// @nodoc
mixin _$SearchPlaceModel {
  @JsonKey(name: "description")
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: "description")
  set description(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: "place_id")
  String get placeId => throw _privateConstructorUsedError;
  @JsonKey(name: "place_id")
  set placeId(String value) => throw _privateConstructorUsedError;

  /// Serializes this SearchPlaceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchPlaceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchPlaceModelCopyWith<SearchPlaceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchPlaceModelCopyWith<$Res> {
  factory $SearchPlaceModelCopyWith(
          SearchPlaceModel value, $Res Function(SearchPlaceModel) then) =
      _$SearchPlaceModelCopyWithImpl<$Res, SearchPlaceModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "description") String description,
      @JsonKey(name: "place_id") String placeId});
}

/// @nodoc
class _$SearchPlaceModelCopyWithImpl<$Res, $Val extends SearchPlaceModel>
    implements $SearchPlaceModelCopyWith<$Res> {
  _$SearchPlaceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchPlaceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? placeId = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchPlaceModelImplCopyWith<$Res>
    implements $SearchPlaceModelCopyWith<$Res> {
  factory _$$SearchPlaceModelImplCopyWith(_$SearchPlaceModelImpl value,
          $Res Function(_$SearchPlaceModelImpl) then) =
      __$$SearchPlaceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "description") String description,
      @JsonKey(name: "place_id") String placeId});
}

/// @nodoc
class __$$SearchPlaceModelImplCopyWithImpl<$Res>
    extends _$SearchPlaceModelCopyWithImpl<$Res, _$SearchPlaceModelImpl>
    implements _$$SearchPlaceModelImplCopyWith<$Res> {
  __$$SearchPlaceModelImplCopyWithImpl(_$SearchPlaceModelImpl _value,
      $Res Function(_$SearchPlaceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchPlaceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? placeId = null,
  }) {
    return _then(_$SearchPlaceModelImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$SearchPlaceModelImpl extends _SearchPlaceModel {
  _$SearchPlaceModelImpl(
      {@JsonKey(name: "description") required this.description,
      @JsonKey(name: "place_id") required this.placeId})
      : super._();

  factory _$SearchPlaceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchPlaceModelImplFromJson(json);

  @override
  @JsonKey(name: "description")
  String description;
  @override
  @JsonKey(name: "place_id")
  String placeId;

  @override
  String toString() {
    return 'SearchPlaceModel(description: $description, placeId: $placeId)';
  }

  /// Create a copy of SearchPlaceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchPlaceModelImplCopyWith<_$SearchPlaceModelImpl> get copyWith =>
      __$$SearchPlaceModelImplCopyWithImpl<_$SearchPlaceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchPlaceModelImplToJson(
      this,
    );
  }
}

abstract class _SearchPlaceModel extends SearchPlaceModel {
  factory _SearchPlaceModel(
          {@JsonKey(name: "description") required String description,
          @JsonKey(name: "place_id") required String placeId}) =
      _$SearchPlaceModelImpl;
  _SearchPlaceModel._() : super._();

  factory _SearchPlaceModel.fromJson(Map<String, dynamic> json) =
      _$SearchPlaceModelImpl.fromJson;

  @override
  @JsonKey(name: "description")
  String get description;
  @JsonKey(name: "description")
  set description(String value);
  @override
  @JsonKey(name: "place_id")
  String get placeId;
  @JsonKey(name: "place_id")
  set placeId(String value);

  /// Create a copy of SearchPlaceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchPlaceModelImplCopyWith<_$SearchPlaceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
