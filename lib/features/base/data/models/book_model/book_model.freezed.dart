// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookModel _$BookModelFromJson(Map<String, dynamic> json) {
  return _BookModel.fromJson(json);
}

/// @nodoc
mixin _$BookModel {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "id")
  set id(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "training_program_schedule_id")
  int? get trainingProgramScheduleId => throw _privateConstructorUsedError;
  @JsonKey(name: "training_program_schedule_id")
  set trainingProgramScheduleId(int? value) =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "member_id")
  int? get memberId => throw _privateConstructorUsedError;
  @JsonKey(name: "member_id")
  set memberId(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "fname")
  String? get fname => throw _privateConstructorUsedError;
  @JsonKey(name: "fname")
  set fname(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "sname")
  String? get sname => throw _privateConstructorUsedError;
  @JsonKey(name: "sname")
  set sname(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "mobilenumber")
  String? get mobilenumber => throw _privateConstructorUsedError;
  @JsonKey(name: "mobilenumber")
  set mobilenumber(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "email")
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: "email")
  set email(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "uitem")
  int? get uitem => throw _privateConstructorUsedError;
  @JsonKey(name: "uitem")
  set uitem(int? value) => throw _privateConstructorUsedError;

  /// Serializes this BookModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookModelCopyWith<BookModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookModelCopyWith<$Res> {
  factory $BookModelCopyWith(BookModel value, $Res Function(BookModel) then) =
      _$BookModelCopyWithImpl<$Res, BookModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "training_program_schedule_id")
      int? trainingProgramScheduleId,
      @JsonKey(name: "member_id") int? memberId,
      @JsonKey(name: "fname") String? fname,
      @JsonKey(name: "sname") String? sname,
      @JsonKey(name: "mobilenumber") String? mobilenumber,
      @JsonKey(name: "email") String? email,
      @JsonKey(name: "uitem") int? uitem});
}

/// @nodoc
class _$BookModelCopyWithImpl<$Res, $Val extends BookModel>
    implements $BookModelCopyWith<$Res> {
  _$BookModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? trainingProgramScheduleId = freezed,
    Object? memberId = freezed,
    Object? fname = freezed,
    Object? sname = freezed,
    Object? mobilenumber = freezed,
    Object? email = freezed,
    Object? uitem = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      trainingProgramScheduleId: freezed == trainingProgramScheduleId
          ? _value.trainingProgramScheduleId
          : trainingProgramScheduleId // ignore: cast_nullable_to_non_nullable
              as int?,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int?,
      fname: freezed == fname
          ? _value.fname
          : fname // ignore: cast_nullable_to_non_nullable
              as String?,
      sname: freezed == sname
          ? _value.sname
          : sname // ignore: cast_nullable_to_non_nullable
              as String?,
      mobilenumber: freezed == mobilenumber
          ? _value.mobilenumber
          : mobilenumber // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      uitem: freezed == uitem
          ? _value.uitem
          : uitem // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookModelImplCopyWith<$Res>
    implements $BookModelCopyWith<$Res> {
  factory _$$BookModelImplCopyWith(
          _$BookModelImpl value, $Res Function(_$BookModelImpl) then) =
      __$$BookModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "training_program_schedule_id")
      int? trainingProgramScheduleId,
      @JsonKey(name: "member_id") int? memberId,
      @JsonKey(name: "fname") String? fname,
      @JsonKey(name: "sname") String? sname,
      @JsonKey(name: "mobilenumber") String? mobilenumber,
      @JsonKey(name: "email") String? email,
      @JsonKey(name: "uitem") int? uitem});
}

