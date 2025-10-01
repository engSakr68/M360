part of "restore_password_widgets_imports.dart";

class BuildRestoreButton extends StatelessWidget {
  final RestorePasswordController controller;
  final String credintial;
  final bool isEmail;

  const BuildRestoreButton({Key? key, required this.controller, required this.credintial, required this.isEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20).r,
      child: AppTextButton.maxCustom(
          text: "Reset password",
          onPressed: () => controller.restorePassword(context, credintial: credintial, isEmail: isEmail),
          bgColor: context.colors.secondary,
          txtColor: context.colors.white,
          textSize: 14.sp,
          maxHeight: 50.h,
      ),
    );
  }
}