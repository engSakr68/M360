import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member360/core/bloc/value_state_manager/value_state_manager_import.dart';
import 'package:member360/core/helpers/app_snack_bar_service.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/widgets/app_button.dart';
import 'package:member360/core/widgets/default_app_bar.dart';
import 'package:member360/features/base/data/models/active_plan_model/active_plan_model.dart';
import 'package:member360/features/base/data/models/book_model/book_model.dart';
import 'package:member360/features/base/data/models/class_model/class_model.dart';
import 'package:member360/features/base/domain/repositories/base_repository.dart';


import '../../../../../core/helpers/di.dart';
import '../../../../../core/helpers/global_context.dart';
import '../../../../../core/routes/router_imports.gr.dart';
import '../../../../../core/theme/text/app_text_style.dart';

import 'widgets/details_widgets_imports.dart';

part "details.dart";
part "details_controller.dart";