/// @nodoc
class __$$BookModelImplCopyWithImpl<$Res>
    extends _$BookModelCopyWithImpl<$Res, _$BookModelImpl>
    implements _$$BookModelImplCopyWith<$Res> {
  __$$BookModelImplCopyWithImpl(
      _$BookModelImpl _value, $Res Function(_$BookModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? trainingProgramScheduleId = freezed,
    Object? memberId = freezed,
    Object? fname = freezed,
    Object? sname = freezed,
    Object? mobilenumber = freezed,
    Object? email = freezed,
    Object? uitem = freezed,
  }) {
    return _then(_$BookModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      trainingProgramScheduleId: freezed == trainingProgramScheduleId
          ? _value.trainingProgramScheduleId
          : trainingProgramScheduleId // ignore: cast_nullable_to_non_nullable
              as int?,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int?,
      fname: freezed == fname
          ? _value.fname
          : fname // ignore: cast_nullable_to_non_nullable
              as String?,
      sname: freezed == sname
          ? _value.sname
          : sname // ignore: cast_nullable_to_non_nullable
              as String?,
      mobilenumber: freezed == mobilenumber
          ? _value.mobilenumber
          : mobilenumber // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      uitem: freezed == uitem
          ? _value.uitem
          : uitem // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$BookModelImpl extends _BookModel {
  _$BookModelImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "training_program_schedule_id")
      required this.trainingProgramScheduleId,
      @JsonKey(name: "member_id") required this.memberId,
      @JsonKey(name: "fname") required this.fname,
      @JsonKey(name: "sname") required this.sname,
      @JsonKey(name: "mobilenumber") required this.mobilenumber,
      @JsonKey(name: "email") required this.email,
      @JsonKey(name: "uitem") required this.uitem})
      : super._();

  factory _$BookModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookModelImplFromJson(json);

  @override
  @JsonKey(name: "id")
  int? id;
  @override
  @JsonKey(name: "training_program_schedule_id")
  int? trainingProgramScheduleId;
  @override
  @JsonKey(name: "member_id")
  int? memberId;
  @override
  @JsonKey(name: "fname")
  String? fname;
  @override
  @JsonKey(name: "sname")
  String? sname;
  @override
  @JsonKey(name: "mobilenumber")
  String? mobilenumber;
  @override
  @JsonKey(name: "email")
  String? email;
  @override
  @JsonKey(name: "uitem")
  int? uitem;

  @override
  String toString() {
    return 'BookModel(id: $id, trainingProgramScheduleId: $trainingProgramScheduleId, memberId: $memberId, fname: $fname, sname: $sname, mobilenumber: $mobilenumber, email: $email, uitem: $uitem)';
  }

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookModelImplCopyWith<_$BookModelImpl> get copyWith =>
      __$$BookModelImplCopyWithImpl<_$BookModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookModelImplToJson(
      this,
    );
  }
}

abstract class _BookModel extends BookModel {
  factory _BookModel(
      {@JsonKey(name: "id") required int? id,
      @JsonKey(name: "training_program_schedule_id")
      required int? trainingProgramScheduleId,
      @JsonKey(name: "member_id") required int? memberId,
      @JsonKey(name: "fname") required String? fname,
      @JsonKey(name: "sname") required String? sname,
      @JsonKey(name: "mobilenumber") required String? mobilenumber,
      @JsonKey(name: "email") required String? email,
      @JsonKey(name: "uitem") required int? uitem}) = _$BookModelImpl;
  _BookModel._() : super._();

  factory _BookModel.fromJson(Map<String, dynamic> json) =
      _$BookModelImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @JsonKey(name: "id")
  set id(int? value);
  @override
  @JsonKey(name: "training_program_schedule_id")
  int? get trainingProgramScheduleId;
  @JsonKey(name: "training_program_schedule_id")
  set trainingProgramScheduleId(int? value);
  @override
  @JsonKey(name: "member_id")
  int? get memberId;
  @JsonKey(name: "member_id")
  set memberId(int? value);
  @override
  @JsonKey(name: "fname")
  String? get fname;
  @JsonKey(name: "fname")
  set fname(String? value);
  @override
  @JsonKey(name: "sname")
  String? get sname;
  @JsonKey(name: "sname")
  set sname(String? value);
  @override
  @JsonKey(name: "mobilenumber")
  String? get mobilenumber;
  @JsonKey(name: "mobilenumber")
  set mobilenumber(String? value);
  @override
  @JsonKey(name: "email")
  String? get email;
  @JsonKey(name: "email")
  set email(String? value);
  @override
  @JsonKey(name: "uitem")
  int? get uitem;
  @JsonKey(name: "uitem")
  set uitem(int? value);

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookModelImplCopyWith<_$BookModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
