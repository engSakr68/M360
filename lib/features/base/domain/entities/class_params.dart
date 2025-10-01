class ClassParams {
  bool? bookedOnly;
  int? gymId;
  String? from;
  String? to;
  int? trainerId;
  List<int>? tags;

  ClassParams({
    this.bookedOnly,
    this.gymId,
    required this.from,
    required this.to,
    this.trainerId,
    this.tags,
  });

  String header() {
    String header = "?from=$from&to=$to";

    if (bookedOnly != null) {
      header += "&booked_only=$bookedOnly";
    }

    if (trainerId != null) {
      header += "&trainers[]=$trainerId";
    }

    if (tags != null && tags!.isNotEmpty) {
      for (int i = 0; i < tags!.length; i++) {
        header += "&tags[$i]=${tags![i]}";
      }
    }
    return header;
  }
}
