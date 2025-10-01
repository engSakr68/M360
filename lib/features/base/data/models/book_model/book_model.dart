import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_model.freezed.dart';
part 'book_model.g.dart';

@unfreezed
@immutable
class BookModel with _$BookModel {
  const BookModel._();

  @JsonSerializable(explicitToJson: true)
  factory BookModel({
    @JsonKey(name: "id") required int? id,
    @JsonKey(name: "training_program_schedule_id")
    required int? trainingProgramScheduleId,
    @JsonKey(name: "member_id") required int? memberId,
    @JsonKey(name: "fname") required String? fname,
    @JsonKey(name: "sname") required String? sname,
    @JsonKey(name: "mobilenumber") required String? mobilenumber,
    @JsonKey(name: "email") required String? email,
    @JsonKey(name: "uitem") required int? uitem,
  }) = _BookModel;

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);
}
