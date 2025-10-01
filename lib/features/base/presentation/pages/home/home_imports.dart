import 'dart:convert';
import 'dart:io';
import 'package:member360/core/bloc/base_bloc/base_bloc_builder.dart';
import 'package:member360/core/helpers/global_state.dart';
import 'package:member360/core/routes/router_imports.gr.dart';
import 'package:member360/features/base/domain/entities/switch_user_params.dart';
import 'package:path/path.dart' as path;

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:intl/intl.dart";
import 'package:member360/core/bloc/base_bloc/base_bloc.dart';
import 'package:member360/core/bloc/device_cubit/device_cubit.dart';
import 'package:member360/core/bloc/value_state_manager/value_state_manager_import.dart';
import 'package:member360/core/constants/app_config.dart';
import 'package:member360/core/constants/dimens.dart';
import 'package:member360/core/helpers/adaptive_picker.dart';
import 'package:member360/core/helpers/app_snack_bar_service.dart';
import 'package:member360/core/helpers/di.dart';
import 'package:member360/core/helpers/global_context.dart';

import 'package:member360/core/http/models/result.dart';
import 'package:member360/core/requester/consumer/requester_consumer.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';
import 'package:member360/core/widgets/failure_view_widget.dart';
import 'package:member360/core/widgets/shimmers/build_shimmer_view.dart';
import 'package:member360/core/widgets/shimmers/text_shimmer.dart';
import 'package:member360/features/base/data/models/active_plan_model/active_plan_model.dart';
import 'package:member360/features/base/data/models/gym_model/gym_model.dart';
import 'package:member360/features/base/data/models/invoice_model/invoice_model.dart';
import 'package:member360/features/base/domain/entities/class_params.dart';
import 'package:member360/features/base/domain/entities/download_params.dart';
import 'package:member360/features/base/domain/entities/pay_invoice_params.dart';
import 'package:member360/features/base/domain/entities/pt_session_model.dart';
import 'package:member360/features/base/domain/repositories/base_repository.dart';
import 'package:member360/features/base/domain/requesters/active_gym_requester.dart';
import 'package:member360/features/base/domain/requesters/active_plans_requester.dart';
import 'package:member360/features/base/domain/requesters/calendar_classes_requester.dart';
import 'package:member360/features/base/domain/requesters/member_invoices_requester.dart';
import 'package:member360/features/base/domain/requesters/profile_requester.dart';
import 'package:member360/features/base/domain/requesters/pt_sessions_requester.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/gaps.dart';
import 'widgets/home_widgets_imports.dart';


part 'home.dart';
part 'home_controller.dart';