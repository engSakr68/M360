import 'package:dio/dio.dart';
import 'package:member360/core/errors/base_error.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:injectable/injectable.dart';

import '../../models/http_request_model.dart';

@lazySingleton
class HandleJsonResponse<T> {
  Future<MyResult<T>> call(
    MyResult<Response> response,
    ResType responseType,
    ToJsonFunc toJsonFunc,
    ResponseKeyFunc? dataKeyFun,
    ResponseKeyFunc? errorFunc,
  ) async {
    return response.when(
      isSuccess: (successData) {
        var responseData = successData?.data;
        switch (responseType) {
          case ResType.type:
            var data = dataKeyFun == null
                ? responseData
                : Function.apply(dataKeyFun, [responseData]);
            return MyResult.isSuccess(data);
          case ResType.model:
            var data = Function.apply(toJsonFunc, [
              dataKeyFun == null
                  ? responseData
                  : Function.apply(dataKeyFun, [responseData])
            ]);
            return MyResult.isSuccess(data);
          case ResType.list:
            var data = Function.apply(toJsonFunc, [
              dataKeyFun == null
                  ? responseData
                  : Function.apply(dataKeyFun, [responseData])
            ]);
            return MyResult.isSuccess(data);
        }
      },
      isError: (error) {
        return MyResult.isError(error);
      },
    );

    try {
      return response.when(
        isSuccess: (successData) {
          var responseData = successData?.data;
          switch (responseType) {
            case ResType.type:
              var data = dataKeyFun == null
                  ? responseData
                  : Function.apply(dataKeyFun, [responseData]);
              return MyResult.isSuccess(data);
            case ResType.model:
              var data = Function.apply(toJsonFunc, [
                dataKeyFun == null
                    ? responseData
                    : Function.apply(dataKeyFun, [responseData])
              ]);
              return MyResult.isSuccess(data);
            case ResType.list:
              var data = Function.apply(toJsonFunc, [
                dataKeyFun == null
                    ? responseData
                    : Function.apply(dataKeyFun, [responseData])
              ]);
              return MyResult.isSuccess(data);
          }
        },
        isError: (error) {
          return MyResult.isError(error);
        },
      );
    } catch (e) {
      var message = errorFunc == null
          ? e.toString()
          : Function.apply(errorFunc, [response.data]);
      return MyResult.isError(BaseError.unknown(msg: message.toString()));
    }
  }
}

typedef ToJsonFunc = Function(dynamic data);
typedef ResponseKeyFunc = Function(Response data);
