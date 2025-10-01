// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookSessionModel _$BookSessionModelFromJson(Map<String, dynamic> json) {
  return _BookSessionModel.fromJson(json);
}

/// @nodoc
mixin _$BookSessionModel {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "id")
  set id(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "trainer_id")
  int? get trainerId => throw _privateConstructorUsedError;
  @JsonKey(name: "trainer_id")
  set trainerId(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "member_id")
  int? get memberId => throw _privateConstructorUsedError;
  @JsonKey(name: "member_id")
  set memberId(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "gym_id")
  int? get gymId => throw _privateConstructorUsedError;
  @JsonKey(name: "gym_id")
  set gymId(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "oinvoice_id")
  int? get invoiceId => throw _privateConstructorUsedError;
  @JsonKey(name: "oinvoice_id")
  set invoiceId(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  set title(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "starttime")
  String? get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: "starttime")
  set startTime(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "endtime")
  String? get endTime => throw _privateConstructorUsedError;
  @JsonKey(name: "endtime")
  set endTime(String? value) => throw _privateConstructorUsedError;

  /// Serializes this BookSessionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookSessionModelCopyWith<BookSessionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookSessionModelCopyWith<$Res> {
  factory $BookSessionModelCopyWith(
          BookSessionModel value, $Res Function(BookSessionModel) then) =
      _$BookSessionModelCopyWithImpl<$Res, BookSessionModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "trainer_id") int? trainerId,
      @JsonKey(name: "member_id") int? memberId,
      @JsonKey(name: "gym_id") int? gymId,
      @JsonKey(name: "oinvoice_id") int? invoiceId,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "starttime") String? startTime,
      @JsonKey(name: "endtime") String? endTime});
}

/// @nodoc
class _$BookSessionModelCopyWithImpl<$Res, $Val extends BookSessionModel>
    implements $BookSessionModelCopyWith<$Res> {
  _$BookSessionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? trainerId = freezed,
    Object? memberId = freezed,
    Object? gymId = freezed,
    Object? invoiceId = freezed,
    Object? title = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      trainerId: freezed == trainerId
          ? _value.trainerId
          : trainerId // ignore: cast_nullable_to_non_nullable
              as int?,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int?,
      gymId: freezed == gymId
          ? _value.gymId
          : gymId // ignore: cast_nullable_to_non_nullable
              as int?,
      invoiceId: freezed == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookSessionModelImplCopyWith<$Res>
    implements $BookSessionModelCopyWith<$Res> {
  factory _$$BookSessionModelImplCopyWith(_$BookSessionModelImpl value,
          $Res Function(_$BookSessionModelImpl) then) =
      __$$BookSessionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "trainer_id") int? trainerId,
      @JsonKey(name: "member_id") int? memberId,
      @JsonKey(name: "gym_id") int? gymId,
      @JsonKey(name: "oinvoice_id") int? invoiceId,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "starttime") String? startTime,
      @JsonKey(name: "endtime") String? endTime});
}

/// @nodoc
class __$$BookSessionModelImplCopyWithImpl<$Res>
    extends _$BookSessionModelCopyWithImpl<$Res, _$BookSessionModelImpl>
    implements _$$BookSessionModelImplCopyWith<$Res> {
  __$$BookSessionModelImplCopyWithImpl(_$BookSessionModelImpl _value,
      $Res Function(_$BookSessionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? trainerId = freezed,
    Object? memberId = freezed,
    Object? gymId = freezed,
    Object? invoiceId = freezed,
    Object? title = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
  }) {
    return _then(_$BookSessionModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      trainerId: freezed == trainerId
          ? _value.trainerId
          : trainerId // ignore: cast_nullable_to_non_nullable
              as int?,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int?,
      gymId: freezed == gymId
          ? _value.gymId
          : gymId // ignore: cast_nullable_to_non_nullable
              as int?,
      invoiceId: freezed == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$BookSessionModelImpl extends _BookSessionModel {
  _$BookSessionModelImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "trainer_id") required this.trainerId,
      @JsonKey(name: "member_id") required this.memberId,
      @JsonKey(name: "gym_id") required this.gymId,
      @JsonKey(name: "oinvoice_id") required this.invoiceId,
      @JsonKey(name: "title") required this.title,
      @JsonKey(name: "starttime") required this.startTime,
      @JsonKey(name: "endtime") required this.endTime})
      : super._();

  factory _$BookSessionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookSessionModelImplFromJson(json);

  @override
  @JsonKey(name: "id")
  int? id;
  @override
  @JsonKey(name: "trainer_id")
  int? trainerId;
  @override
  @JsonKey(name: "member_id")
  int? memberId;
  @override
  @JsonKey(name: "gym_id")
  int? gymId;
  @override
  @JsonKey(name: "oinvoice_id")
  int? invoiceId;
  @override
  @JsonKey(name: "title")
  String? title;
  @override
  @JsonKey(name: "starttime")
  String? startTime;
  @override
  @JsonKey(name: "endtime")
  String? endTime;

  @override
  String toString() {
    return 'BookSessionModel(id: $id, trainerId: $trainerId, memberId: $memberId, gymId: $gymId, invoiceId: $invoiceId, title: $title, startTime: $startTime, endTime: $endTime)';
  }

  /// Create a copy of BookSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookSessionModelImplCopyWith<_$BookSessionModelImpl> get copyWith =>
      __$$BookSessionModelImplCopyWithImpl<_$BookSessionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookSessionModelImplToJson(
      this,
    );
  }
}

abstract class _BookSessionModel extends BookSessionModel {
  factory _BookSessionModel(
          {@JsonKey(name: "id") required int? id,
          @JsonKey(name: "trainer_id") required int? trainerId,
          @JsonKey(name: "member_id") required int? memberId,
          @JsonKey(name: "gym_id") required int? gymId,
          @JsonKey(name: "oinvoice_id") required int? invoiceId,
          @JsonKey(name: "title") required String? title,
          @JsonKey(name: "starttime") required String? startTime,
          @JsonKey(name: "endtime") required String? endTime}) =
      _$BookSessionModelImpl;
  _BookSessionModel._() : super._();

  factory _BookSessionModel.fromJson(Map<String, dynamic> json) =
      _$BookSessionModelImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @JsonKey(name: "id")
  set id(int? value);
  @override
  @JsonKey(name: "trainer_id")
  int? get trainerId;
  @JsonKey(name: "trainer_id")
  set trainerId(int? value);
  @override
  @JsonKey(name: "member_id")
  int? get memberId;
  @JsonKey(name: "member_id")
  set memberId(int? value);
  @override
  @JsonKey(name: "gym_id")
  int? get gymId;
  @JsonKey(name: "gym_id")
  set gymId(int? value);
  @override
  @JsonKey(name: "oinvoice_id")
  int? get invoiceId;
  @JsonKey(name: "oinvoice_id")
  set invoiceId(int? value);
  @override
  @JsonKey(name: "title")
  String? get title;
  @JsonKey(name: "title")
  set title(String? value);
  @override
  @JsonKey(name: "starttime")
  String? get startTime;
  @JsonKey(name: "starttime")
  set startTime(String? value);
  @override
  @JsonKey(name: "endtime")
  String? get endTime;
  @JsonKey(name: "endtime")
  set endTime(String? value);

  /// Create a copy of BookSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookSessionModelImplCopyWith<_$BookSessionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
