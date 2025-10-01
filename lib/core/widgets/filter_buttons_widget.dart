import 'package:flutter/material.dart';
import 'package:member360/core/constants/gaps.dart';
import 'package:member360/core/localization/translate.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';

class FilterButtonsWidget extends StatelessWidget {
  final void Function() onFilterTap;
  final void Function() onResetTap;

  const FilterButtonsWidget({
    super.key,
    required this.onFilterTap,
    required this.onResetTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onFilterTap,
              child: Container(
                alignment: Alignment.center,
                height: 40,
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  Translate.s.apply,
                  style: AppTextStyle.s16_w400(color: context.colors.white),
                ),
              ),
            ),
          ),
          Gaps.hGap10,
          Expanded(
            child: InkWell(
              onTap: onResetTap,
              child: Container(
                alignment: Alignment.center,
                height: 40,
                decoration: BoxDecoration(
                  color: context.colors.white,
                  border: Border.all(color: context.colors.primary),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  Translate.of(context).reset,
                  style: AppTextStyle.s16_w400(color: context.colors.primary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
