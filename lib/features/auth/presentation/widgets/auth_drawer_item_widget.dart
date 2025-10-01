import 'package:flutter/material.dart';
import 'package:member360/core/constants/gaps.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';

class AuthDrawerItemWidget extends StatelessWidget {
  final String text;
  final String? subtext;
  final Widget? widget;
  final IconData? icon;
  final double? size;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const AuthDrawerItemWidget(
      {super.key,
      required this.text,
      this.widget,
      this.subtext,
      this.padding,
      this.icon,
      this.onTap,
      this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding ?? const EdgeInsetsDirectional.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppTextStyle.s16_w400(color: context.colors.black),
            ),
            Row(
              children: [
                widget ??
                    Text(
                      subtext ?? '',
                      style:
                          AppTextStyle.s14_w400(color: context.colors.primary),
                    ),
                Gaps.hGap10,
                Icon(
                  icon ?? Icons.arrow_forward_ios_outlined,
                  color: context.colors.black,
                  size: size ?? 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
