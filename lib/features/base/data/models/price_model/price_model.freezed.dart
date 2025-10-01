// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PriceModel _$PriceModelFromJson(Map<String, dynamic> json) {
  return _PriceModel.fromJson(json);
}

/// @nodoc
mixin _$PriceModel {
  @JsonKey(name: "id")
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: "id")
  set id(int value) => throw _privateConstructorUsedError;
  @JsonKey(name: "trainer_gym_profile_id")
  int get trainerGymProfileId => throw _privateConstructorUsedError;
  @JsonKey(name: "trainer_gym_profile_id")
  set trainerGymProfileId(int value) => throw _privateConstructorUsedError;
  @JsonKey(name: "price")
  String get price => throw _privateConstructorUsedError;
  @JsonKey(name: "price")
  set price(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: "minutes")
  int get minutes => throw _privateConstructorUsedError;
  @JsonKey(name: "minutes")
  set minutes(int value) => throw _privateConstructorUsedError;
  @JsonKey(name: "label")
  String get label => throw _privateConstructorUsedError;
  @JsonKey(name: "label")
  set label(String value) => throw _privateConstructorUsedError;

  /// Serializes this PriceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PriceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceModelCopyWith<PriceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceModelCopyWith<$Res> {
  factory $PriceModelCopyWith(
          PriceModel value, $Res Function(PriceModel) then) =
      _$PriceModelCopyWithImpl<$Res, PriceModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "trainer_gym_profile_id") int trainerGymProfileId,
      @JsonKey(name: "price") String price,
      @JsonKey(name: "minutes") int minutes,
      @JsonKey(name: "label") String label});
}

/// @nodoc
class _$PriceModelCopyWithImpl<$Res, $Val extends PriceModel>
    implements $PriceModelCopyWith<$Res> {
  _$PriceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PriceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? trainerGymProfileId = null,
    Object? price = null,
    Object? minutes = null,
    Object? label = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      trainerGymProfileId: null == trainerGymProfileId
          ? _value.trainerGymProfileId
          : trainerGymProfileId // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      minutes: null == minutes
          ? _value.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PriceModelImplCopyWith<$Res>
    implements $PriceModelCopyWith<$Res> {
  factory _$$PriceModelImplCopyWith(
          _$PriceModelImpl value, $Res Function(_$PriceModelImpl) then) =
      __$$PriceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "trainer_gym_profile_id") int trainerGymProfileId,
      @JsonKey(name: "price") String price,
      @JsonKey(name: "minutes") int minutes,
      @JsonKey(name: "label") String label});
}

/// @nodoc
class __$$PriceModelImplCopyWithImpl<$Res>
    extends _$PriceModelCopyWithImpl<$Res, _$PriceModelImpl>
    implements _$$PriceModelImplCopyWith<$Res> {
  __$$PriceModelImplCopyWithImpl(
      _$PriceModelImpl _value, $Res Function(_$PriceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PriceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? trainerGymProfileId = null,
    Object? price = null,
    Object? minutes = null,
    Object? label = null,
  }) {
    return _then(_$PriceModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      trainerGymProfileId: null == trainerGymProfileId
          ? _value.trainerGymProfileId
          : trainerGymProfileId // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      minutes: null == minutes
          ? _value.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$PriceModelImpl extends _PriceModel {
  _$PriceModelImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "trainer_gym_profile_id")
      required this.trainerGymProfileId,
      @JsonKey(name: "price") required this.price,
      @JsonKey(name: "minutes") required this.minutes,
      @JsonKey(name: "label") required this.label})
      : super._();

  factory _$PriceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceModelImplFromJson(json);

  @override
  @JsonKey(name: "id")
  int id;
  @override
  @JsonKey(name: "trainer_gym_profile_id")
  int trainerGymProfileId;
  @override
  @JsonKey(name: "price")
  String price;
  @override
  @JsonKey(name: "minutes")
  int minutes;
  @override
  @JsonKey(name: "label")
  String label;

  @override
  String toString() {
    return 'PriceModel(id: $id, trainerGymProfileId: $trainerGymProfileId, price: $price, minutes: $minutes, label: $label)';
  }

  /// Create a copy of PriceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceModelImplCopyWith<_$PriceModelImpl> get copyWith =>
      __$$PriceModelImplCopyWithImpl<_$PriceModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceModelImplToJson(
      this,
    );
  }
}

abstract class _PriceModel extends PriceModel {
  factory _PriceModel(
      {@JsonKey(name: "id") required int id,
      @JsonKey(name: "trainer_gym_profile_id") required int trainerGymProfileId,
      @JsonKey(name: "price") required String price,
      @JsonKey(name: "minutes") required int minutes,
      @JsonKey(name: "label") required String label}) = _$PriceModelImpl;
  _PriceModel._() : super._();

  factory _PriceModel.fromJson(Map<String, dynamic> json) =
      _$PriceModelImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int get id;
  @JsonKey(name: "id")
  set id(int value);
  @override
  @JsonKey(name: "trainer_gym_profile_id")
  int get trainerGymProfileId;
  @JsonKey(name: "trainer_gym_profile_id")
  set trainerGymProfileId(int value);
  @override
  @JsonKey(name: "price")
  String get price;
  @JsonKey(name: "price")
  set price(String value);
  @override
  @JsonKey(name: "minutes")
  int get minutes;
  @JsonKey(name: "minutes")
  set minutes(int value);
  @override
  @JsonKey(name: "label")
  String get label;
  @JsonKey(name: "label")
  set label(String value);

  /// Create a copy of PriceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceModelImplCopyWith<_$PriceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
