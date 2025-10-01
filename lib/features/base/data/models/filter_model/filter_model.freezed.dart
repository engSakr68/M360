// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FilterModel _$FilterModelFromJson(Map<String, dynamic> json) {
  return _FilterModel.fromJson(json);
}

/// @nodoc
mixin _$FilterModel {
  @JsonKey(name: "trainers")
  List<TrainerModel>? get trainers => throw _privateConstructorUsedError;
  @JsonKey(name: "trainers")
  set trainers(List<TrainerModel>? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "trainingPrograms")
  List<ProgramModel>? get classes => throw _privateConstructorUsedError;
  @JsonKey(name: "trainingPrograms")
  set classes(List<ProgramModel>? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "availableTags")
  List<TagModel>? get tags => throw _privateConstructorUsedError;
  @JsonKey(name: "availableTags")
  set tags(List<TagModel>? value) => throw _privateConstructorUsedError;

  /// Serializes this FilterModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FilterModelCopyWith<FilterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterModelCopyWith<$Res> {
  factory $FilterModelCopyWith(
          FilterModel value, $Res Function(FilterModel) then) =
      _$FilterModelCopyWithImpl<$Res, FilterModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "trainers") List<TrainerModel>? trainers,
      @JsonKey(name: "trainingPrograms") List<ProgramModel>? classes,
      @JsonKey(name: "availableTags") List<TagModel>? tags});
}

/// @nodoc
class _$FilterModelCopyWithImpl<$Res, $Val extends FilterModel>
    implements $FilterModelCopyWith<$Res> {
  _$FilterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trainers = freezed,
    Object? classes = freezed,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      trainers: freezed == trainers
          ? _value.trainers
          : trainers // ignore: cast_nullable_to_non_nullable
              as List<TrainerModel>?,
      classes: freezed == classes
          ? _value.classes
          : classes // ignore: cast_nullable_to_non_nullable
              as List<ProgramModel>?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FilterModelImplCopyWith<$Res>
    implements $FilterModelCopyWith<$Res> {
  factory _$$FilterModelImplCopyWith(
          _$FilterModelImpl value, $Res Function(_$FilterModelImpl) then) =
      __$$FilterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "trainers") List<TrainerModel>? trainers,
      @JsonKey(name: "trainingPrograms") List<ProgramModel>? classes,
      @JsonKey(name: "availableTags") List<TagModel>? tags});
}

/// @nodoc
class __$$FilterModelImplCopyWithImpl<$Res>
    extends _$FilterModelCopyWithImpl<$Res, _$FilterModelImpl>
    implements _$$FilterModelImplCopyWith<$Res> {
  __$$FilterModelImplCopyWithImpl(
      _$FilterModelImpl _value, $Res Function(_$FilterModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trainers = freezed,
    Object? classes = freezed,
    Object? tags = freezed,
  }) {
    return _then(_$FilterModelImpl(
      trainers: freezed == trainers
          ? _value.trainers
          : trainers // ignore: cast_nullable_to_non_nullable
              as List<TrainerModel>?,
      classes: freezed == classes
          ? _value.classes
          : classes // ignore: cast_nullable_to_non_nullable
              as List<ProgramModel>?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$FilterModelImpl extends _FilterModel {
  _$FilterModelImpl(
      {@JsonKey(name: "trainers") required this.trainers,
      @JsonKey(name: "trainingPrograms") required this.classes,
      @JsonKey(name: "availableTags") required this.tags})
      : super._();

  factory _$FilterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilterModelImplFromJson(json);

  @override
  @JsonKey(name: "trainers")
  List<TrainerModel>? trainers;
  @override
  @JsonKey(name: "trainingPrograms")
  List<ProgramModel>? classes;
  @override
  @JsonKey(name: "availableTags")
  List<TagModel>? tags;

  @override
  String toString() {
    return 'FilterModel(trainers: $trainers, classes: $classes, tags: $tags)';
  }

  /// Create a copy of FilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterModelImplCopyWith<_$FilterModelImpl> get copyWith =>
      __$$FilterModelImplCopyWithImpl<_$FilterModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FilterModelImplToJson(
      this,
    );
  }
}

abstract class _FilterModel extends FilterModel {
  factory _FilterModel(
      {@JsonKey(name: "trainers") required List<TrainerModel>? trainers,
      @JsonKey(name: "trainingPrograms") required List<ProgramModel>? classes,
      @JsonKey(name: "availableTags")
      required List<TagModel>? tags}) = _$FilterModelImpl;
  _FilterModel._() : super._();

  factory _FilterModel.fromJson(Map<String, dynamic> json) =
      _$FilterModelImpl.fromJson;

  @override
  @JsonKey(name: "trainers")
  List<TrainerModel>? get trainers;
  @JsonKey(name: "trainers")
  set trainers(List<TrainerModel>? value);
  @override
  @JsonKey(name: "trainingPrograms")
  List<ProgramModel>? get classes;
  @JsonKey(name: "trainingPrograms")
  set classes(List<ProgramModel>? value);
  @override
  @JsonKey(name: "availableTags")
  List<TagModel>? get tags;
  @JsonKey(name: "availableTags")
  set tags(List<TagModel>? value);

  /// Create a copy of FilterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterModelImplCopyWith<_$FilterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
