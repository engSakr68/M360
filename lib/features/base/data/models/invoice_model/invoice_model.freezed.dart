// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InvoiceModel _$InvoiceModelFromJson(Map<String, dynamic> json) {
  return _InvoiceModel.fromJson(json);
}

/// @nodoc
mixin _$InvoiceModel {
  @JsonKey(name: "scheduled_date")
  String? get scheduledDate => throw _privateConstructorUsedError;
  @JsonKey(name: "scheduled_date")
  set scheduledDate(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "oinvoice_id")
  int? get oinvoiceId => throw _privateConstructorUsedError;
  @JsonKey(name: "oinvoice_id")
  set oinvoiceId(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "invoice_number")
  String? get invoiceNumber => throw _privateConstructorUsedError;
  @JsonKey(name: "invoice_number")
  set invoiceNumber(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "future_oinvoice_id")
  int? get futureOinvoiceId => throw _privateConstructorUsedError;
  @JsonKey(name: "future_oinvoice_id")
  set futureOinvoiceId(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "oinvoice_state")
  String? get oinvoiceState => throw _privateConstructorUsedError;
  @JsonKey(name: "oinvoice_state")
  set oinvoiceState(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "amount")
  String? get amount => throw _privateConstructorUsedError;
  @JsonKey(name: "amount")
  set amount(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "member_plan_id")
  int? get memberPlanId => throw _privateConstructorUsedError;
  @JsonKey(name: "member_plan_id")
  set memberPlanId(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "attempts")
  int? get attempts => throw _privateConstructorUsedError;
  @JsonKey(name: "attempts")
  set attempts(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "grouped")
  bool? get grouped => throw _privateConstructorUsedError;
  @JsonKey(name: "grouped")
  set grouped(bool? value) => throw _privateConstructorUsedError;

  /// Serializes this InvoiceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InvoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvoiceModelCopyWith<InvoiceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceModelCopyWith<$Res> {
  factory $InvoiceModelCopyWith(
          InvoiceModel value, $Res Function(InvoiceModel) then) =
      _$InvoiceModelCopyWithImpl<$Res, InvoiceModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "scheduled_date") String? scheduledDate,
      @JsonKey(name: "oinvoice_id") int? oinvoiceId,
      @JsonKey(name: "invoice_number") String? invoiceNumber,
      @JsonKey(name: "future_oinvoice_id") int? futureOinvoiceId,
      @JsonKey(name: "oinvoice_state") String? oinvoiceState,
      @JsonKey(name: "amount") String? amount,
      @JsonKey(name: "member_plan_id") int? memberPlanId,
      @JsonKey(name: "attempts") int? attempts,
      @JsonKey(name: "grouped") bool? grouped});
}

