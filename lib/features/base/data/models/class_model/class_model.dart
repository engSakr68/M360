import 'package:freezed_annotation/freezed_annotation.dart';

part 'class_model.freezed.dart';
part 'class_model.g.dart';

@unfreezed
@immutable
class ClassModel with _$ClassModel {
  const ClassModel._();

  @JsonSerializable(explicitToJson: true)
  factory ClassModel({
    @JsonKey(name: "id") required int? id,
    @JsonKey(name: "title") required String? title,
    @JsonKey(name: "start") required String? start,
    @JsonKey(name: "end") required String? end,
    @JsonKey(name: "program_id") required int? programId,
    @JsonKey(name: "image_url") required String? imageUrl,
    @JsonKey(name: "description") required String? description,
    @JsonKey(name: "max_slots") required int? maxSlots,
    @JsonKey(name: "available_spots") required int? availableSpots,
    @JsonKey(name: "wait_list") required bool? waitList,
    @JsonKey(name: "attendances_count") required int? attendancesCount,
    @JsonKey(name: "color") required String? color,
    @JsonKey(name: "price") required String? price,
    @JsonKey(name: "trainer") required String? trainer,
    @JsonKey(name: "schedule_title") required String? scheduleTitle,
    @JsonKey(name: "slots") required String? slots,
    @JsonKey(name: "trainer_id") required int? trainerId,
    @JsonKey(name: "resourceId") required int? resourceId,
    @JsonKey(name: "already_booked") required bool? alreadyBooked,
    @JsonKey(name: "training_program_session") required bool? trainingProgramSession,
    @JsonKey(name: "mandatory_payment") required bool? mandatoryPayment,
    @JsonKey(name: "gym_id") required int? gymId,
    @JsonKey(name: "gym_name") required String? gymName,
    @JsonKey(name: "wait_list_limit", defaultValue: 0) required int? waitLimit,
    @JsonKey(name: "wait_spots", defaultValue: 0) required int? waitSpots,
  }) = _ClassModel;

  factory ClassModel.fromJson(Map<String, dynamic> json) =>
      _$ClassModelFromJson(json);
}
