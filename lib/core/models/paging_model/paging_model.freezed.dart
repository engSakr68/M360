// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paging_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PagingModel<T> _$PagingModelFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _PagingModel<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$PagingModel<T> {
  @JsonKey(name: 'total', defaultValue: 0)
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page', defaultValue: 0)
  int get lastPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page', defaultValue: 0)
  int get perPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_page', defaultValue: 0)
  int get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'data', defaultValue: [])
  List<T> get data => throw _privateConstructorUsedError;

  /// Serializes this PagingModel to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of PagingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PagingModelCopyWith<T, PagingModel<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagingModelCopyWith<T, $Res> {
  factory $PagingModelCopyWith(
          PagingModel<T> value, $Res Function(PagingModel<T>) then) =
      _$PagingModelCopyWithImpl<T, $Res, PagingModel<T>>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total', defaultValue: 0) int total,
      @JsonKey(name: 'last_page', defaultValue: 0) int lastPage,
      @JsonKey(name: 'per_page', defaultValue: 0) int perPage,
      @JsonKey(name: 'current_page', defaultValue: 0) int currentPage,
      @JsonKey(name: 'data', defaultValue: []) List<T> data});
}

/// @nodoc
class _$PagingModelCopyWithImpl<T, $Res, $Val extends PagingModel<T>>
    implements $PagingModelCopyWith<T, $Res> {
  _$PagingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PagingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? lastPage = null,
    Object? perPage = null,
    Object? currentPage = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      lastPage: null == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PagingModelImplCopyWith<T, $Res>
    implements $PagingModelCopyWith<T, $Res> {
  factory _$$PagingModelImplCopyWith(_$PagingModelImpl<T> value,
          $Res Function(_$PagingModelImpl<T>) then) =
      __$$PagingModelImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total', defaultValue: 0) int total,
      @JsonKey(name: 'last_page', defaultValue: 0) int lastPage,
      @JsonKey(name: 'per_page', defaultValue: 0) int perPage,
      @JsonKey(name: 'current_page', defaultValue: 0) int currentPage,
      @JsonKey(name: 'data', defaultValue: []) List<T> data});
}

/// @nodoc
class __$$PagingModelImplCopyWithImpl<T, $Res>
    extends _$PagingModelCopyWithImpl<T, $Res, _$PagingModelImpl<T>>
    implements _$$PagingModelImplCopyWith<T, $Res> {
  __$$PagingModelImplCopyWithImpl(
      _$PagingModelImpl<T> _value, $Res Function(_$PagingModelImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of PagingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? lastPage = null,
    Object? perPage = null,
    Object? currentPage = null,
    Object? data = null,
  }) {
    return _then(_$PagingModelImpl<T>(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      lastPage: null == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class _$PagingModelImpl<T> extends _PagingModel<T> {
  _$PagingModelImpl(
      {@JsonKey(name: 'total', defaultValue: 0) required this.total,
      @JsonKey(name: 'last_page', defaultValue: 0) required this.lastPage,
      @JsonKey(name: 'per_page', defaultValue: 0) required this.perPage,
      @JsonKey(name: 'current_page', defaultValue: 0) required this.currentPage,
      @JsonKey(name: 'data', defaultValue: []) required final List<T> data})
      : _data = data,
        super._();

  factory _$PagingModelImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$PagingModelImplFromJson(json, fromJsonT);

  @override
  @JsonKey(name: 'total', defaultValue: 0)
  final int total;
  @override
  @JsonKey(name: 'last_page', defaultValue: 0)
  final int lastPage;
  @override
  @JsonKey(name: 'per_page', defaultValue: 0)
  final int perPage;
  @override
  @JsonKey(name: 'current_page', defaultValue: 0)
  final int currentPage;
  final List<T> _data;
  @override
  @JsonKey(name: 'data', defaultValue: [])
  List<T> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'PagingModel<$T>(total: $total, lastPage: $lastPage, perPage: $perPage, currentPage: $currentPage, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PagingModelImpl<T> &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.lastPage, lastPage) ||
                other.lastPage == lastPage) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, total, lastPage, perPage,
      currentPage, const DeepCollectionEquality().hash(_data));

  /// Create a copy of PagingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PagingModelImplCopyWith<T, _$PagingModelImpl<T>> get copyWith =>
      __$$PagingModelImplCopyWithImpl<T, _$PagingModelImpl<T>>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$PagingModelImplToJson<T>(this, toJsonT);
  }
}

abstract class _PagingModel<T> extends PagingModel<T> {
  factory _PagingModel(
      {@JsonKey(name: 'total', defaultValue: 0) required final int total,
      @JsonKey(name: 'last_page', defaultValue: 0) required final int lastPage,
      @JsonKey(name: 'per_page', defaultValue: 0) required final int perPage,
      @JsonKey(name: 'current_page', defaultValue: 0)
      required final int currentPage,
      @JsonKey(name: 'data', defaultValue: [])
      required final List<T> data}) = _$PagingModelImpl<T>;
  _PagingModel._() : super._();

  factory _PagingModel.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$PagingModelImpl<T>.fromJson;

  @override
  @JsonKey(name: 'total', defaultValue: 0)
  int get total;
  @override
  @JsonKey(name: 'last_page', defaultValue: 0)
  int get lastPage;
  @override
  @JsonKey(name: 'per_page', defaultValue: 0)
  int get perPage;
  @override
  @JsonKey(name: 'current_page', defaultValue: 0)
  int get currentPage;
  @override
  @JsonKey(name: 'data', defaultValue: [])
  List<T> get data;

  /// Create a copy of PagingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PagingModelImplCopyWith<T, _$PagingModelImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
