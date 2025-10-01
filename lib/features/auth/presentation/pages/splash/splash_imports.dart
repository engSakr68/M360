import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member360/core/bloc/device_cubit/device_cubit.dart';
import 'package:member360/core/constants/app_constants.dart';
import 'package:member360/core/helpers/global_state.dart';
import 'package:member360/core/routes/router_imports.gr.dart';
import 'package:member360/features/auth/data/models/user_model/user_model.dart';
import 'package:member360/features/auth/presentation/manager/user_cubit/user_cubit.dart';
import 'package:member360/features/auth/presentation/pages/splash/widgets/splash_widgets_imports.dart';
import 'package:member360/res.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash.dart';
part 'splash_controller.dart';
