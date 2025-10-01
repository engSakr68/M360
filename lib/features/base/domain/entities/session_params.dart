class SessionParams {
  String? date;
  int? gymId;
  String? start;
  String? end;
  int? trainerId;
  String? title;

  SessionParams({
    this.date,
    this.gymId,
    this.start,
    this.end,
    this.trainerId,
    this.title,
  });

  factory SessionParams.copyWith({
    required int? gymId,
    required String? date,
    required String? start,
    required String? end,
    required String? title,
    required int? trainerId,
  }) {
    return SessionParams(
      date: date,
      gymId: gymId,
      start: start,
      end: end,
      title: title,
      trainerId: trainerId,
    );
  }

  Map<String, dynamic> toJson() => {
        "start": start,
        "end": end,
        "date": date,
        "gym_id": gymId,
        "trainer_id": trainerId,
        "title": title,
      };

  factory SessionParams.fromJson(Map<String, dynamic> json) => SessionParams(
        date: json['date'],
        gymId: json['gym_id'],
        start: json['start'],
        end: json['end'],
        trainerId: json['trainer_id'],
        title: json['title'],
      );
}
