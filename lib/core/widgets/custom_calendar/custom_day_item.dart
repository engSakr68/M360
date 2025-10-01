import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';

import '../../constants/gaps.dart';

/// Creates a Widget representing the day.
class CustomDayItem extends StatelessWidget {
  const CustomDayItem({
    super.key,
    required this.dayNumber,
    required this.shortName,
    required this.onTap,
    this.isSelected = false,
    this.dayColor,
    this.activeDayColor,
    this.inactiveDayNameColor,
    this.activeDayBackgroundColor,
    this.available = true,
    this.dotsColor,
    this.dayNameColor,
    this.shrink = false,
  });
  final int dayNumber;
  final String shortName;
  final bool isSelected;
  final Function onTap;
  final Color? dayColor;
  final Color? activeDayColor;
  final Color? inactiveDayNameColor;
  final Color? activeDayBackgroundColor;
  final bool available;
  final Color? dotsColor;
  final Color? dayNameColor;
  final bool shrink;

  GestureDetector _buildDay(BuildContext context) {
    return GestureDetector(
      onTap: available ? onTap as void Function()? : null,
      child: Container(
        margin: const EdgeInsets.only(left: 16).r,
        decoration: BoxDecoration(
            color: isSelected
                ? activeDayBackgroundColor ??
                    Theme.of(context).colorScheme.secondary
                : context.colors.white,
            borderRadius: BorderRadius.circular(12).r,
            border: Border.all(
                color: isSelected ? activeDayColor! : inactiveDayNameColor!)),
        height: 50.h,
        width: 50.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              dayNumber.toString(),
              style: AppTextStyle.s12_w700(
                  color: isSelected ? activeDayColor! : inactiveDayNameColor!),
            ),
            Gaps.vGap8,
            if (isSelected)
              Text(
                shortName,
                style: AppTextStyle.s12_w700(
                    color: available
                        ? activeDayColor!
                        : activeDayColor!.withValues(alpha: 0.5)),
              )
            else
              Text(
                shortName,
                style: AppTextStyle.s12_w700(
                    color: available
                        ? inactiveDayNameColor!
                        : inactiveDayNameColor!.withValues(alpha: 0.5)),
              )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDay(context);
  }
}
