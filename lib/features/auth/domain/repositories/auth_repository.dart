import 'package:member360/core/http/models/result.dart';
import 'package:member360/features/auth/data/models/user_model/user_model.dart';
import 'package:member360/features/auth/domain/entity/login_params.dart';
import 'package:member360/features/auth/domain/entity/reset_password_email_params.dart';
import 'package:member360/features/auth/domain/entity/reset_password_phone_params.dart';
import 'package:member360/features/auth/domain/entity/restore_password_params.dart';

abstract class AuthRepository {
  Future<MyResult<UserModel>> login(LoginParams param);
  Future<MyResult<String>> resetPasswordByEmail(ResetPasswordEmailParams params);
  Future<MyResult<String>> resetPasswordByPhone(ResetPasswordPhoneParams params);
  Future<MyResult<String>> restorePassword(RestorePasswordParams params);
}
