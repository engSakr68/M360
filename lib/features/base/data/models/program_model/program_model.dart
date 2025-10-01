import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:member360/features/base/data/models/trainer_model/trainer_model.dart';

part 'program_model.freezed.dart';
part 'program_model.g.dart';

@unfreezed
@immutable
class ProgramModel with _$ProgramModel {
  const ProgramModel._();

  @JsonSerializable(explicitToJson: true)
  factory ProgramModel({
    @JsonKey(name: "id") required int? id,
    @JsonKey(name: "title") required String? title,
    @JsonKey(name: "color") required String? color,
    @JsonKey(name: "class_photo_url") required String? photo,
    @JsonKey(name: "description") required String? description,
    @JsonKey(name: "trainer") required TrainerModel? trainer,
  }) = _ProgramModel;

  factory ProgramModel.fromJson(Map<String, dynamic> json) =>
      _$ProgramModelFromJson(json);
}
