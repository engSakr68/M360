// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EventModel _$EventModelFromJson(Map<String, dynamic> json) {
  return _EventModel.fromJson(json);
}

/// @nodoc
mixin _$EventModel {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "id")
  set id(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  set title(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "description")
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: "description")
  set description(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "trainer")
  EventTrainerModel? get trainer => throw _privateConstructorUsedError;
  @JsonKey(name: "trainer")
  set trainer(EventTrainerModel? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "resourceId")
  int? get resourceId => throw _privateConstructorUsedError;
  @JsonKey(name: "resourceId")
  set resourceId(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "start")
  String? get start => throw _privateConstructorUsedError;
  @JsonKey(name: "start")
  set start(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "end")
  String? get end => throw _privateConstructorUsedError;
  @JsonKey(name: "end")
  set end(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "color")
  String? get color => throw _privateConstructorUsedError;
  @JsonKey(name: "color")
  set color(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "date")
  String? get date => throw _privateConstructorUsedError;
  @JsonKey(name: "date")
  set date(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "unavailability")
  bool? get unavailability => throw _privateConstructorUsedError;
  @JsonKey(name: "unavailability")
  set unavailability(bool? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "already_booked", defaultValue: false)
  bool? get alreadyBooked => throw _privateConstructorUsedError;
  @JsonKey(name: "already_booked", defaultValue: false)
  set alreadyBooked(bool? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "recurring")
  bool? get recurring => throw _privateConstructorUsedError;
  @JsonKey(name: "recurring")
  set recurring(bool? value) => throw _privateConstructorUsedError;

  /// Serializes this EventModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventModelCopyWith<EventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventModelCopyWith<$Res> {
  factory $EventModelCopyWith(
          EventModel value, $Res Function(EventModel) then) =
      _$EventModelCopyWithImpl<$Res, EventModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "trainer") EventTrainerModel? trainer,
      @JsonKey(name: "resourceId") int? resourceId,
      @JsonKey(name: "start") String? start,
      @JsonKey(name: "end") String? end,
      @JsonKey(name: "color") String? color,
      @JsonKey(name: "date") String? date,
      @JsonKey(name: "unavailability") bool? unavailability,
      @JsonKey(name: "already_booked", defaultValue: false) bool? alreadyBooked,
      @JsonKey(name: "recurring") bool? recurring});

  $EventTrainerModelCopyWith<$Res>? get trainer;
}

/// @nodoc
class _$EventModelCopyWithImpl<$Res, $Val extends EventModel>
    implements $EventModelCopyWith<$Res> {
  _$EventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? trainer = freezed,
    Object? resourceId = freezed,
    Object? start = freezed,
    Object? end = freezed,
    Object? color = freezed,
    Object? date = freezed,
    Object? unavailability = freezed,
    Object? alreadyBooked = freezed,
    Object? recurring = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      trainer: freezed == trainer
          ? _value.trainer
          : trainer // ignore: cast_nullable_to_non_nullable
              as EventTrainerModel?,
      resourceId: freezed == resourceId
          ? _value.resourceId
          : resourceId // ignore: cast_nullable_to_non_nullable
              as int?,
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      unavailability: freezed == unavailability
          ? _value.unavailability
          : unavailability // ignore: cast_nullable_to_non_nullable
              as bool?,
      alreadyBooked: freezed == alreadyBooked
          ? _value.alreadyBooked
          : alreadyBooked // ignore: cast_nullable_to_non_nullable
              as bool?,
      recurring: freezed == recurring
          ? _value.recurring
          : recurring // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EventTrainerModelCopyWith<$Res>? get trainer {
    if (_value.trainer == null) {
      return null;
    }

    return $EventTrainerModelCopyWith<$Res>(_value.trainer!, (value) {
      return _then(_value.copyWith(trainer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EventModelImplCopyWith<$Res>
    implements $EventModelCopyWith<$Res> {
  factory _$$EventModelImplCopyWith(
          _$EventModelImpl value, $Res Function(_$EventModelImpl) then) =
      __$$EventModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "title") String? title,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "trainer") EventTrainerModel? trainer,
      @JsonKey(name: "resourceId") int? resourceId,
      @JsonKey(name: "start") String? start,
      @JsonKey(name: "end") String? end,
      @JsonKey(name: "color") String? color,
      @JsonKey(name: "date") String? date,
      @JsonKey(name: "unavailability") bool? unavailability,
      @JsonKey(name: "already_booked", defaultValue: false) bool? alreadyBooked,
      @JsonKey(name: "recurring") bool? recurring});

  @override
  $EventTrainerModelCopyWith<$Res>? get trainer;
}

/// @nodoc
class __$$EventModelImplCopyWithImpl<$Res>
    extends _$EventModelCopyWithImpl<$Res, _$EventModelImpl>
    implements _$$EventModelImplCopyWith<$Res> {
  __$$EventModelImplCopyWithImpl(
      _$EventModelImpl _value, $Res Function(_$EventModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? trainer = freezed,
    Object? resourceId = freezed,
    Object? start = freezed,
    Object? end = freezed,
    Object? color = freezed,
    Object? date = freezed,
    Object? unavailability = freezed,
    Object? alreadyBooked = freezed,
    Object? recurring = freezed,
  }) {
    return _then(_$EventModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      trainer: freezed == trainer
          ? _value.trainer
          : trainer // ignore: cast_nullable_to_non_nullable
              as EventTrainerModel?,
      resourceId: freezed == resourceId
          ? _value.resourceId
          : resourceId // ignore: cast_nullable_to_non_nullable
              as int?,
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      unavailability: freezed == unavailability
          ? _value.unavailability
          : unavailability // ignore: cast_nullable_to_non_nullable
              as bool?,
      alreadyBooked: freezed == alreadyBooked
          ? _value.alreadyBooked
          : alreadyBooked // ignore: cast_nullable_to_non_nullable
              as bool?,
      recurring: freezed == recurring
          ? _value.recurring
          : recurring // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$EventModelImpl extends _EventModel {
  _$EventModelImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "title") required this.title,
      @JsonKey(name: "description") required this.description,
      @JsonKey(name: "trainer") required this.trainer,
      @JsonKey(name: "resourceId") required this.resourceId,
      @JsonKey(name: "start") required this.start,
      @JsonKey(name: "end") required this.end,
      @JsonKey(name: "color") required this.color,
      @JsonKey(name: "date") required this.date,
      @JsonKey(name: "unavailability") required this.unavailability,
      @JsonKey(name: "already_booked", defaultValue: false)
      required this.alreadyBooked,
      @JsonKey(name: "recurring") required this.recurring})
      : super._();

  factory _$EventModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventModelImplFromJson(json);

  @override
  @JsonKey(name: "id")
  int? id;
  @override
  @JsonKey(name: "title")
  String? title;
  @override
  @JsonKey(name: "description")
  String? description;
  @override
  @JsonKey(name: "trainer")
  EventTrainerModel? trainer;
  @override
  @JsonKey(name: "resourceId")
  int? resourceId;
  @override
  @JsonKey(name: "start")
  String? start;
  @override
  @JsonKey(name: "end")
  String? end;
  @override
  @JsonKey(name: "color")
  String? color;
  @override
  @JsonKey(name: "date")
  String? date;
  @override
  @JsonKey(name: "unavailability")
  bool? unavailability;
  @override
  @JsonKey(name: "already_booked", defaultValue: false)
  bool? alreadyBooked;
  @override
  @JsonKey(name: "recurring")
  bool? recurring;

  @override
  String toString() {
    return 'EventModel(id: $id, title: $title, description: $description, trainer: $trainer, resourceId: $resourceId, start: $start, end: $end, color: $color, date: $date, unavailability: $unavailability, alreadyBooked: $alreadyBooked, recurring: $recurring)';
  }

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventModelImplCopyWith<_$EventModelImpl> get copyWith =>
      __$$EventModelImplCopyWithImpl<_$EventModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventModelImplToJson(
      this,
    );
  }
}

