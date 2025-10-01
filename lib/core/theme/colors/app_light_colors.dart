import 'package:flutter/material.dart';
import 'package:member360/core/helpers/color_helper.dart';
import 'package:member360/core/theme/colors/app_colors.dart';

class AppLightColors extends AppColors {
  @override
  Color get primary =>
      ColorHelper.hexToColor(const String.fromEnvironment("PRIMARY_COLOR"));

  @override
  Color get secondary =>
      ColorHelper.hexToColor(const String.fromEnvironment("SECONDARY_COLOR"));

  @override
  Color get white => Colors.white;

  @override
  Color get background => Colors.white;

  @override
  Color get appBarColor => const Color(0xFFF9656B);

  @override
  Color get black => Colors.black;

  @override
  Color get blackOpacity => Colors.black45;

  @override
  Color get greyWhite => Colors.grey.withValues(alpha: .2);

  @override
  Color get disableGray => const Color(0xFFCBCBCB);

  @override
  Color get blackDark => const Color(0xff191919);

  @override
  Color shimmerBg = const Color(0xFFF7F7F7);

  @override
  Color shimmerColor = const Color(0xFFE4E4E4);
}
