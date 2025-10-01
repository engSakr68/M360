import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:member360/features/base/data/models/gym_model/gym_model.dart';

part 'user_info_model.freezed.dart';
part 'user_info_model.g.dart';

@unfreezed
class UserInfoModel with _$UserInfoModel {
  const UserInfoModel._();
  @JsonSerializable(explicitToJson: true)
  factory UserInfoModel({
    @JsonKey(name: "id") required int? id,
    @JsonKey(name: "fname") required String fname,
    @JsonKey(name: "sname") required String sname,
    @JsonKey(name: "email", nullable: true, defaultValue: "") required String email,
    @JsonKey(name: "photo_url", nullable: true, defaultValue: "") required String photoUrl,
    @JsonKey(name: "mobilephone", nullable: true, defaultValue: "") required String? phone,
    @JsonKey(name: "dob", nullable: true, defaultValue: "") required String? dob,
    @JsonKey(name: "gender", nullable: true, defaultValue: "") required String? gender,
    @JsonKey(name: "plans", nullable: true, defaultValue: "") required String? plans,
    @JsonKey(name: "current_balance", nullable: true, defaultValue: 0) required double? currentBalance,
    @JsonKey(name: "gym", nullable: true) required GymModel? gym,
    @JsonKey(name: "active_gyms", nullable: true, defaultValue: []) required List<GymModel>? activeGyms,
    @JsonKey(name: "memberid") required String memberId,
  }) = _UserInfoModel;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);
}
