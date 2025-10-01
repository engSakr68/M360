import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member360/core/bloc/value_state_manager/value_state_manager_import.dart';
import 'package:member360/core/helpers/app_snack_bar_service.dart';
import 'package:member360/core/helpers/services/file_service.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:member360/core/requester/consumer/requester_consumer.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:intl/intl.dart';
import 'package:member360/core/widgets/failure_view_widget.dart';
import 'package:member360/features/auth/data/models/user_info_model/user_info_model.dart';
import 'package:member360/features/base/domain/entities/password_params.dart';
import 'package:member360/features/base/domain/entities/profile_params.dart';
import 'package:member360/features/base/domain/repositories/base_repository.dart';
import 'package:member360/features/base/domain/requesters/profile_requester.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/bloc/device_cubit/device_cubit.dart';
import '../../../../../core/constants/CustomButtonAnimation.dart';
import '../../../../../core/constants/gaps.dart';
import '../../../../../core/helpers/adaptive_picker.dart';
import '../../../../../core/helpers/di.dart';
import '../../../../../core/helpers/global_context.dart';
import '../../../../../core/helpers/global_state.dart';
import '../../../../../core/routes/router_imports.gr.dart';
import 'widgets/profile_widgets_imports.dart';

part 'profile.dart';
part 'profile_controller.dart';