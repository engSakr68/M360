import 'package:auto_route/auto_route.dart';
import 'package:member360/core/routes/router_imports.gr.dart';

var baseRoute = [
  AdaptiveRoute(page: DeactivateRoute.page),
  AdaptiveRoute(page: DetailsRoute.page),
  AdaptiveRoute(page: SessionRoute.page),
  AdaptiveRoute(page: OpenPathRoute.page),
  AdaptiveRoute(page: OpenPathDemoRoute.page),
];
