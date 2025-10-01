part of "intro_widgets_imports.dart";

class BuildIntroButton extends StatelessWidget {
  const BuildIntroButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24).r,
      child: AppTextButton.maxCustom(
        onPressed: ()=>AutoRouter.of(context).push(const Login()),
        text: "Login",
        bgColor: context.colors.secondary,
        txtColor: context.colors.white,
        textSize: 14.sp,
        maxHeight: 50.h,
      ),
    );
  }
}