/// @nodoc
class _$InvoiceModelCopyWithImpl<$Res, $Val extends InvoiceModel>
    implements $InvoiceModelCopyWith<$Res> {
  _$InvoiceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scheduledDate = freezed,
    Object? oinvoiceId = freezed,
    Object? invoiceNumber = freezed,
    Object? futureOinvoiceId = freezed,
    Object? oinvoiceState = freezed,
    Object? amount = freezed,
    Object? memberPlanId = freezed,
    Object? attempts = freezed,
    Object? grouped = freezed,
  }) {
    return _then(_value.copyWith(
      scheduledDate: freezed == scheduledDate
          ? _value.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as String?,
      oinvoiceId: freezed == oinvoiceId
          ? _value.oinvoiceId
          : oinvoiceId // ignore: cast_nullable_to_non_nullable
              as int?,
      invoiceNumber: freezed == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      futureOinvoiceId: freezed == futureOinvoiceId
          ? _value.futureOinvoiceId
          : futureOinvoiceId // ignore: cast_nullable_to_non_nullable
              as int?,
      oinvoiceState: freezed == oinvoiceState
          ? _value.oinvoiceState
          : oinvoiceState // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      memberPlanId: freezed == memberPlanId
          ? _value.memberPlanId
          : memberPlanId // ignore: cast_nullable_to_non_nullable
              as int?,
      attempts: freezed == attempts
          ? _value.attempts
          : attempts // ignore: cast_nullable_to_non_nullable
              as int?,
      grouped: freezed == grouped
          ? _value.grouped
          : grouped // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoiceModelImplCopyWith<$Res>
    implements $InvoiceModelCopyWith<$Res> {
  factory _$$InvoiceModelImplCopyWith(
          _$InvoiceModelImpl value, $Res Function(_$InvoiceModelImpl) then) =
      __$$InvoiceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "scheduled_date") String? scheduledDate,
      @JsonKey(name: "oinvoice_id") int? oinvoiceId,
      @JsonKey(name: "invoice_number") String? invoiceNumber,
      @JsonKey(name: "future_oinvoice_id") int? futureOinvoiceId,
      @JsonKey(name: "oinvoice_state") String? oinvoiceState,
      @JsonKey(name: "amount") String? amount,
      @JsonKey(name: "member_plan_id") int? memberPlanId,
      @JsonKey(name: "attempts") int? attempts,
      @JsonKey(name: "grouped") bool? grouped});
}

