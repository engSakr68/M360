import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:intl/intl.dart";
import 'package:member360/core/bloc/base_bloc/base_bloc.dart';
import 'package:member360/core/bloc/value_state_manager/value_state_manager_import.dart';
import 'package:member360/features/base/data/models/gym_model/gym_model.dart';
import 'package:member360/features/base/data/models/tag_model/tag_model.dart';
import 'package:member360/features/base/data/models/trainer_model/trainer_model.dart';
import 'package:member360/features/base/domain/entities/class_params.dart';
import 'package:member360/features/base/domain/entities/pt_session_model.dart';
import 'package:member360/features/base/domain/requesters/classes_requester.dart';
import 'package:member360/features/base/domain/requesters/filter_requester.dart';
import 'package:member360/features/base/domain/requesters/gym_requester.dart';
import 'package:member360/features/base/domain/requesters/pt_sessions_requester.dart';
import 'package:member360/features/base/domain/requesters/trainers_requester.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/calendar_widgets_imports.dart';

part "calendar.dart";
part "calendar_controller.dart";