import 'dart:convert';

import 'package:member360/core/http/generic_http/api_names.dart';
import 'package:member360/core/http/generic_http/generic_http.dart';
import 'package:member360/core/http/models/http_request_model.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:member360/features/auth/data/models/user_info_model/user_info_model.dart';
import 'package:injectable/injectable.dart';
import 'package:member360/features/base/data/models/active_plan_model/active_plan_model.dart';
import 'package:member360/features/base/data/models/book_model/book_model.dart';
import 'package:member360/features/base/data/models/book_session_model/book_session_model.dart';
import 'package:member360/features/base/data/models/class_model/class_model.dart';
import 'package:member360/features/base/data/models/filter_model/filter_model.dart';
import 'package:member360/features/base/data/models/gym_model/gym_model.dart';
import 'package:member360/features/base/data/models/invoice_model/invoice_model.dart';
import 'package:member360/features/base/data/models/session_model/session_model.dart';
import 'package:member360/features/base/data/models/trainer_model/trainer_model.dart';
import 'package:member360/features/base/domain/entities/class_params.dart';
import 'package:member360/features/base/domain/entities/deactivate_params.dart';
import 'package:member360/features/base/domain/entities/download_params.dart';
import 'package:member360/features/base/domain/entities/password_params.dart';
import 'package:member360/features/base/domain/entities/pay_invoice_params.dart';
import 'package:member360/features/base/domain/entities/profile_params.dart';
import 'package:member360/features/base/domain/entities/pt_session_model.dart';
import 'package:member360/features/base/domain/entities/session_params.dart';
import 'package:member360/features/base/domain/entities/switch_user_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_remote_data_source.dart';

