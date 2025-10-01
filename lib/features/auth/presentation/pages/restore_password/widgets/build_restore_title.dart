part of "restore_password_widgets_imports.dart";

class BuildRestoreTitle extends StatelessWidget {
  const BuildRestoreTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter new password",
          style: AppTextStyle.s20_w600(color: context.colors.black),
        ),
        Gaps.vGap20,
        Text(
          "Enter your reset code and a new password.",
          style: AppTextStyle.s14_w600(color: context.colors.blackOpacity),
        ),
      ],
    );
  }
}
