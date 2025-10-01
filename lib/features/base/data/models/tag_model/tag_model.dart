import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:member360/features/base/data/models/name_model/name_model.dart';

part 'tag_model.freezed.dart';
part 'tag_model.g.dart';

@unfreezed
@immutable
class TagModel with _$TagModel {
  const TagModel._();

  @JsonSerializable(explicitToJson: true)
  factory TagModel({
    @JsonKey(name: "id") required int? id,
    @JsonKey(name: "name") required NameModel? name,
    @JsonKey(name: "slug") required NameModel? slug,
    @JsonKey(name: "type") required String? type,
    @JsonKey(name: "order_column") required int? orderColumn,
    @JsonKey(name: "created_at") required String? createdAt,
    @JsonKey(name: "updated_at") required String? updatedAt,
  }) = _TagModel;

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);
}
