import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:member360/core/constants/app_config.dart';
import 'package:member360/core/constants/app_constants.dart';
import 'package:member360/core/errors/custom_error.dart';
import 'package:member360/core/errors/not_found_error.dart';
import 'package:member360/core/errors/unauthorized_error.dart';
import 'package:member360/core/helpers/app_snack_bar_service.dart';
import 'package:member360/core/helpers/di.dart';
import 'package:member360/core/helpers/global_context.dart';
import 'package:member360/core/helpers/global_state.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:injectable/injectable.dart';
import 'package:member360/core/widgets/error_pop_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class HandleErrors {
  void catchError({Response? response, required Function(dynamic) errorFunc}) {
    if (response == null) {
      log("failed response Check Server");
      AppSnackBar.showErrorSnackBar(error: CustomError(msg: "Check Server"));
    } else {
      log("failed response ${response.statusCode}");
      log("failed response ${response.data}");
      var data = response.data;
      try {
        if (data is String) data = json.decode(response.data);
        String message = "";
        if (response.statusCode != 422) {
          message = errorFunc(data ?? data["error"]).toString();
        }
        switch (response.statusCode) {
          case 503:
          case 401:
          case 404:
            showError(data["message"]);
            if (data["message"] == "Unauthenticated.") {
              _tokenExpired();
            }
            break;
          case 500:
            showError(message.toString());
            break;
          case 502:
            showError("check your request");
            break;
          case 422:
          case 400:
            message = data["message"]?? data["error"];
            showError(message);
            break;
          case 403:
            message = data["message"]?? data["error"];
            showError(message);
            break;
          case 301:
          case 302:
            _tokenExpired();
            break;
        }
      } catch (e) {
        showError(e.toString());
      }
    }
  }

  MyResult<Response> statusError(
      Response response, Function(dynamic) errorFunc) {
    if (response.statusCode == 401) {
      return MyResult.isError(UnauthorizedError());
    } else if (response.statusCode == 404) {
      return MyResult.isError(NotFoundError());
    }
    return MyResult.isSuccess(response);
  }

  void showError(String message) {
    showDialog(
      context: getIt<GlobalContext>().context(),
      builder: (cxt) {
        return ErrorPopUp(message: message);
      },
    );
  }

  // void showError(String message) {
  //   AppSnackBar.showErrorSnackBar(error: CustomError(msg: message));
  // showDialog(
  //   context: getIt<GlobalContext>().context(),
  //   builder: (cxt) {
  //     return ErrorPopUp(message: message);
  //   },
  // );
  // }

  void _tokenExpired() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    if (GlobalState.instance.get(ApplicationConstants.keyToken) != null) {
      AppConfig.instance.restartApp();
    }
  }
}
