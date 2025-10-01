import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:member360/core/bloc/base_bloc/base_bloc.dart';
import 'package:member360/core/bloc/base_bloc/base_state.dart';
import 'package:member360/core/helpers/app_snack_bar_service.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/features/base/data/models/book_session_model/book_session_model.dart';
import 'package:member360/features/base/data/models/date_model/date_model.dart';
import 'package:member360/features/base/data/models/event_model/event_model.dart';
import 'package:member360/features/base/data/models/trainer_model/trainer_model.dart';
import 'package:member360/features/base/domain/entities/session_params.dart';
import 'package:member360/features/base/domain/repositories/base_repository.dart';

import '../../../../../core/bloc/device_cubit/device_cubit.dart';
import '../../../../../core/helpers/adaptive_picker.dart';
import '../../../../../core/helpers/di.dart';
import '../../../../../core/helpers/global_context.dart';
import '../../../../../core/routes/router_imports.gr.dart';
import '../../../../../core/widgets/default_app_bar.dart';

import 'widgets/session_widgets_imports.dart';

part "session.dart";
part "session_controller.dart";