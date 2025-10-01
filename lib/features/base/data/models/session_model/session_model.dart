import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:member360/features/base/data/models/event_model/event_model.dart';
import 'package:member360/features/base/data/models/trainer_model/trainer_model.dart';

part 'session_model.freezed.dart';
part 'session_model.g.dart';

@unfreezed
@immutable
class SessionModel with _$SessionModel {
  const SessionModel._();

  @JsonSerializable(explicitToJson: true)
  factory SessionModel({
    @JsonKey(name: "trainers") required List<TrainerModel>? trainers,
    @JsonKey(name: "events") required List<EventModel>? events,
  }) = _SessionModel;

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);
}
