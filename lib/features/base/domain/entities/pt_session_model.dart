class PTSessionParams {
  bool? bookedOnly;
  int? gymId;
  int? gym;
  String? from;
  String? to;
  int? trainerId;
  List<int>? tags;
  String? memberId;

  PTSessionParams({
    this.bookedOnly,
    this.gymId,
    this.gym,
    required this.from,
    required this.to,
    this.trainerId,
    this.tags,
    this.memberId,
  });

  String header() {
    String header = "?from=$from&to=$to";

    if (gym != null) {
      header += "&gym=$gym";
    }

    if (gymId != null) {
      header += "&gym_id=$gymId";
    }

    if (bookedOnly != null) {
      header += "&booked_only=$bookedOnly";
    }

    if (trainerId != null) {
      header += "&trainers[]=$trainerId";
    }

    if (memberId != null) {
      header += "&member_id=$memberId";
    }

    if (tags != null && tags!.isNotEmpty) {
      for (int i = 0; i < tags!.length; i++) {
        header += "&tags[$i]=${tags![i]}";
      }
    }
    return header;
  }
}
