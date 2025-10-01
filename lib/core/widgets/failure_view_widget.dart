import 'package:flutter/material.dart';
import 'package:member360/core/constants/gaps.dart';
import 'package:member360/core/localization/translate.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';

class FailureViewWidget extends StatelessWidget {
  final void Function() onTap;
  const FailureViewWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 150, start: 70, end: 70),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Translate.s.retry,
              style: AppTextStyle.s16_w400(color: context.colors.blackOpacity),
            ),
            Gaps.hGap5,
            Icon(Icons.refresh, color: context.colors.blackOpacity),
          ],
        ),
      ),
    );
  }
}
