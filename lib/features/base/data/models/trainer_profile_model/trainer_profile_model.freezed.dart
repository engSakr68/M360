// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trainer_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrainerProfileModel _$TrainerProfileModelFromJson(Map<String, dynamic> json) {
  return _TrainerProfileModel.fromJson(json);
}

/// @nodoc
mixin _$TrainerProfileModel {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "id")
  set id(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "trainer_id")
  int? get trainerId => throw _privateConstructorUsedError;
  @JsonKey(name: "trainer_id")
  set trainerId(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "gym_id")
  int? get gymId => throw _privateConstructorUsedError;
  @JsonKey(name: "gym_id")
  set gymId(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "intro")
  String? get intro => throw _privateConstructorUsedError;
  @JsonKey(name: "intro")
  set intro(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "min_booking_slot_duration")
  int? get minBookingSlotDuration => throw _privateConstructorUsedError;
  @JsonKey(name: "min_booking_slot_duration")
  set minBookingSlotDuration(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "price")
  String? get price => throw _privateConstructorUsedError;
  @JsonKey(name: "price")
  set price(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "book_via_portal")
  bool? get bookViaPortal => throw _privateConstructorUsedError;
  @JsonKey(name: "book_via_portal")
  set bookViaPortal(bool? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "mandatory_payment")
  bool? get mandatoryPayment => throw _privateConstructorUsedError;
  @JsonKey(name: "mandatory_payment")
  set mandatoryPayment(bool? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "prices")
  List<PriceModel>? get prices => throw _privateConstructorUsedError;
  @JsonKey(name: "prices")
  set prices(List<PriceModel>? value) => throw _privateConstructorUsedError;

  /// Serializes this TrainerProfileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrainerProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrainerProfileModelCopyWith<TrainerProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainerProfileModelCopyWith<$Res> {
  factory $TrainerProfileModelCopyWith(
          TrainerProfileModel value, $Res Function(TrainerProfileModel) then) =
      _$TrainerProfileModelCopyWithImpl<$Res, TrainerProfileModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "trainer_id") int? trainerId,
      @JsonKey(name: "gym_id") int? gymId,
      @JsonKey(name: "intro") String? intro,
      @JsonKey(name: "min_booking_slot_duration") int? minBookingSlotDuration,
      @JsonKey(name: "price") String? price,
      @JsonKey(name: "book_via_portal") bool? bookViaPortal,
      @JsonKey(name: "mandatory_payment") bool? mandatoryPayment,
      @JsonKey(name: "prices") List<PriceModel>? prices});
}

/// @nodoc
class _$TrainerProfileModelCopyWithImpl<$Res, $Val extends TrainerProfileModel>
    implements $TrainerProfileModelCopyWith<$Res> {
  _$TrainerProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrainerProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? trainerId = freezed,
    Object? gymId = freezed,
    Object? intro = freezed,
    Object? minBookingSlotDuration = freezed,
    Object? price = freezed,
    Object? bookViaPortal = freezed,
    Object? mandatoryPayment = freezed,
    Object? prices = freezed,
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
      gymId: freezed == gymId
          ? _value.gymId
          : gymId // ignore: cast_nullable_to_non_nullable
              as int?,
      intro: freezed == intro
          ? _value.intro
          : intro // ignore: cast_nullable_to_non_nullable
              as String?,
      minBookingSlotDuration: freezed == minBookingSlotDuration
          ? _value.minBookingSlotDuration
          : minBookingSlotDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      bookViaPortal: freezed == bookViaPortal
          ? _value.bookViaPortal
          : bookViaPortal // ignore: cast_nullable_to_non_nullable
              as bool?,
      mandatoryPayment: freezed == mandatoryPayment
          ? _value.mandatoryPayment
          : mandatoryPayment // ignore: cast_nullable_to_non_nullable
              as bool?,
      prices: freezed == prices
          ? _value.prices
          : prices // ignore: cast_nullable_to_non_nullable
              as List<PriceModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrainerProfileModelImplCopyWith<$Res>
    implements $TrainerProfileModelCopyWith<$Res> {
  factory _$$TrainerProfileModelImplCopyWith(_$TrainerProfileModelImpl value,
          $Res Function(_$TrainerProfileModelImpl) then) =
      __$$TrainerProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "trainer_id") int? trainerId,
      @JsonKey(name: "gym_id") int? gymId,
      @JsonKey(name: "intro") String? intro,
      @JsonKey(name: "min_booking_slot_duration") int? minBookingSlotDuration,
      @JsonKey(name: "price") String? price,
      @JsonKey(name: "book_via_portal") bool? bookViaPortal,
      @JsonKey(name: "mandatory_payment") bool? mandatoryPayment,
      @JsonKey(name: "prices") List<PriceModel>? prices});
}

