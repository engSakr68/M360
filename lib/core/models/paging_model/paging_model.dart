import 'package:freezed_annotation/freezed_annotation.dart';

part 'paging_model.freezed.dart';
part 'paging_model.g.dart';

@Freezed(genericArgumentFactories: true)
class PagingModel<T> with _$PagingModel<T>{
  const PagingModel._();
  @JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
  factory PagingModel({
    @JsonKey(name: 'total', defaultValue: 0) required int total,
    @JsonKey(name: 'last_page', defaultValue: 0) required int lastPage,
    @JsonKey(name: 'per_page', defaultValue: 0) required int perPage,
    @JsonKey(name: 'current_page', defaultValue: 0) required int currentPage,
    @JsonKey(name: 'data', defaultValue: [] ) required List<T> data,
  }) = _PagingModel;
  factory PagingModel.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) =>
      _$PagingModelFromJson(json, fromJsonT);
}
