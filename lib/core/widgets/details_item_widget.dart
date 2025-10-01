import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:member360/core/constants/gaps.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';

class DetailsItemWidget extends StatelessWidget {
  final String title;
  final Color? color;
  final String value;
  final String image;
  final TextStyle? valueStyle;

  const DetailsItemWidget(
      {super.key,
      required this.title,
      this.color,
      required this.value,
      required this.image,
      this.valueStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
      color: color ?? context.colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            color: context.colors.blackOpacity,
          ),
          Gaps.hGap5,
          Text(
            title,
            style: AppTextStyle.s14_w400(color: context.colors.black),
          ),
          const Spacer(),
          Text(
            value,
            style: valueStyle ??
                AppTextStyle.s14_w400(color: context.colors.primary),
          ),
        ],
      ),
    );
  }
}
