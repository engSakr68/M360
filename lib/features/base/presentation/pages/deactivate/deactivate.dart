part of 'deactivate_imports.dart';

@RoutePage(name: "DeactivateRoute")
class Deactivate extends StatefulWidget {
  final UserInfoModel profile;
  const Deactivate({super.key, required this.profile});

  @override
  DeactivateState createState() => DeactivateState();
}

class DeactivateState extends State<Deactivate> {
  final DeactivateController controller = DeactivateController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: "Deactivate your account",
      ),
      backgroundColor: context.colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24).r,
        child: ListView(
          children: [
            BuildDeactivateForm(controller: controller,),
            Gaps.vGap50,
            BuildDeactivateButton(controller: controller, profile: widget.profile, isDeactivate: false,),
          ],
        ),
      ),
    );
  }
}
