import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:member360/features/base/data/models/program_model/program_model.dart';
import 'package:member360/features/base/data/models/tag_model/tag_model.dart';
import 'package:member360/features/base/data/models/trainer_model/trainer_model.dart';

part 'filter_model.freezed.dart';
part 'filter_model.g.dart';

@unfreezed
@immutable
class FilterModel with _$FilterModel {
  const FilterModel._();

  @JsonSerializable(explicitToJson: true)
  factory FilterModel({
    @JsonKey(name: "trainers") required List<TrainerModel>? trainers,
    @JsonKey(name: "trainingPrograms") required List<ProgramModel>? classes,
    @JsonKey(name: "availableTags") required List<TagModel>? tags,
  }) = _FilterModel;

  factory FilterModel.fromJson(Map<String, dynamic> json) =>
      _$FilterModelFromJson(json);
}
