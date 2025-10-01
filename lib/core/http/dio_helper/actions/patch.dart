import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:member360/core/errors/custom_error.dart';
import 'package:member360/core/http/dio_helper/utils/dio_header.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:injectable/injectable.dart';

import '../../../helpers/di.dart';
import '../../../helpers/loading_helper.dart';
import '../../models/request_body_model.dart';
import '../source/dio_helper.dart';
import '../utils/handle_errors.dart';

@lazySingleton
class Patch extends DioHelper {
  @override
  Future<MyResult<Response>> call(RequestBodyModel params) async {
    if (params.showLoader) getIt<LoadingHelper>().showLoadingDialog();
    try {
      final bodyString = params.body.entries
          .map((e) =>
              '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}')
          .join('&');
      var response = await dio.patch(
        params.url,
        data: bodyString,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: DioHeader()(),
        ),
      );
      debugPrint("PATCH");
      debugPrint(params.url);
      debugPrint(response.statusCode.toString());
      debugPrint(params.body.toString());
      debugPrint(response.data.toString());
      if (params.showLoader) getIt<LoadingHelper>().dismissDialog();
      return getIt<HandleErrors>().statusError(response, params.errorFunc);
    } on DioException catch (e) {
      debugPrint("PATCH");
      debugPrint(params.url);
      debugPrint(params.body.toString());
      debugPrint(e.message);
      if (params.showLoader) getIt<LoadingHelper>().dismissDialog();
      getIt<HandleErrors>()
          .catchError(errorFunc: params.errorFunc, response: e.response);
      return MyResult.isError(CustomError(msg: e.message.toString()));
    }
  }
}
