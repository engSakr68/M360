part of "restore_password_imports.dart";

@RoutePage()
class RestorePassword extends StatefulWidget {
  final String credintial;
  final bool isEmail;
  const RestorePassword({super.key, required this.credintial, required this.isEmail});

  @override
  State<RestorePassword> createState() => RestorePasswordState();
}

class RestorePasswordState extends State<RestorePassword> {
  RestorePasswordController controller = RestorePasswordController();
  
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
            const BuildRestoreTitle(),
            BuildRestoreForm(controller: controller),
            BuildRestoreButton(controller: controller, credintial: widget.credintial, isEmail: widget.isEmail),
          ],
        ),
      ),
    );
  }
}