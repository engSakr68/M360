import 'package:member360/core/helpers/di.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:member360/core/models/model_to_domain/model_to_domain.dart';
import 'package:member360/features/auth/data/data_sources/auth_data_source.dart';
import 'package:member360/features/auth/data/models/user_model/user_model.dart';
import 'package:member360/features/auth/domain/entity/login_params.dart';
import 'package:member360/features/auth/domain/entity/reset_password_email_params.dart';
import 'package:member360/features/auth/domain/entity/reset_password_phone_params.dart';
import 'package:member360/features/auth/domain/entity/restore_password_params.dart';
import 'package:member360/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository with ModelToDomainResult {
  @override
  Future<MyResult<UserModel>> login(LoginParams param) async {
    return await getIt.get<AuthDataSource>().login(param);
  }

  @override
  Future<MyResult<String>> resetPasswordByEmail(ResetPasswordEmailParams param) async {
    return await getIt.get<AuthDataSource>().resetPasswordByEmail(param);
  }

  @override
  Future<MyResult<String>> resetPasswordByPhone(ResetPasswordPhoneParams param) async {
    return await getIt.get<AuthDataSource>().resetPasswordByPhone(param);
  }

  @override
  Future<MyResult<String>> restorePassword(RestorePasswordParams param) async {
    return await getIt.get<AuthDataSource>().restorePassword(param);
  }
}
