import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member360/core/bloc/value_state_manager/value_state_manager_import.dart';
import 'package:member360/core/routes/router_imports.gr.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/widgets/CachedImage.dart';
import 'package:member360/core/widgets/GenericTextField.dart';
import 'package:member360/core/widgets/app_button.dart';
import 'package:member360/core/widgets/shimmers/build_shimmer_view.dart';
import 'package:member360/features/auth/data/models/user_info_model/user_info_model.dart';

import '../../../../../../core/constants/dimens.dart';
import '../../../../../../core/constants/gaps.dart';
import '../../../../../../core/helpers/validator.dart';
import '../../../../../../core/theme/text/app_text_style.dart';
import '../../../../../../res.dart';
import '../profile_imports.dart';

part "profile_app_bar.dart";
part "build_profile_picture.dart";
part "build_profile_button.dart";
part "build_profile_title.dart";
part "build_profile_form.dart";
part "build_profile_loading.dart";
part "build_password_sheet.dart";