/// @nodoc
class __$$InvoiceModelImplCopyWithImpl<$Res>
    extends _$InvoiceModelCopyWithImpl<$Res, _$InvoiceModelImpl>
    implements _$$InvoiceModelImplCopyWith<$Res> {
  __$$InvoiceModelImplCopyWithImpl(
      _$InvoiceModelImpl _value, $Res Function(_$InvoiceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of InvoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scheduledDate = freezed,
    Object? oinvoiceId = freezed,
    Object? invoiceNumber = freezed,
    Object? futureOinvoiceId = freezed,
    Object? oinvoiceState = freezed,
    Object? amount = freezed,
    Object? memberPlanId = freezed,
    Object? attempts = freezed,
    Object? grouped = freezed,
  }) {
    return _then(_$InvoiceModelImpl(
      scheduledDate: freezed == scheduledDate
          ? _value.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as String?,
      oinvoiceId: freezed == oinvoiceId
          ? _value.oinvoiceId
          : oinvoiceId // ignore: cast_nullable_to_non_nullable
              as int?,
      invoiceNumber: freezed == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      futureOinvoiceId: freezed == futureOinvoiceId
          ? _value.futureOinvoiceId
          : futureOinvoiceId // ignore: cast_nullable_to_non_nullable
              as int?,
      oinvoiceState: freezed == oinvoiceState
          ? _value.oinvoiceState
          : oinvoiceState // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      memberPlanId: freezed == memberPlanId
          ? _value.memberPlanId
          : memberPlanId // ignore: cast_nullable_to_non_nullable
              as int?,
      attempts: freezed == attempts
          ? _value.attempts
          : attempts // ignore: cast_nullable_to_non_nullable
              as int?,
      grouped: freezed == grouped
          ? _value.grouped
          : grouped // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$InvoiceModelImpl extends _InvoiceModel {
  _$InvoiceModelImpl(
      {@JsonKey(name: "scheduled_date") required this.scheduledDate,
      @JsonKey(name: "oinvoice_id") required this.oinvoiceId,
      @JsonKey(name: "invoice_number") required this.invoiceNumber,
      @JsonKey(name: "future_oinvoice_id") required this.futureOinvoiceId,
      @JsonKey(name: "oinvoice_state") required this.oinvoiceState,
      @JsonKey(name: "amount") required this.amount,
      @JsonKey(name: "member_plan_id") required this.memberPlanId,
      @JsonKey(name: "attempts") required this.attempts,
      @JsonKey(name: "grouped") required this.grouped})
      : super._();

  factory _$InvoiceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceModelImplFromJson(json);

  @override
  @JsonKey(name: "scheduled_date")
  String? scheduledDate;
  @override
  @JsonKey(name: "oinvoice_id")
  int? oinvoiceId;
  @override
  @JsonKey(name: "invoice_number")
  String? invoiceNumber;
  @override
  @JsonKey(name: "future_oinvoice_id")
  int? futureOinvoiceId;
  @override
  @JsonKey(name: "oinvoice_state")
  String? oinvoiceState;
  @override
  @JsonKey(name: "amount")
  String? amount;
  @override
  @JsonKey(name: "member_plan_id")
  int? memberPlanId;
  @override
  @JsonKey(name: "attempts")
  int? attempts;
  @override
  @JsonKey(name: "grouped")
  bool? grouped;

  @override
  String toString() {
    return 'InvoiceModel(scheduledDate: $scheduledDate, oinvoiceId: $oinvoiceId, invoiceNumber: $invoiceNumber, futureOinvoiceId: $futureOinvoiceId, oinvoiceState: $oinvoiceState, amount: $amount, memberPlanId: $memberPlanId, attempts: $attempts, grouped: $grouped)';
  }

  /// Create a copy of InvoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceModelImplCopyWith<_$InvoiceModelImpl> get copyWith =>
      __$$InvoiceModelImplCopyWithImpl<_$InvoiceModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceModelImplToJson(
      this,
    );
  }
}

abstract class _InvoiceModel extends InvoiceModel {
  factory _InvoiceModel(
      {@JsonKey(name: "scheduled_date") required String? scheduledDate,
      @JsonKey(name: "oinvoice_id") required int? oinvoiceId,
      @JsonKey(name: "invoice_number") required String? invoiceNumber,
      @JsonKey(name: "future_oinvoice_id") required int? futureOinvoiceId,
      @JsonKey(name: "oinvoice_state") required String? oinvoiceState,
      @JsonKey(name: "amount") required String? amount,
      @JsonKey(name: "member_plan_id") required int? memberPlanId,
      @JsonKey(name: "attempts") required int? attempts,
      @JsonKey(name: "grouped") required bool? grouped}) = _$InvoiceModelImpl;
  _InvoiceModel._() : super._();

  factory _InvoiceModel.fromJson(Map<String, dynamic> json) =
      _$InvoiceModelImpl.fromJson;

  @override
  @JsonKey(name: "scheduled_date")
  String? get scheduledDate;
  @JsonKey(name: "scheduled_date")
  set scheduledDate(String? value);
  @override
  @JsonKey(name: "oinvoice_id")
  int? get oinvoiceId;
  @JsonKey(name: "oinvoice_id")
  set oinvoiceId(int? value);
  @override
  @JsonKey(name: "invoice_number")
  String? get invoiceNumber;
  @JsonKey(name: "invoice_number")
  set invoiceNumber(String? value);
  @override
  @JsonKey(name: "future_oinvoice_id")
  int? get futureOinvoiceId;
  @JsonKey(name: "future_oinvoice_id")
  set futureOinvoiceId(int? value);
  @override
  @JsonKey(name: "oinvoice_state")
  String? get oinvoiceState;
  @JsonKey(name: "oinvoice_state")
  set oinvoiceState(String? value);
  @override
  @JsonKey(name: "amount")
  String? get amount;
  @JsonKey(name: "amount")
  set amount(String? value);
  @override
  @JsonKey(name: "member_plan_id")
  int? get memberPlanId;
  @JsonKey(name: "member_plan_id")
  set memberPlanId(int? value);
  @override
  @JsonKey(name: "attempts")
  int? get attempts;
  @JsonKey(name: "attempts")
  set attempts(int? value);
  @override
  @JsonKey(name: "grouped")
  bool? get grouped;
  @JsonKey(name: "grouped")
  set grouped(bool? value);

  /// Create a copy of InvoiceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceModelImplCopyWith<_$InvoiceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
