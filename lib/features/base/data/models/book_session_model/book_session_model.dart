import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_session_model.freezed.dart';
part 'book_session_model.g.dart';

@unfreezed
@immutable
class BookSessionModel with _$BookSessionModel {
  const BookSessionModel._();

  @JsonSerializable(explicitToJson: true)
  factory BookSessionModel({
    @JsonKey(name: "id") required int? id,
    @JsonKey(name: "trainer_id") required int? trainerId,
    @JsonKey(name: "member_id") required int? memberId,
    @JsonKey(name: "gym_id") required int? gymId,
    @JsonKey(name: "oinvoice_id") required int? invoiceId,
    @JsonKey(name: "title") required String? title,
    @JsonKey(name: "starttime") required String? startTime,
    @JsonKey(name: "endtime") required String? endTime,
  }) = _BookSessionModel;

  factory BookSessionModel.fromJson(Map<String, dynamic> json) =>
      _$BookSessionModelFromJson(json);
}
