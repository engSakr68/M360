import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_model.freezed.dart';
part 'photo_model.g.dart';

@unfreezed
@immutable
class PhotoModel with _$PhotoModel {
  const PhotoModel._();

  @JsonSerializable(explicitToJson: true)
  factory PhotoModel({
    @JsonKey(name: "height") required int height,
    @JsonKey(name: "html_attributions") required List<String> htmlAttributions,
    @JsonKey(name: "photo_reference") required String photoReference,
    @JsonKey(name: "width") required int width,
  }) = _PhotoModel;

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);
}
