import 'package:flutter/material.dart';
import 'package:member360/core/helpers/di.dart';
import 'package:member360/core/routes/router_imports.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GlobalContext {
  BuildContext context() => getIt.get<AppRouter>().navigatorKey.currentContext!;
}
