// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) {
  return _PlaceModel.fromJson(json);
}

/// @nodoc
mixin _$PlaceModel {
  @JsonKey(name: "geometry")
  GeometryModel get geometry => throw _privateConstructorUsedError;
  @JsonKey(name: "geometry")
  set geometry(GeometryModel value) => throw _privateConstructorUsedError;
  @JsonKey(name: "icon")
  String get icon => throw _privateConstructorUsedError;
  @JsonKey(name: "icon")
  set icon(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: "icon_background_color")
  String get iconBackgroundColor => throw _privateConstructorUsedError;
  @JsonKey(name: "icon_background_color")
  set iconBackgroundColor(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: "icon_mask_base_uri")
  String get iconMaskBaseUri => throw _privateConstructorUsedError;
  @JsonKey(name: "icon_mask_base_uri")
  set iconMaskBaseUri(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  set name(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: "photos")
  List<PhotoModel>? get photos => throw _privateConstructorUsedError;
  @JsonKey(name: "photos")
  set photos(List<PhotoModel>? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "place_id")
  String get placeId => throw _privateConstructorUsedError;
  @JsonKey(name: "place_id")
  set placeId(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: "reference")
  String get reference => throw _privateConstructorUsedError;
  @JsonKey(name: "reference")
  set reference(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: "scope")
  String? get scope => throw _privateConstructorUsedError;
  @JsonKey(name: "scope")
  set scope(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "types")
  List<String> get types => throw _privateConstructorUsedError;
  @JsonKey(name: "types")
  set types(List<String> value) => throw _privateConstructorUsedError;
  @JsonKey(name: "vicinity")
  String get vicinity => throw _privateConstructorUsedError;
  @JsonKey(name: "vicinity")
  set vicinity(String value) => throw _privateConstructorUsedError;

  /// Serializes this PlaceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlaceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaceModelCopyWith<PlaceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceModelCopyWith<$Res> {
  factory $PlaceModelCopyWith(
          PlaceModel value, $Res Function(PlaceModel) then) =
      _$PlaceModelCopyWithImpl<$Res, PlaceModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "geometry") GeometryModel geometry,
      @JsonKey(name: "icon") String icon,
      @JsonKey(name: "icon_background_color") String iconBackgroundColor,
      @JsonKey(name: "icon_mask_base_uri") String iconMaskBaseUri,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "photos") List<PhotoModel>? photos,
      @JsonKey(name: "place_id") String placeId,
      @JsonKey(name: "reference") String reference,
      @JsonKey(name: "scope") String? scope,
      @JsonKey(name: "types") List<String> types,
      @JsonKey(name: "vicinity") String vicinity});

  $GeometryModelCopyWith<$Res> get geometry;
}

