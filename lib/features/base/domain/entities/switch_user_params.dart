class SwitchUserParams {
  int gymId;
  int memberId;

  SwitchUserParams({
    required this.gymId,
    required this.memberId,
  });

  factory SwitchUserParams.copyWith({
    required int gymId,
    required int memberId,
  }) {
    return SwitchUserParams(
      gymId: gymId,
      memberId: memberId,
    );
  }

  Map<String, dynamic> toJson() => {
        "gym_id": gymId,
        "member_id": memberId,
      };

  factory SwitchUserParams.fromJson(Map<String, dynamic> json) => SwitchUserParams(
        gymId: json['gym_id'],
        memberId: json['member_id'],
      );
}
