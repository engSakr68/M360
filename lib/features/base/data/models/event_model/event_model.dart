import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:member360/features/base/data/models/event_trainer_model/event_trainer_model.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@unfreezed
@immutable
class EventModel with _$EventModel {
  const EventModel._();

  @JsonSerializable(explicitToJson: true)
  factory EventModel({
    @JsonKey(name: "id") required int? id,
    @JsonKey(name: "title") required String? title,
    @JsonKey(name: "description") required String? description,
    @JsonKey(name: "trainer") required EventTrainerModel? trainer,
    @JsonKey(name: "resourceId") required int? resourceId,
    @JsonKey(name: "start") required String? start,
    @JsonKey(name: "end") required String? end,
    @JsonKey(name: "color") required String? color,
    @JsonKey(name: "date") required String? date,
    @JsonKey(name: "unavailability") required bool? unavailability,
    @JsonKey(name: "already_booked", defaultValue: false) required bool? alreadyBooked,
    @JsonKey(name: "recurring") required bool? recurring,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
}
