import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_model.freezed.dart';
part 'location_model.g.dart';

@unfreezed
@immutable
class LocationModel with _$LocationModel {
  const LocationModel._();

  @JsonSerializable(explicitToJson: true)
  factory LocationModel({
    @JsonKey(name: "lat") required double lat,
    @JsonKey(name: "lng") required double lng,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}
