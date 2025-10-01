import 'dart:io';

class DeactivateParams {
  String reason;
  String negative;
  String positive;
  String recommend;
  String general;
  File signature;
  int gymId;
  int memberId;

  DeactivateParams({
    required this.reason,
    required this.negative,
    required this.positive,
    required this.recommend,
    required this.general,
    required this.signature,
    required this.gymId,
    required this.memberId,
  });

  factory DeactivateParams.copyWith({
    required String reason,
    required String negative,
    required String positive,
    required String recommend,
    required String general,
    required File signature,
    required int gymId,
    required int memberId,
  }) {
    return DeactivateParams(
      reason: reason,
      negative: negative,
      positive: positive,
      recommend: recommend,
      general: general,
      signature: signature,
      gymId: gymId,
      memberId: memberId,
    );
  }

  Map<String, dynamic> toJson() => {
        "reason": reason,
        "feedback_negatives": negative,
        "feedback_positives": positive,
        "recommend": recommend,
        "general_comments": general,
        "signature": signature,
      };

  factory DeactivateParams.fromJson(Map<String, dynamic> json) =>
      DeactivateParams(
        reason: json['reason'],
        gymId: json['gym_id'],
        negative: json['feedback_negatives'],
        positive: json['feedback_positives'],
        recommend: json['recommend'],
        general: json['general_comments'],
        signature: json['signature'],
        memberId: json['member_id'],
      );
}
