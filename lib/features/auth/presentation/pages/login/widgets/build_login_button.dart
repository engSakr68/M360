part of 'login_widgets_imports.dart';

class BuildLoginButton extends StatelessWidget {
  final LoginController controller;
  const BuildLoginButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20).r,
      child: AppTextButton.maxCustom(
        onPressed: () => controller.onSubmitLoginBtn(context),
        txtColor: context.colors.white,
        textSize: 14.sp,
        maxHeight: 50.h,
        text: "Login",
        bgColor: context.colors.secondary,
      ),
    );
  }
}
