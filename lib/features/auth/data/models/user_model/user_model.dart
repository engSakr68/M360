import 'package:member360/features/auth/data/models/user_info_model/user_info_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@unfreezed
@immutable
class UserModel with _$UserModel {
  const UserModel._();

  @JsonSerializable(explicitToJson: true)
  factory UserModel({
    @JsonKey(name: "token") required String token,
    @JsonKey(name: "info") required UserInfoModel info,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
