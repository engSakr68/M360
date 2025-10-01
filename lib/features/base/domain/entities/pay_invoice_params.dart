class PayInvoiceParams {
  String gymId;
  String date;
  String amount;
  String memberPlanId;

  PayInvoiceParams({
    required this.gymId,
    required this.date,
    required this.amount,
    required this.memberPlanId,
  });

  factory PayInvoiceParams.copyWith({
    required String gymId,
    required String date,
    required String amount,
    required String memberPlanId,
  }) {
    return PayInvoiceParams(
      date: date,
      amount: amount,
      memberPlanId: memberPlanId,
      gymId: gymId,
    );
  }

  Map<String, dynamic> toJson() => {
        "chosen_gym_id": gymId,
        "scheduled_date": date,
        "amount": amount,
      };

  factory PayInvoiceParams.fromJson(Map<String, dynamic> json) =>
      PayInvoiceParams(
        date: json['scheduled_date'],
        gymId: json['chosen_gym_id'],
        amount: json['amount'],
        memberPlanId: json['member_plan_id'],
      );
}
