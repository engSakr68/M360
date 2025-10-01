import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member360/core/helpers/app_snack_bar_service.dart';
import 'package:member360/core/helpers/di.dart';
import 'package:member360/core/helpers/global_context.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:member360/core/routes/router_imports.gr.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/features/auth/domain/entity/reset_password_email_params.dart';
import 'package:member360/features/auth/domain/entity/reset_password_phone_params.dart';
import 'package:member360/features/auth/domain/repositories/auth_repository.dart';
import 'package:member360/features/auth/presentation/pages/reset_password/widgets/reset_password_widgets_imports.dart';
import 'package:member360/features/auth/presentation/widgets/auth_app_bar_widget.dart';

part 'reset_password.dart';
part 'reset_password_controller.dart';
