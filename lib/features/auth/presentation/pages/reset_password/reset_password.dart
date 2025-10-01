part of 'reset_password_imports.dart';

@RoutePage()
class ResetPassword extends StatefulWidget {
  final bool isEmail;
  const ResetPassword({super.key, required this.isEmail});

  @override
  ResetPasswordState createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  final ResetPasswordController controller = ResetPasswordController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAuthAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20).r,
        children: [
          BuildResetTitle(
            isEmail: widget.isEmail,
          ),
          BuildResetForm(isEmail: widget.isEmail, controller: controller),
          BuildResetButton(
            isEmail: widget.isEmail,
            controller: controller,
          ),
        ],
      ),
    );
  }
}
