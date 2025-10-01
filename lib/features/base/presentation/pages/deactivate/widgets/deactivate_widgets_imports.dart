import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_signature/signature.dart';
import 'package:member360/core/bloc/base_bloc/base_bloc.dart';
import 'package:member360/core/bloc/base_bloc/base_state.dart';
import 'package:member360/core/constants/dimens.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/widgets/GenericTextField.dart';
import 'package:member360/core/widgets/app_button.dart';
import 'package:member360/features/auth/data/models/user_info_model/user_info_model.dart';
import 'package:member360/features/base/presentation/pages/deactivate/deactivate_imports.dart';

import '../../../../../../core/constants/gaps.dart';
import '../../../../../../core/helpers/validator.dart';
import '../../../../../../core/theme/text/app_text_style.dart';

part "build_deactivate_button.dart";
part "build_deactivate_form.dart";
part "build_deactivate_signature.dart";
part "build_choose_description.dart";
part "build_choose_reason.dart";
part "build_choose_recommend.dart";
