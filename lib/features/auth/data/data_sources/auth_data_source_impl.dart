// ignore_for_file: avoid_dynamic_calls

import 'package:member360/core/http/generic_http/api_names.dart';
import 'package:member360/core/http/generic_http/generic_http.dart';
import 'package:member360/core/http/models/http_request_model.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:member360/features/auth/data/data_sources/auth_data_source.dart';
import 'package:member360/features/auth/data/models/user_model/user_model.dart';
import 'package:member360/features/auth/domain/entity/login_params.dart';
import 'package:injectable/injectable.dart';
import 'package:member360/features/auth/domain/entity/reset_password_email_params.dart';
import 'package:member360/features/auth/domain/entity/reset_password_phone_params.dart';
import 'package:member360/features/auth/domain/entity/restore_password_params.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl extends AuthDataSource {
  @override
  Future<MyResult<UserModel>> login(LoginParams params) async {
    HttpRequestModel model = HttpRequestModel(
      url: ApiNames.login,
      requestMethod: RequestMethod.post,
      responseType: ResType.model,
      requestBody: params.toJson(),
      responseKey: (data) => data,
      errorFunc: (data) => data["message"],
      showLoader: true,
      toJsonFunc: (json) => UserModel.fromJson(json),
    );
    return await GenericHttpImpl<UserModel>()(model);
  }

  @override
  Future<MyResult<String>> resetPasswordByEmail(
      ResetPasswordEmailParams params) async {
    HttpRequestModel model = HttpRequestModel(
      url: ApiNames.resetPassword,
      requestMethod: RequestMethod.post,
      responseType: ResType.type,
      requestBody: params.toJson(),
      responseKey: (data) => data["message"],
      errorFunc: (data) => data["message"],
      showLoader: true,
    );
    return await GenericHttpImpl<String>()(model);
  }

  @override
  Future<MyResult<String>> resetPasswordByPhone(
      ResetPasswordPhoneParams params) async {
    HttpRequestModel model = HttpRequestModel(
      url: ApiNames.resetPassword,
      requestMethod: RequestMethod.post,
      responseType: ResType.type,
      requestBody: params.toJson(),
      responseKey: (data) => data["message"],
      errorFunc: (data) => data["message"],
      showLoader: true,
    );
    return await GenericHttpImpl<String>()(model);
  }

  @override
  Future<MyResult<String>> restorePassword(RestorePasswordParams params) async {
    HttpRequestModel model = HttpRequestModel(
      url: ApiNames.restorePassword,
      requestMethod: RequestMethod.post,
      responseType: ResType.type,
      requestBody: params.toJson(),
      responseKey: (data) => data["message"],
      errorFunc: (data) => data["error"],
      showLoader: true,
    );
    return await GenericHttpImpl<String>()(model);
  }
}
