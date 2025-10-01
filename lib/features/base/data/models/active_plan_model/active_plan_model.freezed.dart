// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_plan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ActivePlanModel _$ActivePlanModelFromJson(Map<String, dynamic> json) {
  return _ActivePlanModel.fromJson(json);
}

/// @nodoc
mixin _$ActivePlanModel {
  @JsonKey(name: "member_plan_id")
  int? get memberPlanId => throw _privateConstructorUsedError;
  @JsonKey(name: "member_plan_id")
  set memberPlanId(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "plan_name")
  String? get planName => throw _privateConstructorUsedError;
  @JsonKey(name: "plan_name")
  set planName(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "duration")
  String? get duration => throw _privateConstructorUsedError;
  @JsonKey(name: "duration")
  set duration(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "duration_count")
  int? get durationCount => throw _privateConstructorUsedError;
  @JsonKey(name: "duration_count")
  set durationCount(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "entry_count")
  int? get entryCount => throw _privateConstructorUsedError;
  @JsonKey(name: "entry_count")
  set entryCount(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "home_gym_name")
  String? get homeGymName => throw _privateConstructorUsedError;
  @JsonKey(name: "home_gym_name")
  set homeGymName(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "membership_start")
  String? get membershipStart => throw _privateConstructorUsedError;
  @JsonKey(name: "membership_start")
  set membershipStart(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "membership_end")
  String? get membershipEnd => throw _privateConstructorUsedError;
  @JsonKey(name: "membership_end")
  set membershipEnd(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "current_balance")
  int? get currentBalance => throw _privateConstructorUsedError;
  @JsonKey(name: "current_balance")
  set currentBalance(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "price")
  String? get price => throw _privateConstructorUsedError;
  @JsonKey(name: "price")
  set price(String? value) => throw _privateConstructorUsedError;

  /// Serializes this ActivePlanModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivePlanModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivePlanModelCopyWith<ActivePlanModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivePlanModelCopyWith<$Res> {
  factory $ActivePlanModelCopyWith(
          ActivePlanModel value, $Res Function(ActivePlanModel) then) =
      _$ActivePlanModelCopyWithImpl<$Res, ActivePlanModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "member_plan_id") int? memberPlanId,
      @JsonKey(name: "plan_name") String? planName,
      @JsonKey(name: "duration") String? duration,
      @JsonKey(name: "duration_count") int? durationCount,
      @JsonKey(name: "entry_count") int? entryCount,
      @JsonKey(name: "home_gym_name") String? homeGymName,
      @JsonKey(name: "membership_start") String? membershipStart,
      @JsonKey(name: "membership_end") String? membershipEnd,
      @JsonKey(name: "current_balance") int? currentBalance,
      @JsonKey(name: "price") String? price});
}

