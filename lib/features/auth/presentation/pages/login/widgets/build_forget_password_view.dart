part of 'login_widgets_imports.dart';

class BuildForgetPasswordView extends StatelessWidget {
  const BuildForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: ()=>AutoRouter.of(context).push( const ForgetPassword()),
        child: Text(
          "Forget password?",
          style: AppTextStyle.s14_w800(color: context.colors.primary),
        ),
      ),
    );
  }
}
