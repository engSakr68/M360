import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:member360/features/base/data/models/location_model/location_model.dart';
import 'package:member360/features/base/data/models/view_port_model/view_port_model.dart';

part 'geometry_model.freezed.dart';
part 'geometry_model.g.dart';

@unfreezed
@immutable
class GeometryModel with _$GeometryModel {
  const GeometryModel._();

  @JsonSerializable(explicitToJson: true)
  factory GeometryModel({
    @JsonKey(name: "location") required LocationModel location,
    @JsonKey(name: "viewport") required ViewPortModel viewport,
  }) = _GeometryModel;

  factory GeometryModel.fromJson(Map<String, dynamic> json) =>
      _$GeometryModelFromJson(json);
}
