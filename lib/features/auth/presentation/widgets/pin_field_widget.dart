import 'package:flutter/material.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class PinFieldWidget extends StatelessWidget {
  final Function(String) onComplete;
  final EdgeInsetsGeometry? margin;

  const PinFieldWidget({
    super.key,
    required this.onComplete,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 20),
      child: PinCodeTextField(
        length: 6,
        appContext: context,
        onChanged: (String value) {},
        backgroundColor: Colors.transparent,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 60,
          fieldWidth: 55,
          inactiveColor: context.colors.greyWhite,
          activeColor: context.colors.primary,
          selectedColor: context.colors.primary,
          selectedFillColor: context.colors.white,
          inactiveFillColor: context.colors.white,
          activeFillColor: context.colors.white,
          disabledColor: context.colors.black,
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        onCompleted: onComplete,
      ),
    );
  }
}