abstract class _EventModel extends EventModel {
  factory _EventModel(
      {@JsonKey(name: "id") required int? id,
      @JsonKey(name: "title") required String? title,
      @JsonKey(name: "description") required String? description,
      @JsonKey(name: "trainer") required EventTrainerModel? trainer,
      @JsonKey(name: "resourceId") required int? resourceId,
      @JsonKey(name: "start") required String? start,
      @JsonKey(name: "end") required String? end,
      @JsonKey(name: "color") required String? color,
      @JsonKey(name: "date") required String? date,
      @JsonKey(name: "unavailability") required bool? unavailability,
      @JsonKey(name: "already_booked", defaultValue: false)
      required bool? alreadyBooked,
      @JsonKey(name: "recurring") required bool? recurring}) = _$EventModelImpl;
  _EventModel._() : super._();

  factory _EventModel.fromJson(Map<String, dynamic> json) =
      _$EventModelImpl.fromJson;

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
  @JsonKey(name: "description")
  String? get description;
  @JsonKey(name: "description")
  set description(String? value);
  @override
  @JsonKey(name: "trainer")
  EventTrainerModel? get trainer;
  @JsonKey(name: "trainer")
  set trainer(EventTrainerModel? value);
  @override
  @JsonKey(name: "resourceId")
  int? get resourceId;
  @JsonKey(name: "resourceId")
  set resourceId(int? value);
  @override
  @JsonKey(name: "start")
  String? get start;
  @JsonKey(name: "start")
  set start(String? value);
  @override
  @JsonKey(name: "end")
  String? get end;
  @JsonKey(name: "end")
  set end(String? value);
  @override
  @JsonKey(name: "color")
  String? get color;
  @JsonKey(name: "color")
  set color(String? value);
  @override
  @JsonKey(name: "date")
  String? get date;
  @JsonKey(name: "date")
  set date(String? value);
  @override
  @JsonKey(name: "unavailability")
  bool? get unavailability;
  @JsonKey(name: "unavailability")
  set unavailability(bool? value);
  @override
  @JsonKey(name: "already_booked", defaultValue: false)
  bool? get alreadyBooked;
  @JsonKey(name: "already_booked", defaultValue: false)
  set alreadyBooked(bool? value);
  @override
  @JsonKey(name: "recurring")
  bool? get recurring;
  @JsonKey(name: "recurring")
  set recurring(bool? value);

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventModelImplCopyWith<_$EventModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
