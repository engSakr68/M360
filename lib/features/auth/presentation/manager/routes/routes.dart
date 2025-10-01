import 'package:auto_route/auto_route.dart';
import 'package:member360/core/routes/router_imports.gr.dart';

var authRoute = [
  AdaptiveRoute(page: SplashRoute.page, initial: true),
  AdaptiveRoute(page: IntroRoute.page),
  AdaptiveRoute(page: Login.page),
  AdaptiveRoute(page: RestorePassword.page),
  AdaptiveRoute(page: ResetPassword.page),
  AdaptiveRoute(page: ForgetPassword.page),
];
