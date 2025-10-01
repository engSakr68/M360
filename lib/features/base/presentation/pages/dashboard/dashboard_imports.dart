import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:member360/core/bloc/value_state_manager/value_state_manager_import.dart';
import 'package:member360/core/helpers/app_snack_bar_service.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/widgets/app_button.dart';
import 'package:member360/features/base/presentation/pages/calendar/calendar_imports.dart';
import 'package:member360/features/base/presentation/pages/dashboard/widgets/dashboard_widgets_imports.dart';
import 'package:member360/features/base/presentation/pages/profile/profile_imports.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/helpers/di.dart';
import '../../../../../core/helpers/global_context.dart';
import '../../../../../core/helpers/global_notification.dart';
import '../../../../../core/helpers/global_state.dart';
import '../../../../../core/theme/text/app_text_style.dart';
import '../../../../../res.dart';
import '../home/home_imports.dart';

part "dashboard.dart";
part "dashboard_controller.dart";