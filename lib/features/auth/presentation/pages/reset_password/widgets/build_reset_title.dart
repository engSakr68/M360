part of 'reset_password_widgets_imports.dart';

class BuildResetTitle extends StatelessWidget {
  final bool isEmail;
  const BuildResetTitle({super.key, required this.isEmail});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Forgot Password",
          style: AppTextStyle.s20_w600(color: context.colors.black),
        ),
        Gaps.vGap20,
        Text(
          isEmail
              ? "Enter your email and we 'll send you a password reset code."
              : "Enter your mobile number and we 'll send you a password reset code.",
          style: AppTextStyle.s14_w600(color: context.colors.blackOpacity).copyWith(height: 1.2.h),
        ),
      ],
    );
  }
}