/// @nodoc
class __$$TrainerProfileModelImplCopyWithImpl<$Res>
    extends _$TrainerProfileModelCopyWithImpl<$Res, _$TrainerProfileModelImpl>
    implements _$$TrainerProfileModelImplCopyWith<$Res> {
  __$$TrainerProfileModelImplCopyWithImpl(_$TrainerProfileModelImpl _value,
      $Res Function(_$TrainerProfileModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TrainerProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? trainerId = freezed,
    Object? gymId = freezed,
    Object? intro = freezed,
    Object? minBookingSlotDuration = freezed,
    Object? price = freezed,
    Object? bookViaPortal = freezed,
    Object? mandatoryPayment = freezed,
    Object? prices = freezed,
  }) {
    return _then(_$TrainerProfileModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      trainerId: freezed == trainerId
          ? _value.trainerId
          : trainerId // ignore: cast_nullable_to_non_nullable
              as int?,
      gymId: freezed == gymId
          ? _value.gymId
          : gymId // ignore: cast_nullable_to_non_nullable
              as int?,
      intro: freezed == intro
          ? _value.intro
          : intro // ignore: cast_nullable_to_non_nullable
              as String?,
      minBookingSlotDuration: freezed == minBookingSlotDuration
          ? _value.minBookingSlotDuration
          : minBookingSlotDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      bookViaPortal: freezed == bookViaPortal
          ? _value.bookViaPortal
          : bookViaPortal // ignore: cast_nullable_to_non_nullable
              as bool?,
      mandatoryPayment: freezed == mandatoryPayment
          ? _value.mandatoryPayment
          : mandatoryPayment // ignore: cast_nullable_to_non_nullable
              as bool?,
      prices: freezed == prices
          ? _value.prices
          : prices // ignore: cast_nullable_to_non_nullable
              as List<PriceModel>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TrainerProfileModelImpl extends _TrainerProfileModel {
  _$TrainerProfileModelImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "trainer_id") required this.trainerId,
      @JsonKey(name: "gym_id") required this.gymId,
      @JsonKey(name: "intro") required this.intro,
      @JsonKey(name: "min_booking_slot_duration")
      required this.minBookingSlotDuration,
      @JsonKey(name: "price") required this.price,
      @JsonKey(name: "book_via_portal") required this.bookViaPortal,
      @JsonKey(name: "mandatory_payment") required this.mandatoryPayment,
      @JsonKey(name: "prices") required this.prices})
      : super._();

  factory _$TrainerProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrainerProfileModelImplFromJson(json);

  @override
  @JsonKey(name: "id")
  int? id;
  @override
  @JsonKey(name: "trainer_id")
  int? trainerId;
  @override
  @JsonKey(name: "gym_id")
  int? gymId;
  @override
  @JsonKey(name: "intro")
  String? intro;
  @override
  @JsonKey(name: "min_booking_slot_duration")
  int? minBookingSlotDuration;
  @override
  @JsonKey(name: "price")
  String? price;
  @override
  @JsonKey(name: "book_via_portal")
  bool? bookViaPortal;
  @override
  @JsonKey(name: "mandatory_payment")
  bool? mandatoryPayment;
  @override
  @JsonKey(name: "prices")
  List<PriceModel>? prices;

  @override
  String toString() {
    return 'TrainerProfileModel(id: $id, trainerId: $trainerId, gymId: $gymId, intro: $intro, minBookingSlotDuration: $minBookingSlotDuration, price: $price, bookViaPortal: $bookViaPortal, mandatoryPayment: $mandatoryPayment, prices: $prices)';
  }

  /// Create a copy of TrainerProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainerProfileModelImplCopyWith<_$TrainerProfileModelImpl> get copyWith =>
      __$$TrainerProfileModelImplCopyWithImpl<_$TrainerProfileModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrainerProfileModelImplToJson(
      this,
    );
  }
}

abstract class _TrainerProfileModel extends TrainerProfileModel {
  factory _TrainerProfileModel(
          {@JsonKey(name: "id") required int? id,
          @JsonKey(name: "trainer_id") required int? trainerId,
          @JsonKey(name: "gym_id") required int? gymId,
          @JsonKey(name: "intro") required String? intro,
          @JsonKey(name: "min_booking_slot_duration")
          required int? minBookingSlotDuration,
          @JsonKey(name: "price") required String? price,
          @JsonKey(name: "book_via_portal") required bool? bookViaPortal,
          @JsonKey(name: "mandatory_payment") required bool? mandatoryPayment,
          @JsonKey(name: "prices") required List<PriceModel>? prices}) =
      _$TrainerProfileModelImpl;
  _TrainerProfileModel._() : super._();

  factory _TrainerProfileModel.fromJson(Map<String, dynamic> json) =
      _$TrainerProfileModelImpl.fromJson;

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
  @JsonKey(name: "gym_id")
  int? get gymId;
  @JsonKey(name: "gym_id")
  set gymId(int? value);
  @override
  @JsonKey(name: "intro")
  String? get intro;
  @JsonKey(name: "intro")
  set intro(String? value);
  @override
  @JsonKey(name: "min_booking_slot_duration")
  int? get minBookingSlotDuration;
  @JsonKey(name: "min_booking_slot_duration")
  set minBookingSlotDuration(int? value);
  @override
  @JsonKey(name: "price")
  String? get price;
  @JsonKey(name: "price")
  set price(String? value);
  @override
  @JsonKey(name: "book_via_portal")
  bool? get bookViaPortal;
  @JsonKey(name: "book_via_portal")
  set bookViaPortal(bool? value);
  @override
  @JsonKey(name: "mandatory_payment")
  bool? get mandatoryPayment;
  @JsonKey(name: "mandatory_payment")
  set mandatoryPayment(bool? value);
  @override
  @JsonKey(name: "prices")
  List<PriceModel>? get prices;
  @JsonKey(name: "prices")
  set prices(List<PriceModel>? value);

  /// Create a copy of TrainerProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrainerProfileModelImplCopyWith<_$TrainerProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
