// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:member360/features/auth/data/models/user_info_model/user_info_model.dart'
    as _i17;
import 'package:member360/features/auth/presentation/pages/forget_password/forget_password_imports.dart'
    as _i4;
import 'package:member360/features/auth/presentation/pages/intro/intro_imports.dart'
    as _i6;
import 'package:member360/features/auth/presentation/pages/login/login_imports.dart'
    as _i7;
import 'package:member360/features/auth/presentation/pages/reset_password/reset_password_imports.dart'
    as _i11;
import 'package:member360/features/auth/presentation/pages/restore_password/restore_password_imports.dart'
    as _i12;
import 'package:member360/features/auth/presentation/pages/splash/splash_imports.dart'
    as _i14;
import 'package:member360/features/base/data/models/class_model/class_model.dart'
    as _i18;
import 'package:member360/features/base/data/models/date_model/date_model.dart'
    as _i20;
import 'package:member360/features/base/data/models/trainer_model/trainer_model.dart'
    as _i19;
import 'package:member360/features/base/presentation/pages/dashboard/dashboard_imports.dart'
    as _i1;
import 'package:member360/features/base/presentation/pages/deactivate/deactivate_imports.dart'
    as _i2;
import 'package:member360/features/base/presentation/pages/demo/open_path_demo.dart'
    as _i9;
import 'package:member360/features/base/presentation/pages/details/details_imports.dart'
    as _i3;
import 'package:member360/features/base/presentation/pages/home/home_imports.dart'
    as _i5;
import 'package:member360/features/base/presentation/pages/open_path/open_path_imports.dart'
    as _i8;
import 'package:member360/features/base/presentation/pages/profile/profile_imports.dart'
    as _i10;
import 'package:member360/features/base/presentation/pages/session/session_imports.dart'
    as _i13;

/// generated route for
/// [_i1.Dashboard]
class Dashboard extends _i15.PageRouteInfo<DashboardArgs> {
  Dashboard({
    _i16.Key? key,
    required int index,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         Dashboard.name,
         args: DashboardArgs(key: key, index: index),
         initialChildren: children,
       );

  static const String name = 'Dashboard';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DashboardArgs>();
      return _i1.Dashboard(key: args.key, index: args.index);
    },
  );
}

class DashboardArgs {
  const DashboardArgs({this.key, required this.index});

  final _i16.Key? key;

  final int index;

  @override
  String toString() {
    return 'DashboardArgs{key: $key, index: $index}';
  }
}

/// generated route for
/// [_i2.Deactivate]
class DeactivateRoute extends _i15.PageRouteInfo<DeactivateRouteArgs> {
  DeactivateRoute({
    _i16.Key? key,
    required _i17.UserInfoModel profile,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         DeactivateRoute.name,
         args: DeactivateRouteArgs(key: key, profile: profile),
         initialChildren: children,
       );

  static const String name = 'DeactivateRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DeactivateRouteArgs>();
      return _i2.Deactivate(key: args.key, profile: args.profile);
    },
  );
}

class DeactivateRouteArgs {
  const DeactivateRouteArgs({this.key, required this.profile});

  final _i16.Key? key;

  final _i17.UserInfoModel profile;

  @override
  String toString() {
    return 'DeactivateRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i3.Details]
class DetailsRoute extends _i15.PageRouteInfo<DetailsRouteArgs> {
  DetailsRoute({
    _i16.Key? key,
    required _i18.ClassModel details,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         DetailsRoute.name,
         args: DetailsRouteArgs(key: key, details: details),
         initialChildren: children,
       );

  static const String name = 'DetailsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DetailsRouteArgs>();
      return _i3.Details(key: args.key, details: args.details);
    },
  );
}

class DetailsRouteArgs {
  const DetailsRouteArgs({this.key, required this.details});

  final _i16.Key? key;

  final _i18.ClassModel details;

  @override
  String toString() {
    return 'DetailsRouteArgs{key: $key, details: $details}';
  }
}

/// generated route for
/// [_i4.ForgetPassword]
class ForgetPassword extends _i15.PageRouteInfo<void> {
  const ForgetPassword({List<_i15.PageRouteInfo>? children})
    : super(ForgetPassword.name, initialChildren: children);

  static const String name = 'ForgetPassword';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i4.ForgetPassword();
    },
  );
}

/// generated route for
/// [_i5.Home]
class Home extends _i15.PageRouteInfo<void> {
  const Home({List<_i15.PageRouteInfo>? children})
    : super(Home.name, initialChildren: children);

  static const String name = 'Home';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i5.Home();
    },
  );
}

/// generated route for
/// [_i6.Intro]
class IntroRoute extends _i15.PageRouteInfo<void> {
  const IntroRoute({List<_i15.PageRouteInfo>? children})
    : super(IntroRoute.name, initialChildren: children);

  static const String name = 'IntroRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i6.Intro();
    },
  );
}

