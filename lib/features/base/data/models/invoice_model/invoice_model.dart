import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_model.freezed.dart';
part 'invoice_model.g.dart';

@unfreezed
@immutable
class InvoiceModel with _$InvoiceModel {
  const InvoiceModel._();

  @JsonSerializable(explicitToJson: true)
  factory InvoiceModel({
    @JsonKey(name: "scheduled_date") required String? scheduledDate,
    @JsonKey(name: "oinvoice_id") required int? oinvoiceId,
    @JsonKey(name: "invoice_number") required String? invoiceNumber,
    @JsonKey(name: "future_oinvoice_id") required int? futureOinvoiceId,
    @JsonKey(name: "oinvoice_state") required String? oinvoiceState,
    @JsonKey(name: "amount") required String? amount,
    @JsonKey(name: "member_plan_id") required int? memberPlanId,
    @JsonKey(name: "attempts") required int? attempts,
    @JsonKey(name: "grouped") required bool? grouped,
  }) = _InvoiceModel;

  factory InvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceModelFromJson(json);
}
