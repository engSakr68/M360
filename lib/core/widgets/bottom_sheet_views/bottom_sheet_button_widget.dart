import 'package:flutter/material.dart';
import 'package:member360/core/constants/gaps.dart';
import 'package:member360/core/localization/translate.dart';
import 'package:member360/core/widgets/app_button.dart';

class BottomSheetButtonWidget extends StatelessWidget {
  final String? customSaveText;
  final VoidCallback? onSaveTextPressed;
  final EdgeInsets? padding;
  final VoidCallback? onCancelPressed;

  const BottomSheetButtonWidget({
    super.key,
    this.customSaveText,
    this.onSaveTextPressed,
    this.padding,
    this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppTextButton.minWhite(
            text: Translate.of(context).cancel,
            onPressed: () async {
              if (onCancelPressed != null) {
                onCancelPressed!();
              } else {
                Navigator.pop(context);
              }
            },
          ),
          Gaps.hGap8,
          AppTextButton.minPrimary(
            text: customSaveText ?? Translate.of(context).save,
            onPressed: onSaveTextPressed,
          ),
        ],
      ),
    );
  }
}
