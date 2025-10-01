import 'package:flutter/material.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';

class PageHeaderTitleWidget extends StatelessWidget {
  final String title;
  const PageHeaderTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyle.s16_w400(color: context.colors.blackOpacity),
          ),
        ],
      ),
    );
  }
}
