import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:member360/features/base/data/models/location_model/location_model.dart';

part 'view_port_model.freezed.dart';
part 'view_port_model.g.dart';

@unfreezed
@immutable
class ViewPortModel with _$ViewPortModel {
  const ViewPortModel._();

  @JsonSerializable(explicitToJson: true)
  factory ViewPortModel({
    @JsonKey(name: "northeast") required LocationModel northeast,
    @JsonKey(name: "southwest") required LocationModel southwest,
  }) = _ViewPortModel;

  factory ViewPortModel.fromJson(Map<String, dynamic> json) =>
      _$ViewPortModelFromJson(json);
}
