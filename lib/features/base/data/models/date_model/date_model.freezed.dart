// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'date_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DateModel _$DateModelFromJson(Map<String, dynamic> json) {
  return _DateModel.fromJson(json);
}

/// @nodoc
mixin _$DateModel {
  @JsonKey(name: "dow", defaultValue: [])
  List<int>? get dow => throw _privateConstructorUsedError;
  @JsonKey(name: "dow", defaultValue: [])
  set dow(List<int>? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "start")
  String get start => throw _privateConstructorUsedError;
  @JsonKey(name: "start")
  set start(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: "end")
  String get end => throw _privateConstructorUsedError;
  @JsonKey(name: "end")
  set end(String value) => throw _privateConstructorUsedError;

  /// Serializes this DateModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DateModelCopyWith<DateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DateModelCopyWith<$Res> {
  factory $DateModelCopyWith(DateModel value, $Res Function(DateModel) then) =
      _$DateModelCopyWithImpl<$Res, DateModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "dow", defaultValue: []) List<int>? dow,
      @JsonKey(name: "start") String start,
      @JsonKey(name: "end") String end});
}

/// @nodoc
class _$DateModelCopyWithImpl<$Res, $Val extends DateModel>
    implements $DateModelCopyWith<$Res> {
  _$DateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dow = freezed,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_value.copyWith(
      dow: freezed == dow
          ? _value.dow
          : dow // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DateModelImplCopyWith<$Res>
    implements $DateModelCopyWith<$Res> {
  factory _$$DateModelImplCopyWith(
          _$DateModelImpl value, $Res Function(_$DateModelImpl) then) =
      __$$DateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "dow", defaultValue: []) List<int>? dow,
      @JsonKey(name: "start") String start,
      @JsonKey(name: "end") String end});
}

/// @nodoc
class __$$DateModelImplCopyWithImpl<$Res>
    extends _$DateModelCopyWithImpl<$Res, _$DateModelImpl>
    implements _$$DateModelImplCopyWith<$Res> {
  __$$DateModelImplCopyWithImpl(
      _$DateModelImpl _value, $Res Function(_$DateModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dow = freezed,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_$DateModelImpl(
      dow: freezed == dow
          ? _value.dow
          : dow // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$DateModelImpl extends _DateModel {
  _$DateModelImpl(
      {@JsonKey(name: "dow", defaultValue: []) required this.dow,
      @JsonKey(name: "start") required this.start,
      @JsonKey(name: "end") required this.end})
      : super._();

  factory _$DateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DateModelImplFromJson(json);

  @override
  @JsonKey(name: "dow", defaultValue: [])
  List<int>? dow;
  @override
  @JsonKey(name: "start")
  String start;
  @override
  @JsonKey(name: "end")
  String end;

  @override
  String toString() {
    return 'DateModel(dow: $dow, start: $start, end: $end)';
  }

  /// Create a copy of DateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DateModelImplCopyWith<_$DateModelImpl> get copyWith =>
      __$$DateModelImplCopyWithImpl<_$DateModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DateModelImplToJson(
      this,
    );
  }
}

abstract class _DateModel extends DateModel {
  factory _DateModel(
      {@JsonKey(name: "dow", defaultValue: []) required List<int>? dow,
      @JsonKey(name: "start") required String start,
      @JsonKey(name: "end") required String end}) = _$DateModelImpl;
  _DateModel._() : super._();

  factory _DateModel.fromJson(Map<String, dynamic> json) =
      _$DateModelImpl.fromJson;

  @override
  @JsonKey(name: "dow", defaultValue: [])
  List<int>? get dow;
  @JsonKey(name: "dow", defaultValue: [])
  set dow(List<int>? value);
  @override
  @JsonKey(name: "start")
  String get start;
  @JsonKey(name: "start")
  set start(String value);
  @override
  @JsonKey(name: "end")
  String get end;
  @JsonKey(name: "end")
  set end(String value);

  /// Create a copy of DateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DateModelImplCopyWith<_$DateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