/// @nodoc
class _$ActivePlanModelCopyWithImpl<$Res, $Val extends ActivePlanModel>
    implements $ActivePlanModelCopyWith<$Res> {
  _$ActivePlanModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivePlanModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberPlanId = freezed,
    Object? planName = freezed,
    Object? duration = freezed,
    Object? durationCount = freezed,
    Object? entryCount = freezed,
    Object? homeGymName = freezed,
    Object? membershipStart = freezed,
    Object? membershipEnd = freezed,
    Object? currentBalance = freezed,
    Object? price = freezed,
  }) {
    return _then(_value.copyWith(
      memberPlanId: freezed == memberPlanId
          ? _value.memberPlanId
          : memberPlanId // ignore: cast_nullable_to_non_nullable
              as int?,
      planName: freezed == planName
          ? _value.planName
          : planName // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
      durationCount: freezed == durationCount
          ? _value.durationCount
          : durationCount // ignore: cast_nullable_to_non_nullable
              as int?,
      entryCount: freezed == entryCount
          ? _value.entryCount
          : entryCount // ignore: cast_nullable_to_non_nullable
              as int?,
      homeGymName: freezed == homeGymName
          ? _value.homeGymName
          : homeGymName // ignore: cast_nullable_to_non_nullable
              as String?,
      membershipStart: freezed == membershipStart
          ? _value.membershipStart
          : membershipStart // ignore: cast_nullable_to_non_nullable
              as String?,
      membershipEnd: freezed == membershipEnd
          ? _value.membershipEnd
          : membershipEnd // ignore: cast_nullable_to_non_nullable
              as String?,
      currentBalance: freezed == currentBalance
          ? _value.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivePlanModelImplCopyWith<$Res>
    implements $ActivePlanModelCopyWith<$Res> {
  factory _$$ActivePlanModelImplCopyWith(_$ActivePlanModelImpl value,
          $Res Function(_$ActivePlanModelImpl) then) =
      __$$ActivePlanModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "member_plan_id") int? memberPlanId,
      @JsonKey(name: "plan_name") String? planName,
      @JsonKey(name: "duration") String? duration,
      @JsonKey(name: "duration_count") int? durationCount,
      @JsonKey(name: "entry_count") int? entryCount,
      @JsonKey(name: "home_gym_name") String? homeGymName,
      @JsonKey(name: "membership_start") String? membershipStart,
      @JsonKey(name: "membership_end") String? membershipEnd,
      @JsonKey(name: "current_balance") int? currentBalance,
      @JsonKey(name: "price") String? price});
}

