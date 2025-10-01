part of 'forget_password_imports.dart';

@RoutePage()
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  ForgetPasswordState createState() => ForgetPasswordState();
}

class ForgetPasswordState extends State<ForgetPassword> {
  final ForgetPasswordController controller = ForgetPasswordController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAuthAppBar(
        showBack: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20).r,
        children: const [
          BuildForgetTitle(),
          BuildForgetButtons(),
        ],
      ),
    );
  }
}
