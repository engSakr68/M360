import 'package:flutter/material.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';

class HintText extends StatelessWidget {
  final String hintText;
  const HintText({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Text(hintText,
        style: AppTextStyle.s16_w400(color: context.colors.blackOpacity));
  }
}
