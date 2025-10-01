// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TagModel _$TagModelFromJson(Map<String, dynamic> json) {
  return _TagModel.fromJson(json);
}

/// @nodoc
mixin _$TagModel {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "id")
  set id(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  NameModel? get name => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  set name(NameModel? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "slug")
  NameModel? get slug => throw _privateConstructorUsedError;
  @JsonKey(name: "slug")
  set slug(NameModel? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "type")
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: "type")
  set type(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "order_column")
  int? get orderColumn => throw _privateConstructorUsedError;
  @JsonKey(name: "order_column")
  set orderColumn(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  set createdAt(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "updated_at")
  String? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updated_at")
  set updatedAt(String? value) => throw _privateConstructorUsedError;

  /// Serializes this TagModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TagModelCopyWith<TagModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagModelCopyWith<$Res> {
  factory $TagModelCopyWith(TagModel value, $Res Function(TagModel) then) =
      _$TagModelCopyWithImpl<$Res, TagModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") NameModel? name,
      @JsonKey(name: "slug") NameModel? slug,
      @JsonKey(name: "type") String? type,
      @JsonKey(name: "order_column") int? orderColumn,
      @JsonKey(name: "created_at") String? createdAt,
      @JsonKey(name: "updated_at") String? updatedAt});

  $NameModelCopyWith<$Res>? get name;
  $NameModelCopyWith<$Res>? get slug;
}

/// @nodoc
class _$TagModelCopyWithImpl<$Res, $Val extends TagModel>
    implements $TagModelCopyWith<$Res> {
  _$TagModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? slug = freezed,
    Object? type = freezed,
    Object? orderColumn = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as NameModel?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as NameModel?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      orderColumn: freezed == orderColumn
          ? _value.orderColumn
          : orderColumn // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NameModelCopyWith<$Res>? get name {
    if (_value.name == null) {
      return null;
    }

    return $NameModelCopyWith<$Res>(_value.name!, (value) {
      return _then(_value.copyWith(name: value) as $Val);
    });
  }

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NameModelCopyWith<$Res>? get slug {
    if (_value.slug == null) {
      return null;
    }

    return $NameModelCopyWith<$Res>(_value.slug!, (value) {
      return _then(_value.copyWith(slug: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TagModelImplCopyWith<$Res>
    implements $TagModelCopyWith<$Res> {
  factory _$$TagModelImplCopyWith(
          _$TagModelImpl value, $Res Function(_$TagModelImpl) then) =
      __$$TagModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") NameModel? name,
      @JsonKey(name: "slug") NameModel? slug,
      @JsonKey(name: "type") String? type,
      @JsonKey(name: "order_column") int? orderColumn,
      @JsonKey(name: "created_at") String? createdAt,
      @JsonKey(name: "updated_at") String? updatedAt});

  @override
  $NameModelCopyWith<$Res>? get name;
  @override
  $NameModelCopyWith<$Res>? get slug;
}

/// @nodoc
class __$$TagModelImplCopyWithImpl<$Res>
    extends _$TagModelCopyWithImpl<$Res, _$TagModelImpl>
    implements _$$TagModelImplCopyWith<$Res> {
  __$$TagModelImplCopyWithImpl(
      _$TagModelImpl _value, $Res Function(_$TagModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? slug = freezed,
    Object? type = freezed,
    Object? orderColumn = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$TagModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as NameModel?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as NameModel?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      orderColumn: freezed == orderColumn
          ? _value.orderColumn
          : orderColumn // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TagModelImpl extends _TagModel {
  _$TagModelImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "slug") required this.slug,
      @JsonKey(name: "type") required this.type,
      @JsonKey(name: "order_column") required this.orderColumn,
      @JsonKey(name: "created_at") required this.createdAt,
      @JsonKey(name: "updated_at") required this.updatedAt})
      : super._();

  factory _$TagModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagModelImplFromJson(json);

  @override
  @JsonKey(name: "id")
  int? id;
  @override
  @JsonKey(name: "name")
  NameModel? name;
  @override
  @JsonKey(name: "slug")
  NameModel? slug;
  @override
  @JsonKey(name: "type")
  String? type;
  @override
  @JsonKey(name: "order_column")
  int? orderColumn;
  @override
  @JsonKey(name: "created_at")
  String? createdAt;
  @override
  @JsonKey(name: "updated_at")
  String? updatedAt;

  @override
  String toString() {
    return 'TagModel(id: $id, name: $name, slug: $slug, type: $type, orderColumn: $orderColumn, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TagModelImplCopyWith<_$TagModelImpl> get copyWith =>
      __$$TagModelImplCopyWithImpl<_$TagModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagModelImplToJson(
      this,
    );
  }
}

abstract class _TagModel extends TagModel {
  factory _TagModel(
          {@JsonKey(name: "id") required int? id,
          @JsonKey(name: "name") required NameModel? name,
          @JsonKey(name: "slug") required NameModel? slug,
          @JsonKey(name: "type") required String? type,
          @JsonKey(name: "order_column") required int? orderColumn,
          @JsonKey(name: "created_at") required String? createdAt,
          @JsonKey(name: "updated_at") required String? updatedAt}) =
      _$TagModelImpl;
  _TagModel._() : super._();

  factory _TagModel.fromJson(Map<String, dynamic> json) =
      _$TagModelImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @JsonKey(name: "id")
  set id(int? value);
  @override
  @JsonKey(name: "name")
  NameModel? get name;
  @JsonKey(name: "name")
  set name(NameModel? value);
  @override
  @JsonKey(name: "slug")
  NameModel? get slug;
  @JsonKey(name: "slug")
  set slug(NameModel? value);
  @override
  @JsonKey(name: "type")
  String? get type;
  @JsonKey(name: "type")
  set type(String? value);
  @override
  @JsonKey(name: "order_column")
  int? get orderColumn;
  @JsonKey(name: "order_column")
  set orderColumn(int? value);
  @override
  @JsonKey(name: "created_at")
  String? get createdAt;
  @JsonKey(name: "created_at")
  set createdAt(String? value);
  @override
  @JsonKey(name: "updated_at")
  String? get updatedAt;
  @JsonKey(name: "updated_at")
  set updatedAt(String? value);

  /// Create a copy of TagModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TagModelImplCopyWith<_$TagModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
