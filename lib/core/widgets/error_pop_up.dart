import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/widgets/app_button.dart';

import '../theme/text/app_text_style.dart';

class ErrorPopUp extends StatelessWidget {
  final String? message;
  const ErrorPopUp({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colors.white,
      shadowColor: context.colors.white,
      surfaceTintColor: context.colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20).r,
      ),
      alignment: Alignment.center,
      title: const Text(
        "Alert!",
        textAlign: TextAlign.center,
        style: AppTextStyle.s16_w800(color: Colors.red),
      ),
      content: Text(
        message ?? "",
        softWrap: true,
        textAlign: TextAlign.center,
        style: AppTextStyle.s14_w600(color: context.colors.black),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).r,
          child: AppTextButton.maxCustom(
            onPressed: () => AutoRouter.of(context).popForced(),
            txtColor: context.colors.white,
            textSize: 14.sp,
            maxHeight: 40.h,
            text: "Dismiss",
            bgColor: context.colors.secondary,
          ),
        )
      ],
    );
  }
}
