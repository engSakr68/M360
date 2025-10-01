import 'package:flutter/material.dart';
import 'package:member360/core/constants/gaps.dart';
import 'package:member360/core/localization/translate.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';

class EmptyListItemWidget extends StatelessWidget {
  const EmptyListItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Gaps.vGap128,
        Center(
            child: Text(
          Translate.of(context).no_items_found,
          style: AppTextStyle.s16_w400(color: context.colors.black),
        )),
      ],
    );
  }
}
