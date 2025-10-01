part of "forget_password_widgets_imports.dart";

class BuildForgetButtons extends StatelessWidget {
  const BuildForgetButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10).r,
          child: AppTextButton.maxCustom(
            onPressed: () =>
                AutoRouter.of(context).push(ResetPassword(isEmail: true)),
            text: "Email",
            bgColor: context.colors.secondary,
            txtColor: context.colors.white,
            textSize: 14.sp,
            maxHeight: 50.h,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10).r,
          child: AppTextButton.maxCustom(
            onPressed: () =>
                AutoRouter.of(context).push(ResetPassword(isEmail: false)),
            text: "Mobile Number",
            bgColor: context.colors.secondary,
            txtColor: context.colors.white,
            textSize: 14.sp,
            maxHeight: 50.h,
          ),
        ),
      ],
    );
  }
}
