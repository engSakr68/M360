part of 'router_imports.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  final List<AutoRoute> routes = [
    // AdaptiveRoute(page: TermsRoute.page),
    AutoRoute(page: Dashboard.page),
    ...baseRoute,
    ...authRoute,
  ];
}
