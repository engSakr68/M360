part of 'login_widgets_imports.dart';

class BuildLoginTitle extends StatelessWidget {
  const BuildLoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Welcome Back", style: AppTextStyle.s20_w600(color: context.colors.black),),
        Gaps.vGap20,
        Text("Login to your account", style: AppTextStyle.s14_w600(color: context.colors.blackOpacity),),
      ],
    );
  }
}