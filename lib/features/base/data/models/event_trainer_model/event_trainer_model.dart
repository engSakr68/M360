import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_trainer_model.freezed.dart';
part 'event_trainer_model.g.dart';

@unfreezed
@immutable
class EventTrainerModel with _$EventTrainerModel {
  const EventTrainerModel._();

  @JsonSerializable(explicitToJson: true)
  factory EventTrainerModel({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "memberid") required String memberId,
    @JsonKey(name: "fname") required String fname,
    @JsonKey(name: "sname") required String sname,
    @JsonKey(name: "email", nullable: true, defaultValue: "") required String email,
    @JsonKey(name: "mobilephone", nullable: true, defaultValue: "") required String? phone,
    @JsonKey(name: "dob", nullable: true, defaultValue: "") required String? dob,
    @JsonKey(name: "gender", nullable: true, defaultValue: "") required String? gender,
    @JsonKey(name: "full_name", nullable: true, defaultValue: "") required String? fullName,
    @JsonKey(name: "photo_url", nullable: true, defaultValue: "") required String? photoUrl,
  }) = _EventTrainerModel;

  factory EventTrainerModel.fromJson(Map<String, dynamic> json) =>
      _$EventTrainerModelFromJson(json);
}
