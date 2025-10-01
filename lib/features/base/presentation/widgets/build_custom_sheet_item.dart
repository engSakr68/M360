import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';

import '../../../../core/constants/gaps.dart';
import '../../../../core/theme/text/app_text_style.dart';

class BuildCustomSheetItem extends StatelessWidget {
  final String title;
  final Color? color;
  final Function() onTap;
  final bool isSelected;

  const BuildCustomSheetItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: context.colors.greyWhite),
          ),
        ),
        child: Row(
          children: [
            Visibility(
              visible: isSelected,
              replacement: Icon(
                Icons.circle_outlined,
                size: 20.r,
                color: context.colors.primary,
              ),
              child: Icon(
                Icons.done_all,
                size: 20.r,
                color: context.colors.primary,
              ),
            ),
            Gaps.hGap10,
            Text(
              title,
              style: AppTextStyle.s14_w400(color:color?? context.colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