@Injectable(as: HomeRemoteDataSource)
class ImplHomeRemoteDataSource extends HomeRemoteDataSource {
  @override
  Future<MyResult<UserInfoModel>> getProfile(bool param) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var strGym = preferences.getString("active_gym");
    GymModel? gym = strGym == null? null : GymModel.fromJson(json.decode(strGym));
    HttpRequestModel model = HttpRequestModel(
      url: strGym == null? ApiNames.profile : "${ApiNames.profile}?gym_id=${gym?.id}",
      requestMethod: RequestMethod.get,
      responseType: ResType.model,
      responseKey: (data) => data,
      toJsonFunc: (json) => UserInfoModel.fromJson(json),
    );
    return await GenericHttpImpl<UserInfoModel>()(model);
  }

  @override
  Future<MyResult<SessionModel>> getPTSessions(
      PTSessionParams param) async {
    HttpRequestModel model = HttpRequestModel(
      url: ApiNames.ptSessions(param.header()),
      requestMethod: RequestMethod.get,
      // requestBody: param.toJson(),
      responseType: ResType.model,
      responseKey: (data) => data,
      toJsonFunc: (json) => SessionModel.fromJson(json),
    );
    return await GenericHttpImpl<SessionModel>()(model);
  }

  @override
  Future<MyResult<List<TrainerModel>>> getTrainers(
      PTSessionParams param) async {
    HttpRequestModel model = HttpRequestModel(
      url: ApiNames.ptSessions(param.header()),
      requestMethod: RequestMethod.get,
      // requestBody: param.toJson(),
      responseType: ResType.list,
      responseKey: (data) => data["trainers"],
      toJsonFunc: (json) => List<TrainerModel>.from(
        json.map(
          (e) => TrainerModel.fromJson(e),
        ),
      ),
    );
    return await GenericHttpImpl<List<TrainerModel>>()(model);
  }

  @override
  Future<MyResult<List<ClassModel>>> getClassCalendar(
      ClassParams param) async {
    HttpRequestModel model = HttpRequestModel(
      url: ApiNames.classCalendar(param.header()),
      // "${ApiNames.classCalendar}?from=${param.from}&to=${param.to}&gym=${param.gymId}&booked_only=${param.bookedOnly}",
      requestMethod: RequestMethod.get,
      // requestBody: param.toJson(),
      responseType: ResType.list,
      responseKey: (data) => data,
      toJsonFunc: (json) => List<ClassModel>.from(
        json.map(
          (e) => ClassModel.fromJson(e),
        ),
      ),
    );
    return await GenericHttpImpl<List<ClassModel>>()(model);
  }

  @override
  Future<MyResult<List<ClassModel>>> getClasses(
      ClassParams param) async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
    var strGym = preferences.getString("active_gym");
    GymModel? gym = strGym == null? null : GymModel.fromJson(json.decode(strGym));
    String header = param.header();

    if (gym != null || param.gymId != null) {
      header += "&gym_id=${param.gymId??gym?.id}";
    }

    HttpRequestModel model = HttpRequestModel(
      url: ApiNames.eventsClasses(header),
      // "${ApiNames.classCalendar}?from=${param.from}&to=${param.to}&gym=${param.gymId}&booked_only=${param.bookedOnly}",
      requestMethod: RequestMethod.get,
      // requestBody: param.toJson(),
      responseType: ResType.list,
      responseKey: (data) => data,
      toJsonFunc: (json) => List<ClassModel>.from(
        json.map(
          (e) => ClassModel.fromJson(e),
        ),
      ),
    );
    return await GenericHttpImpl<List<ClassModel>>()(model);
  }

  @override
  Future<MyResult<List<GymModel>>> getGyms(bool param) async {
    HttpRequestModel model = HttpRequestModel(
      url: ApiNames.gyms,
      requestMethod: RequestMethod.get,
      responseType: ResType.list,
      responseKey: (data) => data,
      toJsonFunc: (json) => List<GymModel>.from(
        json.map(
          (e) => GymModel.fromJson(e),
        ),
      ),
    );
    return await GenericHttpImpl<List<GymModel>>()(model);
  }

  @override
  Future<MyResult<List<GymModel>>> getActiveGyms(bool param) async {
    HttpRequestModel model = HttpRequestModel(
      url: ApiNames.activeGyms,
      requestMethod: RequestMethod.get,
      responseType: ResType.list,
      responseKey: (data) => data,
      toJsonFunc: (json) => List<GymModel>.from(
        json.map(
          (e) => GymModel.fromJson(e),
        ),
      ),
    );
    return await GenericHttpImpl<List<GymModel>>()(model);
  }

  @override
  Future<MyResult<BookModel>> bookClass(int param) async {
    HttpRequestModel model = HttpRequestModel(
      url: "${ApiNames.bookClass}/$param",
      requestMethod: RequestMethod.post,
      responseType: ResType.model,
      toJsonFunc: (json) => BookModel.fromJson(json),
      showLoader: true,
      responseKey: (data) => data,
      errorFunc: (json) => json["message"],
    );
    return await GenericHttpImpl<BookModel>()(model);
  }

  @override
  Future<MyResult<BookSessionModel>> bookPTSession(
      SessionParams param) async {
    HttpRequestModel model = HttpRequestModel(
      url: ApiNames.bookSession,
      requestMethod: RequestMethod.post,
      requestBody: param.toJson(),
      responseType: ResType.model,
      showLoader: true,
      toJsonFunc: (json) => BookSessionModel.fromJson(json),
      responseKey: (data) => data,
      errorFunc: (json) => json["message"],
    );
    return await GenericHttpImpl<BookSessionModel>()(model);
  }

  @override
  Future<MyResult<String>> cancelClass(int param) async {
    HttpRequestModel model = HttpRequestModel(
      url: "${ApiNames.cancelClass}/$param",
      requestMethod: RequestMethod.post,
      responseType: ResType.type,
      showLoader: true,
      responseKey: (data) => data["message"],
      errorFunc: (json) => json["message"],
    );
    return await GenericHttpImpl<String>()(model);
  }

  @override
  Future<MyResult<FilterModel>> getFilter(bool param) async {
    HttpRequestModel model = HttpRequestModel(
      url: ApiNames.classes,
      requestMethod: RequestMethod.get,
      responseType: ResType.model,
      responseKey: (data) => data,
      toJsonFunc: (json) => FilterModel.fromJson(json),
    );
    return await GenericHttpImpl<FilterModel>()(model);
  }

  @override
  Future<MyResult<UserInfoModel>> editProfile(
      ProfileParams param) async {
    HttpRequestModel model = HttpRequestModel(
      url: ApiNames.profile,
      requestBody: param.toJson(),
      requestMethod: RequestMethod.post,
      responseType: ResType.model,
      showLoader: true,
      isFormData: true,
      responseKey: (data) => data,
      toJsonFunc: (json) => UserInfoModel.fromJson(json),
    );
    return await GenericHttpImpl<UserInfoModel>()(model);
  }

  @override
  Future<MyResult<String>> changePassword(PasswordParams param) async {
    HttpRequestModel model = HttpRequestModel(
      url: ApiNames.changePassword,
      requestMethod: RequestMethod.post,
      requestBody: param.toJson(),
      showLoader: true,
      isFormData: true,
      refresh: true,
      responseKey: (data) => data['message'],
      responseType: ResType.type,
    );
    return await GenericHttpImpl<String>()(model);
  }

  @override
  Future<MyResult<List<ActivePlanModel>>> getActivePlans(
      String param) async {
    HttpRequestModel model = HttpRequestModel(
      url: "${ApiNames.activePlans}/$param/active-member-plans",
      requestMethod: RequestMethod.get,
      responseType: ResType.list,
      responseKey: (data) => data['data'],
      toJsonFunc: (json) => List<ActivePlanModel>.from(
        json.map(
          (e) => ActivePlanModel.fromJson(e),
        ),
      ),
    );
    return await GenericHttpImpl<List<ActivePlanModel>>()(model);
  }

  @override
  Future<MyResult<List<InvoiceModel>>> getMemberInvoices(
      String param) async {
    HttpRequestModel model = HttpRequestModel(
      url: "${ApiNames.memberInvoices}/$param/invoices",
      requestMethod: RequestMethod.get,
      responseType: ResType.list,
      responseKey: (data) => data['data'],
      toJsonFunc: (json) => List<InvoiceModel>.from(
        json.map(
          (e) => InvoiceModel.fromJson(e),
        ),
      ),
    );
    return await GenericHttpImpl<List<InvoiceModel>>()(model);
  }

  @override
  Future<MyResult<String>> payInvoice(PayInvoiceParams param) async {
    HttpRequestModel model = HttpRequestModel(
      url:
          "${ApiNames.memberInvoices}/${param.memberPlanId}/invoices/pay-invoice",
      requestMethod: RequestMethod.post,
      requestBody: param.toJson(),
      responseType: ResType.type,
      showLoader: true,
      responseKey: (data) => data['status'],
      errorFunc: (json) => json["message"],
    );
    return await GenericHttpImpl<String>()(model);
  }

  @override
  Future<MyResult<String>> deactivate(DeactivateParams param) async {
    HttpRequestModel model = HttpRequestModel(
      url: ApiNames.deactivate(param.gymId, param.memberId),
      requestMethod: RequestMethod.post,
      requestBody: param.toJson(),
      showLoader: true,
      responseKey: (data) => data['data'],
      responseType: ResType.type,
    );
    return await GenericHttpImpl<String>()(model);
  }

  @override
  Future<MyResult<String>> downloadPayment(DownloadParams param) async {
    HttpRequestModel model = HttpRequestModel(
      url: ApiNames.downloadPayment(param.header()),
      requestMethod: RequestMethod.download,
      requestBody: {"path": param.path},
      showLoader: true,
      responseKey: (data) => data,
      responseType: ResType.type,
    );
    return await GenericHttpImpl<String>()(model);
  }

  @override
  Future<MyResult<String>> switchUser(SwitchUserParams params) async {
    HttpRequestModel model = HttpRequestModel(
      url: ApiNames.switchUser,
      requestMethod: RequestMethod.post,
      requestBody: params.toJson(),
      showLoader: true,
      responseKey: (data) => data["token"],
      responseType: ResType.type,
    );
    return await GenericHttpImpl<String>()(model);
  }

  @override
  Future<MyResult<String>> generateOP(bool params) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var strGym = preferences.getString("active_gym");
    GymModel? gym = strGym == null? null : GymModel.fromJson(json.decode(strGym));
    HttpRequestModel model = HttpRequestModel(
      url: ApiNames.generateOP(gym!.id!.toString()),
      requestMethod: RequestMethod.post,
      showLoader: true,
      refresh: params,
      responseKey: (data) => data["token"],
      responseType: ResType.type,
    );
    return await GenericHttpImpl<String>()(model);
  }
}
