import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member360/core/bloc/base_bloc/base_bloc.dart';
import 'package:member360/core/bloc/base_bloc/base_state.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/widgets/GenericTextField.dart';
import 'package:member360/core/widgets/app_button.dart';
import 'package:member360/features/base/data/models/date_model/date_model.dart';
import 'package:member360/features/base/data/models/event_model/event_model.dart';
import 'package:member360/features/base/data/models/trainer_model/trainer_model.dart';

import '../../../../../../core/constants/gaps.dart';
import '../../../../../../core/helpers/validator.dart';
import '../../../../../../core/theme/text/app_text_style.dart';
import '../../../../../../core/widgets/CachedImage.dart';
import '../session_imports.dart';

part "build_book_session.dart";
part "build_session_button.dart";
part "build_session_price.dart";
part "build_trainer_info.dart";