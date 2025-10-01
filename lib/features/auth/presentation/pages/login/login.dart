part of 'login_imports.dart';

@RoutePage()
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final LoginController controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.white,
      appBar: const BuildAuthAppBar(showBack: true),
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20).r,
          children: [
            const BuildLoginTitle(),
            BuildLoginForm(controller: controller),
            BuildLoginButton(controller: controller),
            const BuildForgetPasswordView(),
          ],
        ),
      ),
    );
  }
}
