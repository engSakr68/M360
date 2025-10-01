import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_place_model.freezed.dart';
part 'search_place_model.g.dart';

@unfreezed
@immutable
class SearchPlaceModel with _$SearchPlaceModel {
  const SearchPlaceModel._();

  @JsonSerializable(explicitToJson: true)
  factory SearchPlaceModel({
    @JsonKey(name: "description") required String description,
    @JsonKey(name: "place_id") required String placeId,
  }) = _SearchPlaceModel;

  factory SearchPlaceModel.fromJson(Map<String, dynamic> json) =>
      _$SearchPlaceModelFromJson(json);
}
