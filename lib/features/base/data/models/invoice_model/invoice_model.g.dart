// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvoiceModelImpl _$$InvoiceModelImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceModelImpl(
      scheduledDate: json['scheduled_date'] as String?,
      oinvoiceId: (json['oinvoice_id'] as num?)?.toInt(),
      invoiceNumber: json['invoice_number'] as String?,
      futureOinvoiceId: (json['future_oinvoice_id'] as num?)?.toInt(),
      oinvoiceState: json['oinvoice_state'] as String?,
      amount: json['amount'] as String?,
      memberPlanId: (json['member_plan_id'] as num?)?.toInt(),
      attempts: (json['attempts'] as num?)?.toInt(),
      grouped: json['grouped'] as bool?,
    );

Map<String, dynamic> _$$InvoiceModelImplToJson(_$InvoiceModelImpl instance) =>
    <String, dynamic>{
      'scheduled_date': instance.scheduledDate,
      'oinvoice_id': instance.oinvoiceId,
      'invoice_number': instance.invoiceNumber,
      'future_oinvoice_id': instance.futureOinvoiceId,
      'oinvoice_state': instance.oinvoiceState,
      'amount': instance.amount,
      'member_plan_id': instance.memberPlanId,
      'attempts': instance.attempts,
      'grouped': instance.grouped,
    };
