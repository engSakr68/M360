import 'package:member360/core/helpers/di.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:member360/core/models/model_to_domain/model_to_domain.dart';
import 'package:member360/features/auth/data/models/user_info_model/user_info_model.dart';
import 'package:member360/features/base/data/data_sources/home_remote_data_source.dart';
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
import 'package:member360/features/base/domain/entities/password_params.dart';
import 'package:member360/features/base/domain/entities/pay_invoice_params.dart';
import 'package:member360/features/base/domain/entities/profile_params.dart';
import 'package:member360/features/base/domain/entities/pt_session_model.dart';
import 'package:member360/features/base/domain/entities/session_params.dart';
import 'package:member360/features/base/domain/entities/switch_user_params.dart';
import 'package:member360/features/base/domain/repositories/base_repository.dart';

@Injectable(as: BaseRepository)
class ImplBaseRepository extends BaseRepository with ModelToDomainResult {
  @override
  Future<MyResult<UserInfoModel>> getProfile(bool param) async {
    return await getIt.get<HomeRemoteDataSource>().getProfile(param);
  }

  @override
  Future<MyResult<SessionModel>> getPTSessions(PTSessionParams param) async {
    return await getIt.get<HomeRemoteDataSource>().getPTSessions(param);
  }

  @override
  Future<MyResult<List<TrainerModel>>> getTrainers(PTSessionParams param) async {
    return await getIt.get<HomeRemoteDataSource>().getTrainers(param);
  }

  @override
  Future<MyResult<List<ClassModel>>> getClassCalendar(ClassParams param) async {
    return await getIt.get<HomeRemoteDataSource>().getClassCalendar(param);
  }

  @override
  Future<MyResult<List<ClassModel>>> getClasses(ClassParams param) async {
    return await getIt.get<HomeRemoteDataSource>().getClasses(param);
  }

  @override
  Future<MyResult<List<GymModel>>> getGyms(bool param) async {
    return await getIt.get<HomeRemoteDataSource>().getGyms(param);
  }

  @override
  Future<MyResult<List<GymModel>>> getActiveGyms(bool param) async {
    return await getIt.get<HomeRemoteDataSource>().getActiveGyms(param);
  }

  @override
  Future<MyResult<FilterModel>> getFilter(bool param) async {
    return await getIt.get<HomeRemoteDataSource>().getFilter(param);
  }

  @override
  Future<MyResult<BookModel>> bookClass(int param) async {
    return await getIt.get<HomeRemoteDataSource>().bookClass(param);
  }

  @override
  Future<MyResult<BookSessionModel>> bookPTSession(SessionParams param) async {
    return await getIt.get<HomeRemoteDataSource>().bookPTSession(param);
  }

  @override
  Future<MyResult<String>> cancelClass(int param) async {
    return await getIt.get<HomeRemoteDataSource>().cancelClass(param);
  }

  @override
  Future<MyResult<UserInfoModel>> editProfile(ProfileParams param) async {
    return await getIt.get<HomeRemoteDataSource>().editProfile(param);
  }

  @override
  Future<MyResult<List<ActivePlanModel>>> getActivePlans(String param) async {
    return await getIt.get<HomeRemoteDataSource>().getActivePlans(param);
  }

  @override
  Future<MyResult<List<InvoiceModel>>> getMemberInvoices(String param) async {
    return await getIt.get<HomeRemoteDataSource>().getMemberInvoices(param);
  }

  @override
  Future<MyResult<String>> payInvoice(PayInvoiceParams param) async {
    return await getIt.get<HomeRemoteDataSource>().payInvoice(param);
  }

  @override
  Future<MyResult<String>> deactivate(DeactivateParams param) async {
    return await getIt.get<HomeRemoteDataSource>().deactivate(param);
  }

  @override
  Future<MyResult<String>> switchUser(SwitchUserParams params) async {
    return await getIt.get<HomeRemoteDataSource>().switchUser(params);
  }

  @override
  Future<MyResult<String>> changePassword(PasswordParams params) async {
    return await getIt.get<HomeRemoteDataSource>().changePassword(params);
  }

  @override
  Future<MyResult<String>> generateOP(bool params) async {
    return await getIt.get<HomeRemoteDataSource>().generateOP(params);
  }
}
