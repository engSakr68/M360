// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'program_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProgramModel _$ProgramModelFromJson(Map<String, dynamic> json) {
  return _ProgramModel.fromJson(json);
}

/// @nodoc
mixin _$ProgramModel {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "id")
  set id(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  set title(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "color")
  String? get color => throw _privateConstructorUsedError;
  @JsonKey(name: "color")
  set color(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "class_photo_url")
  String? get photo => throw _privateConstructorUsedError;
  @JsonKey(name: "class_photo_url")
  set photo(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "description")
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: "description")
  set description(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "trainer")
  TrainerModel? get trainer => throw _privateConstructorUsedError;
  @JsonKey(name: "trainer")
  set trainer(TrainerModel? value) => throw _privateConstructorUsedError;

  /// Serializes this ProgramModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgramModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgramModelCopyWith<ProgramModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramModelCopyWith<$Res> {
  factory $ProgramModelCopyWith(
          ProgramModel value, $Res Function(ProgramModel) then) =
      _$ProgramModelCopyWithImpl<$Res, ProgramModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "color") String? color,
      @JsonKey(name: "class_photo_url") String? photo,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "trainer") TrainerModel? trainer});

  $TrainerModelCopyWith<$Res>? get trainer;
}

/// @nodoc
class _$ProgramModelCopyWithImpl<$Res, $Val extends ProgramModel>
    implements $ProgramModelCopyWith<$Res> {
  _$ProgramModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgramModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? color = freezed,
    Object? photo = freezed,
    Object? description = freezed,
    Object? trainer = freezed,
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
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      trainer: freezed == trainer
          ? _value.trainer
          : trainer // ignore: cast_nullable_to_non_nullable
              as TrainerModel?,
    ) as $Val);
  }

  /// Create a copy of ProgramModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TrainerModelCopyWith<$Res>? get trainer {
    if (_value.trainer == null) {
      return null;
    }

    return $TrainerModelCopyWith<$Res>(_value.trainer!, (value) {
      return _then(_value.copyWith(trainer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProgramModelImplCopyWith<$Res>
    implements $ProgramModelCopyWith<$Res> {
  factory _$$ProgramModelImplCopyWith(
          _$ProgramModelImpl value, $Res Function(_$ProgramModelImpl) then) =
      __$$ProgramModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "color") String? color,
      @JsonKey(name: "class_photo_url") String? photo,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "trainer") TrainerModel? trainer});

  @override
  $TrainerModelCopyWith<$Res>? get trainer;
}

/// @nodoc
class __$$ProgramModelImplCopyWithImpl<$Res>
    extends _$ProgramModelCopyWithImpl<$Res, _$ProgramModelImpl>
    implements _$$ProgramModelImplCopyWith<$Res> {
  __$$ProgramModelImplCopyWithImpl(
      _$ProgramModelImpl _value, $Res Function(_$ProgramModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProgramModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? color = freezed,
    Object? photo = freezed,
    Object? description = freezed,
    Object? trainer = freezed,
  }) {
    return _then(_$ProgramModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      trainer: freezed == trainer
          ? _value.trainer
          : trainer // ignore: cast_nullable_to_non_nullable
              as TrainerModel?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ProgramModelImpl extends _ProgramModel {
  _$ProgramModelImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "title") required this.title,
      @JsonKey(name: "color") required this.color,
      @JsonKey(name: "class_photo_url") required this.photo,
      @JsonKey(name: "description") required this.description,
      @JsonKey(name: "trainer") required this.trainer})
      : super._();

  factory _$ProgramModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgramModelImplFromJson(json);

  @override
  @JsonKey(name: "id")
  int? id;
  @override
  @JsonKey(name: "title")
  String? title;
  @override
  @JsonKey(name: "color")
  String? color;
  @override
  @JsonKey(name: "class_photo_url")
  String? photo;
  @override
  @JsonKey(name: "description")
  String? description;
  @override
  @JsonKey(name: "trainer")
  TrainerModel? trainer;

  @override
  String toString() {
    return 'ProgramModel(id: $id, title: $title, color: $color, photo: $photo, description: $description, trainer: $trainer)';
  }

  /// Create a copy of ProgramModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramModelImplCopyWith<_$ProgramModelImpl> get copyWith =>
      __$$ProgramModelImplCopyWithImpl<_$ProgramModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgramModelImplToJson(
      this,
    );
  }
}

abstract class _ProgramModel extends ProgramModel {
  factory _ProgramModel(
          {@JsonKey(name: "id") required int? id,
          @JsonKey(name: "title") required String? title,
          @JsonKey(name: "color") required String? color,
          @JsonKey(name: "class_photo_url") required String? photo,
          @JsonKey(name: "description") required String? description,
          @JsonKey(name: "trainer") required TrainerModel? trainer}) =
      _$ProgramModelImpl;
  _ProgramModel._() : super._();

  factory _ProgramModel.fromJson(Map<String, dynamic> json) =
      _$ProgramModelImpl.fromJson;

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
  @JsonKey(name: "color")
  String? get color;
  @JsonKey(name: "color")
  set color(String? value);
  @override
  @JsonKey(name: "class_photo_url")
  String? get photo;
  @JsonKey(name: "class_photo_url")
  set photo(String? value);
  @override
  @JsonKey(name: "description")
  String? get description;
  @JsonKey(name: "description")
  set description(String? value);
  @override
  @JsonKey(name: "trainer")
  TrainerModel? get trainer;
  @JsonKey(name: "trainer")
  set trainer(TrainerModel? value);

  /// Create a copy of ProgramModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgramModelImplCopyWith<_$ProgramModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
