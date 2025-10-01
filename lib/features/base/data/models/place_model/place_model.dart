import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:member360/features/base/data/models/geometry_model/geometry_model.dart';
import 'package:member360/features/base/data/models/photo_model/photo_model.dart';

part 'place_model.freezed.dart';
part 'place_model.g.dart';

@unfreezed
@immutable
class PlaceModel with _$PlaceModel {
  const PlaceModel._();

  @JsonSerializable(explicitToJson: true)
  factory PlaceModel({
    @JsonKey(name: "geometry") required GeometryModel geometry,
    @JsonKey(name: "icon") required String icon,
    @JsonKey(name: "icon_background_color") required String iconBackgroundColor,
    @JsonKey(name: "icon_mask_base_uri") required String iconMaskBaseUri,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "photos") required List<PhotoModel>? photos,
    @JsonKey(name: "place_id") required String placeId,
    @JsonKey(name: "reference") required String reference,
    @JsonKey(name: "scope") required String? scope,
    @JsonKey(name: "types") required List<String> types,
    @JsonKey(name: "vicinity") required String vicinity,
  }) = _PlaceModel;

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);
}
