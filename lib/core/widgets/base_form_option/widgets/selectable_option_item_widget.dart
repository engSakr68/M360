import 'package:flutter/material.dart';
import 'package:member360/core/constants/gaps.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';
import 'package:member360/core/widgets/base_form_option/widgets/option_item_widget.dart';

class SelectableOptionItemWidget extends StatelessWidget {
  final GestureTapCallback? onTap;
  final bool isSelected;
  final OptionItemWidget optionItemWidget;
  final TextStyle? selectedTextStyle;

  const SelectableOptionItemWidget({
    super.key,
    this.onTap,
    required this.isSelected,
    required this.optionItemWidget,
    this.selectedTextStyle,
  });

  TextStyle _selectedTextStyle(BuildContext context) =>
      selectedTextStyle ?? AppTextStyle.s16_w400(color: context.colors.black);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(top: 4, bottom: 14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: context.colors.greyWhite,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Gaps.hGap8,
              _getPrefix(),
              Gaps.hGap8,
              OptionItemWidget(
                constraints: const BoxConstraints(maxWidth: 290),
                title: optionItemWidget.title,
                prefix: optionItemWidget.prefix,
                titleTextStyle: isSelected ? _selectedTextStyle(context) : null,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPrefix() {
    if (isSelected) {
      return const Icon(
        Icons.check_circle_outline,
      );
    }
    return const Icon(
      Icons.circle_outlined,
    );
  }
}
