// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:member360/core/helpers/firebase_analytics_helper.dart' as _i314;
import 'package:member360/core/helpers/global_context.dart' as _i1012;
import 'package:member360/core/helpers/global_notification.dart' as _i384;
import 'package:member360/core/helpers/loading_helper.dart' as _i533;
import 'package:member360/core/helpers/services/file_service.dart' as _i620;
import 'package:member360/core/helpers/services/psermission_services.dart'
    as _i537;
import 'package:member360/core/helpers/share_services.dart' as _i598;
import 'package:member360/core/helpers/shared_pref_service.dart' as _i980;
import 'package:member360/core/helpers/utilities.dart' as _i625;
import 'package:member360/core/http/dio_helper/actions/delete.dart' as _i222;
import 'package:member360/core/http/dio_helper/actions/download.dart' as _i418;
import 'package:member360/core/http/dio_helper/actions/get.dart' as _i642;
import 'package:member360/core/http/dio_helper/actions/patch.dart' as _i572;
import 'package:member360/core/http/dio_helper/actions/post.dart' as _i559;
import 'package:member360/core/http/dio_helper/actions/put.dart' as _i467;
import 'package:member360/core/http/dio_helper/utils/dio_header.dart' as _i703;
import 'package:member360/core/http/dio_helper/utils/dio_options.dart'
    as _i1024;
import 'package:member360/core/http/dio_helper/utils/handle_errors.dart'
    as _i576;
import 'package:member360/core/http/dio_helper/utils/handle_json_response.dart'
    as _i942;
import 'package:member360/core/http/dio_helper/utils/handle_request_body.dart'
    as _i87;
import 'package:member360/core/http/generic_http/generic_http.dart' as _i1072;
import 'package:member360/core/network/network_info.dart' as _i185;
import 'package:member360/features/auth/data/data_sources/auth_data_source.dart'
    as _i216;
import 'package:member360/features/auth/data/data_sources/auth_data_source_impl.dart'
    as _i905;
import 'package:member360/features/auth/data/repositories/auth_repository_impl.dart'
    as _i984;
import 'package:member360/features/auth/domain/repositories/auth_repository.dart'
    as _i509;
import 'package:member360/features/base/data/data_sources/home_remote_data_source.dart'
    as _i132;
import 'package:member360/features/base/data/data_sources/impl_home_remote_data_source.dart'
    as _i89;
import 'package:member360/features/base/data/repositories/impl_base_repository.dart'
    as _i438;
import 'package:member360/features/base/domain/repositories/base_repository.dart'
    as _i855;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i598.ShareServices>(() => _i598.ShareServices());
    gh.factory<_i620.AppFileService>(() => _i620.AppFileService());
    gh.factory<_i537.PermissionServices>(() => _i537.PermissionServices());
    gh.singleton<_i533.LoadingHelper>(() => _i533.LoadingHelper());
    gh.lazySingleton<_i185.NetworkInfoImpl>(() => _i185.NetworkInfoImpl());
    gh.lazySingleton<_i1024.DioOptions>(() => _i1024.DioOptions());
    gh.lazySingleton<_i576.HandleErrors>(() => _i576.HandleErrors());
    gh.lazySingleton<_i87.HandleRequestBody>(() => _i87.HandleRequestBody());
    gh.lazySingleton<_i942.HandleJsonResponse<dynamic>>(
        () => _i942.HandleJsonResponse<dynamic>());
    gh.lazySingleton<_i703.DioHeader>(() => _i703.DioHeader());
    gh.lazySingleton<_i572.Patch>(() => _i572.Patch());
    gh.lazySingleton<_i559.Post>(() => _i559.Post());
    gh.lazySingleton<_i418.Download>(() => _i418.Download());
    gh.lazySingleton<_i222.Delete>(() => _i222.Delete());
    gh.lazySingleton<_i642.Get>(() => _i642.Get());
    gh.lazySingleton<_i467.Put>(() => _i467.Put());
    gh.lazySingleton<_i1072.GenericHttpImpl<dynamic>>(
        () => _i1072.GenericHttpImpl<dynamic>());
    gh.lazySingleton<_i1012.GlobalContext>(() => _i1012.GlobalContext());
    gh.lazySingleton<_i384.GlobalNotification>(
        () => _i384.GlobalNotification());
    gh.lazySingleton<_i625.Utilities>(() => _i625.Utilities());
    gh.lazySingleton<_i314.FirebaseAnalyticsHelper>(
        () => _i314.FirebaseAnalyticsHelper());
    gh.lazySingleton<_i980.SharedPrefService>(() => _i980.SharedPrefService());
    gh.factory<_i216.AuthDataSource>(() => _i905.AuthDataSourceImpl());
    gh.factory<_i132.HomeRemoteDataSource>(
        () => _i89.ImplHomeRemoteDataSource());
    gh.factory<_i855.BaseRepository>(() => _i438.ImplBaseRepository());
    gh.factory<_i509.AuthRepository>(() => _i984.AuthRepositoryImpl());
    return this;
  }
}