/// @nodoc
class __$$ActivePlanModelImplCopyWithImpl<$Res>
    extends _$ActivePlanModelCopyWithImpl<$Res, _$ActivePlanModelImpl>
    implements _$$ActivePlanModelImplCopyWith<$Res> {
  __$$ActivePlanModelImplCopyWithImpl(
      _$ActivePlanModelImpl _value, $Res Function(_$ActivePlanModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActivePlanModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberPlanId = freezed,
    Object? planName = freezed,
    Object? duration = freezed,
    Object? durationCount = freezed,
    Object? entryCount = freezed,
    Object? homeGymName = freezed,
    Object? membershipStart = freezed,
    Object? membershipEnd = freezed,
    Object? currentBalance = freezed,
    Object? price = freezed,
  }) {
    return _then(_$ActivePlanModelImpl(
      memberPlanId: freezed == memberPlanId
          ? _value.memberPlanId
          : memberPlanId // ignore: cast_nullable_to_non_nullable
              as int?,
      planName: freezed == planName
          ? _value.planName
          : planName // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
      durationCount: freezed == durationCount
          ? _value.durationCount
          : durationCount // ignore: cast_nullable_to_non_nullable
              as int?,
      entryCount: freezed == entryCount
          ? _value.entryCount
          : entryCount // ignore: cast_nullable_to_non_nullable
              as int?,
      homeGymName: freezed == homeGymName
          ? _value.homeGymName
          : homeGymName // ignore: cast_nullable_to_non_nullable
              as String?,
      membershipStart: freezed == membershipStart
          ? _value.membershipStart
          : membershipStart // ignore: cast_nullable_to_non_nullable
              as String?,
      membershipEnd: freezed == membershipEnd
          ? _value.membershipEnd
          : membershipEnd // ignore: cast_nullable_to_non_nullable
              as String?,
      currentBalance: freezed == currentBalance
          ? _value.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ActivePlanModelImpl extends _ActivePlanModel {
  _$ActivePlanModelImpl(
      {@JsonKey(name: "member_plan_id") required this.memberPlanId,
      @JsonKey(name: "plan_name") required this.planName,
      @JsonKey(name: "duration") required this.duration,
      @JsonKey(name: "duration_count") required this.durationCount,
      @JsonKey(name: "entry_count") required this.entryCount,
      @JsonKey(name: "home_gym_name") required this.homeGymName,
      @JsonKey(name: "membership_start") required this.membershipStart,
      @JsonKey(name: "membership_end") required this.membershipEnd,
      @JsonKey(name: "current_balance") required this.currentBalance,
      @JsonKey(name: "price") required this.price})
      : super._();

  factory _$ActivePlanModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivePlanModelImplFromJson(json);

  @override
  @JsonKey(name: "member_plan_id")
  int? memberPlanId;
  @override
  @JsonKey(name: "plan_name")
  String? planName;
  @override
  @JsonKey(name: "duration")
  String? duration;
  @override
  @JsonKey(name: "duration_count")
  int? durationCount;
  @override
  @JsonKey(name: "entry_count")
  int? entryCount;
  @override
  @JsonKey(name: "home_gym_name")
  String? homeGymName;
  @override
  @JsonKey(name: "membership_start")
  String? membershipStart;
  @override
  @JsonKey(name: "membership_end")
  String? membershipEnd;
  @override
  @JsonKey(name: "current_balance")
  int? currentBalance;
  @override
  @JsonKey(name: "price")
  String? price;

  @override
  String toString() {
    return 'ActivePlanModel(memberPlanId: $memberPlanId, planName: $planName, duration: $duration, durationCount: $durationCount, entryCount: $entryCount, homeGymName: $homeGymName, membershipStart: $membershipStart, membershipEnd: $membershipEnd, currentBalance: $currentBalance, price: $price)';
  }

  /// Create a copy of ActivePlanModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivePlanModelImplCopyWith<_$ActivePlanModelImpl> get copyWith =>
      __$$ActivePlanModelImplCopyWithImpl<_$ActivePlanModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivePlanModelImplToJson(
      this,
    );
  }
}

abstract class _ActivePlanModel extends ActivePlanModel {
  factory _ActivePlanModel(
      {@JsonKey(name: "member_plan_id") required int? memberPlanId,
      @JsonKey(name: "plan_name") required String? planName,
      @JsonKey(name: "duration") required String? duration,
      @JsonKey(name: "duration_count") required int? durationCount,
      @JsonKey(name: "entry_count") required int? entryCount,
      @JsonKey(name: "home_gym_name") required String? homeGymName,
      @JsonKey(name: "membership_start") required String? membershipStart,
      @JsonKey(name: "membership_end") required String? membershipEnd,
      @JsonKey(name: "current_balance") required int? currentBalance,
      @JsonKey(name: "price") required String? price}) = _$ActivePlanModelImpl;
  _ActivePlanModel._() : super._();

  factory _ActivePlanModel.fromJson(Map<String, dynamic> json) =
      _$ActivePlanModelImpl.fromJson;

  @override
  @JsonKey(name: "member_plan_id")
  int? get memberPlanId;
  @JsonKey(name: "member_plan_id")
  set memberPlanId(int? value);
  @override
  @JsonKey(name: "plan_name")
  String? get planName;
  @JsonKey(name: "plan_name")
  set planName(String? value);
  @override
  @JsonKey(name: "duration")
  String? get duration;
  @JsonKey(name: "duration")
  set duration(String? value);
  @override
  @JsonKey(name: "duration_count")
  int? get durationCount;
  @JsonKey(name: "duration_count")
  set durationCount(int? value);
  @override
  @JsonKey(name: "entry_count")
  int? get entryCount;
  @JsonKey(name: "entry_count")
  set entryCount(int? value);
  @override
  @JsonKey(name: "home_gym_name")
  String? get homeGymName;
  @JsonKey(name: "home_gym_name")
  set homeGymName(String? value);
  @override
  @JsonKey(name: "membership_start")
  String? get membershipStart;
  @JsonKey(name: "membership_start")
  set membershipStart(String? value);
  @override
  @JsonKey(name: "membership_end")
  String? get membershipEnd;
  @JsonKey(name: "membership_end")
  set membershipEnd(String? value);
  @override
  @JsonKey(name: "current_balance")
  int? get currentBalance;
  @JsonKey(name: "current_balance")
  set currentBalance(int? value);
  @override
  @JsonKey(name: "price")
  String? get price;
  @JsonKey(name: "price")
  set price(String? value);

  /// Create a copy of ActivePlanModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivePlanModelImplCopyWith<_$ActivePlanModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
