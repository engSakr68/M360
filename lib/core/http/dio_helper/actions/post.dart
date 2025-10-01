import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:member360/core/errors/custom_error.dart';
import 'package:member360/core/http/generic_http/api_names.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:injectable/injectable.dart';

import '../../../helpers/di.dart';
import '../../../helpers/loading_helper.dart';
import '../../models/request_body_model.dart';
import '../source/dio_helper.dart';
import '../utils/handle_errors.dart';
import '../utils/handle_request_body.dart';

@lazySingleton
class Post extends DioHelper {
  @override
  Future<MyResult<Response>> call(RequestBodyModel params) async {
    if (params.showLoader) getIt<LoadingHelper>().showLoadingDialog();
    FormData? formData = getIt<HandleRequestBody>()(params);
    try {
      var response = await dio.post(
        params.url,
        data: formData ?? json.encode(params.body),
      );
      debugPrint("POST");
      debugPrint(params.url);
      debugPrint(response.statusCode.toString());
      debugPrint(params.body.toString());
      debugPrint(response.data.toString());
      if (params.showLoader) getIt<LoadingHelper>().dismissDialog();
      return getIt<HandleErrors>().statusError(response, params.errorFunc);
    } on DioException catch (e) {
      debugPrint("POST");
      debugPrint(params.url);
      debugPrint(ApiNames.baseUrl);
      debugPrint(params.body.toString());
      debugPrint(e.message);
      if (params.showLoader) getIt<LoadingHelper>().dismissDialog();
      getIt<HandleErrors>()
          .catchError(errorFunc: params.errorFunc, response: e.response);
      return MyResult.isError(CustomError(msg: e.message.toString()));
    }
  }
}
