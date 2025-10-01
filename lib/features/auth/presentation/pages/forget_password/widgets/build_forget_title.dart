part of "forget_password_widgets_imports.dart";

class BuildForgetTitle extends StatelessWidget {
  const BuildForgetTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Forget Password",
          style: AppTextStyle.s20_w600(color: context.colors.black),
        ),
        Gaps.vGap20,
        Text(
          "What method do you want to use to recover your password?",
          softWrap: true,
          textAlign: TextAlign.start,
          style: AppTextStyle.s14_w600(color: context.colors.blackOpacity)
              .copyWith(height: 1.2.h),
        ),
      ],
    );
  }
}
