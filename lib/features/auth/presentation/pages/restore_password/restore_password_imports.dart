import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member360/core/bloc/value_state_manager/value_state_manager_import.dart';
import 'package:member360/core/helpers/app_snack_bar_service.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/features/auth/domain/entity/restore_password_params.dart';
import 'package:member360/features/auth/domain/repositories/auth_repository.dart';
import 'package:member360/features/auth/presentation/widgets/auth_app_bar_widget.dart';

import '../../../../../core/constants/CustomButtonAnimation.dart';
import '../../../../../core/helpers/di.dart';
import '../../../../../core/helpers/global_context.dart';
import '../../../../../core/routes/router_imports.gr.dart';
import 'widgets/restore_password_widgets_imports.dart';

part "restore_password.dart";
part "restore_password_controller.dart";