part of 'reset_password_widgets_imports.dart';

class BuildResetButton extends StatelessWidget {
  final ResetPasswordController controller;
  final bool isEmail;
  const BuildResetButton(
      {super.key, required this.controller, required this.isEmail});

  @override
  Widget build(BuildContext context) {
    return AppTextButton.maxCustom(
      text: "Send Code",
      onPressed: () =>
          isEmail ? controller.resetByEmail(context) : controller.resetByPhone(context),
      bgColor: context.colors.secondary,
      txtColor: context.colors.white,
      textSize: 14.sp,
      maxHeight: 50.h,
    );
  }
}