/// @nodoc
class _$PlaceModelCopyWithImpl<$Res, $Val extends PlaceModel>
    implements $PlaceModelCopyWith<$Res> {
  _$PlaceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geometry = null,
    Object? icon = null,
    Object? iconBackgroundColor = null,
    Object? iconMaskBaseUri = null,
    Object? name = null,
    Object? photos = freezed,
    Object? placeId = null,
    Object? reference = null,
    Object? scope = freezed,
    Object? types = null,
    Object? vicinity = null,
  }) {
    return _then(_value.copyWith(
      geometry: null == geometry
          ? _value.geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as GeometryModel,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      iconBackgroundColor: null == iconBackgroundColor
          ? _value.iconBackgroundColor
          : iconBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String,
      iconMaskBaseUri: null == iconMaskBaseUri
          ? _value.iconMaskBaseUri
          : iconMaskBaseUri // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photos: freezed == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<PhotoModel>?,
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
      scope: freezed == scope
          ? _value.scope
          : scope // ignore: cast_nullable_to_non_nullable
              as String?,
      types: null == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<String>,
      vicinity: null == vicinity
          ? _value.vicinity
          : vicinity // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of PlaceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GeometryModelCopyWith<$Res> get geometry {
    return $GeometryModelCopyWith<$Res>(_value.geometry, (value) {
      return _then(_value.copyWith(geometry: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlaceModelImplCopyWith<$Res>
    implements $PlaceModelCopyWith<$Res> {
  factory _$$PlaceModelImplCopyWith(
          _$PlaceModelImpl value, $Res Function(_$PlaceModelImpl) then) =
      __$$PlaceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "geometry") GeometryModel geometry,
      @JsonKey(name: "icon") String icon,
      @JsonKey(name: "icon_background_color") String iconBackgroundColor,
      @JsonKey(name: "icon_mask_base_uri") String iconMaskBaseUri,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "photos") List<PhotoModel>? photos,
      @JsonKey(name: "place_id") String placeId,
      @JsonKey(name: "reference") String reference,
      @JsonKey(name: "scope") String? scope,
      @JsonKey(name: "types") List<String> types,
      @JsonKey(name: "vicinity") String vicinity});

  @override
  $GeometryModelCopyWith<$Res> get geometry;
}

/// @nodoc
class __$$PlaceModelImplCopyWithImpl<$Res>
    extends _$PlaceModelCopyWithImpl<$Res, _$PlaceModelImpl>
    implements _$$PlaceModelImplCopyWith<$Res> {
  __$$PlaceModelImplCopyWithImpl(
      _$PlaceModelImpl _value, $Res Function(_$PlaceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlaceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geometry = null,
    Object? icon = null,
    Object? iconBackgroundColor = null,
    Object? iconMaskBaseUri = null,
    Object? name = null,
    Object? photos = freezed,
    Object? placeId = null,
    Object? reference = null,
    Object? scope = freezed,
    Object? types = null,
    Object? vicinity = null,
  }) {
    return _then(_$PlaceModelImpl(
      geometry: null == geometry
          ? _value.geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as GeometryModel,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      iconBackgroundColor: null == iconBackgroundColor
          ? _value.iconBackgroundColor
          : iconBackgroundColor // ignore: cast_nullable_to_non_nullable
              as String,
      iconMaskBaseUri: null == iconMaskBaseUri
          ? _value.iconMaskBaseUri
          : iconMaskBaseUri // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photos: freezed == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<PhotoModel>?,
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
      scope: freezed == scope
          ? _value.scope
          : scope // ignore: cast_nullable_to_non_nullable
              as String?,
      types: null == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<String>,
      vicinity: null == vicinity
          ? _value.vicinity
          : vicinity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$PlaceModelImpl extends _PlaceModel {
  _$PlaceModelImpl(
      {@JsonKey(name: "geometry") required this.geometry,
      @JsonKey(name: "icon") required this.icon,
      @JsonKey(name: "icon_background_color") required this.iconBackgroundColor,
      @JsonKey(name: "icon_mask_base_uri") required this.iconMaskBaseUri,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "photos") required this.photos,
      @JsonKey(name: "place_id") required this.placeId,
      @JsonKey(name: "reference") required this.reference,
      @JsonKey(name: "scope") required this.scope,
      @JsonKey(name: "types") required this.types,
      @JsonKey(name: "vicinity") required this.vicinity})
      : super._();

  factory _$PlaceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaceModelImplFromJson(json);

  @override
  @JsonKey(name: "geometry")
  GeometryModel geometry;
  @override
  @JsonKey(name: "icon")
  String icon;
  @override
  @JsonKey(name: "icon_background_color")
  String iconBackgroundColor;
  @override
  @JsonKey(name: "icon_mask_base_uri")
  String iconMaskBaseUri;
  @override
  @JsonKey(name: "name")
  String name;
  @override
  @JsonKey(name: "photos")
  List<PhotoModel>? photos;
  @override
  @JsonKey(name: "place_id")
  String placeId;
  @override
  @JsonKey(name: "reference")
  String reference;
  @override
  @JsonKey(name: "scope")
  String? scope;
  @override
  @JsonKey(name: "types")
  List<String> types;
  @override
  @JsonKey(name: "vicinity")
  String vicinity;

  @override
  String toString() {
    return 'PlaceModel(geometry: $geometry, icon: $icon, iconBackgroundColor: $iconBackgroundColor, iconMaskBaseUri: $iconMaskBaseUri, name: $name, photos: $photos, placeId: $placeId, reference: $reference, scope: $scope, types: $types, vicinity: $vicinity)';
  }

  /// Create a copy of PlaceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaceModelImplCopyWith<_$PlaceModelImpl> get copyWith =>
      __$$PlaceModelImplCopyWithImpl<_$PlaceModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaceModelImplToJson(
      this,
    );
  }
}

abstract class _PlaceModel extends PlaceModel {
  factory _PlaceModel(
      {@JsonKey(name: "geometry") required GeometryModel geometry,
      @JsonKey(name: "icon") required String icon,
      @JsonKey(name: "icon_background_color")
      required String iconBackgroundColor,
      @JsonKey(name: "icon_mask_base_uri") required String iconMaskBaseUri,
      @JsonKey(name: "name") required String name,
      @JsonKey(name: "photos") required List<PhotoModel>? photos,
      @JsonKey(name: "place_id") required String placeId,
      @JsonKey(name: "reference") required String reference,
      @JsonKey(name: "scope") required String? scope,
      @JsonKey(name: "types") required List<String> types,
      @JsonKey(name: "vicinity") required String vicinity}) = _$PlaceModelImpl;
  _PlaceModel._() : super._();

  factory _PlaceModel.fromJson(Map<String, dynamic> json) =
      _$PlaceModelImpl.fromJson;

  @override
  @JsonKey(name: "geometry")
  GeometryModel get geometry;
  @JsonKey(name: "geometry")
  set geometry(GeometryModel value);
  @override
  @JsonKey(name: "icon")
  String get icon;
  @JsonKey(name: "icon")
  set icon(String value);
  @override
  @JsonKey(name: "icon_background_color")
  String get iconBackgroundColor;
  @JsonKey(name: "icon_background_color")
  set iconBackgroundColor(String value);
  @override
  @JsonKey(name: "icon_mask_base_uri")
  String get iconMaskBaseUri;
  @JsonKey(name: "icon_mask_base_uri")
  set iconMaskBaseUri(String value);
  @override
  @JsonKey(name: "name")
  String get name;
  @JsonKey(name: "name")
  set name(String value);
  @override
  @JsonKey(name: "photos")
  List<PhotoModel>? get photos;
  @JsonKey(name: "photos")
  set photos(List<PhotoModel>? value);
  @override
  @JsonKey(name: "place_id")
  String get placeId;
  @JsonKey(name: "place_id")
  set placeId(String value);
  @override
  @JsonKey(name: "reference")
  String get reference;
  @JsonKey(name: "reference")
  set reference(String value);
  @override
  @JsonKey(name: "scope")
  String? get scope;
  @JsonKey(name: "scope")
  set scope(String? value);
  @override
  @JsonKey(name: "types")
  List<String> get types;
  @JsonKey(name: "types")
  set types(List<String> value);
  @override
  @JsonKey(name: "vicinity")
  String get vicinity;
  @JsonKey(name: "vicinity")
  set vicinity(String value);

  /// Create a copy of PlaceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaceModelImplCopyWith<_$PlaceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
