import 'package:flutter/material.dart';
import 'package:member360/core/constants/gaps.dart';
import 'package:member360/core/localization/translate.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';

class FilterAppBarWidget extends StatelessWidget {
  const FilterAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: kToolbarHeight),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Gaps.hGap22,
          Text(
            Translate.of(context).filter,
            style: AppTextStyle.s24_w500(color: context.colors.black),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.close,
              color: context.colors.black,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
