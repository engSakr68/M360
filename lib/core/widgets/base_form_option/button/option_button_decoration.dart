import 'package:flutter/material.dart';
import 'package:member360/core/constants/app_config.dart';
import 'package:member360/core/constants/dimens.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';

class OptionButtonDecoration extends StatelessWidget {
  final Widget child;
  final double? startPadding;
  final BoxConstraints? constraints;
  final Border? border;

  const OptionButtonDecoration(
      {super.key,
      required this.child,
      this.startPadding,
      this.constraints,
      this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints ?? AppConfig.textFieldConstrains,
      padding: EdgeInsetsDirectional.only(
          top: 10, bottom: 10, start: startPadding ?? 12, end: 12),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: context.colors.white,
        borderRadius: Dimens.borderRadius5PX,
        border: border ?? Border.all(color: context.colors.greyWhite),
      ),
      child: child,
    );
  }
}
