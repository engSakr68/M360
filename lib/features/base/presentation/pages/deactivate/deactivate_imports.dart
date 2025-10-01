import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_signature/signature.dart';
import 'package:member360/core/bloc/base_bloc/base_bloc.dart';
import 'package:member360/core/helpers/app_snack_bar_service.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/features/auth/data/models/user_info_model/user_info_model.dart';
import 'package:member360/features/base/domain/entities/deactivate_params.dart';
import 'package:member360/features/base/domain/repositories/base_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/bloc/device_cubit/device_cubit.dart';
import '../../../../../core/constants/gaps.dart';
import '../../../../../core/helpers/di.dart';
import '../../../../../core/helpers/global_context.dart';
import '../../../../../core/helpers/global_state.dart';
import '../../../../../core/routes/router_imports.gr.dart';
import '../../../../../core/theme/text/app_text_style.dart';
import '../../../../../core/widgets/default_app_bar.dart';
import 'widgets/deactivate_widgets_imports.dart';

part "deactivate.dart";
part "deactivate_controller.dart";