/// generated route for
/// [_i7.Login]
class Login extends _i15.PageRouteInfo<void> {
  const Login({List<_i15.PageRouteInfo>? children})
    : super(Login.name, initialChildren: children);

  static const String name = 'Login';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i7.Login();
    },
  );
}

/// generated route for
/// [_i8.OpenPathPage]
class OpenPathRoute extends _i15.PageRouteInfo<void> {
  const OpenPathRoute({List<_i15.PageRouteInfo>? children})
    : super(OpenPathRoute.name, initialChildren: children);

  static const String name = 'OpenPathRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i8.OpenPathPage();
    },
  );
}

/// generated route for
/// [_i9.OpenpathDemoApp]
class OpenPathDemoRoute extends _i15.PageRouteInfo<OpenPathDemoRouteArgs> {
  OpenPathDemoRoute({
    _i16.Key? key,
    required String token,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         OpenPathDemoRoute.name,
         args: OpenPathDemoRouteArgs(key: key, token: token),
         initialChildren: children,
       );

  static const String name = 'OpenPathDemoRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OpenPathDemoRouteArgs>();
      return _i9.OpenpathDemoApp(key: args.key, token: args.token);
    },
  );
}

class OpenPathDemoRouteArgs {
  const OpenPathDemoRouteArgs({this.key, required this.token});

  final _i16.Key? key;

  final String token;

  @override
  String toString() {
    return 'OpenPathDemoRouteArgs{key: $key, token: $token}';
  }
}

/// generated route for
/// [_i10.Profile]
class Profile extends _i15.PageRouteInfo<void> {
  const Profile({List<_i15.PageRouteInfo>? children})
    : super(Profile.name, initialChildren: children);

  static const String name = 'Profile';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i10.Profile();
    },
  );
}

/// generated route for
/// [_i11.ResetPassword]
class ResetPassword extends _i15.PageRouteInfo<ResetPasswordArgs> {
  ResetPassword({
    _i16.Key? key,
    required bool isEmail,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         ResetPassword.name,
         args: ResetPasswordArgs(key: key, isEmail: isEmail),
         initialChildren: children,
       );

  static const String name = 'ResetPassword';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordArgs>();
      return _i11.ResetPassword(key: args.key, isEmail: args.isEmail);
    },
  );
}

class ResetPasswordArgs {
  const ResetPasswordArgs({this.key, required this.isEmail});

  final _i16.Key? key;

  final bool isEmail;

  @override
  String toString() {
    return 'ResetPasswordArgs{key: $key, isEmail: $isEmail}';
  }
}

/// generated route for
/// [_i12.RestorePassword]
class RestorePassword extends _i15.PageRouteInfo<RestorePasswordArgs> {
  RestorePassword({
    _i16.Key? key,
    required String credintial,
    required bool isEmail,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         RestorePassword.name,
         args: RestorePasswordArgs(
           key: key,
           credintial: credintial,
           isEmail: isEmail,
         ),
         initialChildren: children,
       );

  static const String name = 'RestorePassword';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RestorePasswordArgs>();
      return _i12.RestorePassword(
        key: args.key,
        credintial: args.credintial,
        isEmail: args.isEmail,
      );
    },
  );
}

class RestorePasswordArgs {
  const RestorePasswordArgs({
    this.key,
    required this.credintial,
    required this.isEmail,
  });

  final _i16.Key? key;

  final String credintial;

  final bool isEmail;

  @override
  String toString() {
    return 'RestorePasswordArgs{key: $key, credintial: $credintial, isEmail: $isEmail}';
  }
}

/// generated route for
/// [_i13.Session]
class SessionRoute extends _i15.PageRouteInfo<SessionRouteArgs> {
  SessionRoute({
    _i16.Key? key,
    required _i19.TrainerModel trainer,
    required _i20.DateModel openTimesPerDay,
    required String date,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         SessionRoute.name,
         args: SessionRouteArgs(
           key: key,
           trainer: trainer,
           openTimesPerDay: openTimesPerDay,
           date: date,
         ),
         initialChildren: children,
       );

  static const String name = 'SessionRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SessionRouteArgs>();
      return _i13.Session(
        key: args.key,
        trainer: args.trainer,
        openTimesPerDay: args.openTimesPerDay,
        date: args.date,
      );
    },
  );
}

class SessionRouteArgs {
  const SessionRouteArgs({
    this.key,
    required this.trainer,
    required this.openTimesPerDay,
    required this.date,
  });

  final _i16.Key? key;

  final _i19.TrainerModel trainer;

  final _i20.DateModel openTimesPerDay;

  final String date;

  @override
  String toString() {
    return 'SessionRouteArgs{key: $key, trainer: $trainer, openTimesPerDay: $openTimesPerDay, date: $date}';
  }
}

/// generated route for
/// [_i14.Splash]
class SplashRoute extends _i15.PageRouteInfo<void> {
  const SplashRoute({List<_i15.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i14.Splash();
    },
  );
}
