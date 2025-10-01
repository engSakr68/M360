part of "deactivate_widgets_imports.dart";

class BuildDeactiveSignature extends StatelessWidget {
  final DeactivateController controller;
  final UserInfoModel profile;
  const BuildDeactiveSignature({super.key, required this.controller, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: FractionalOffset.topRight,
          children: [
            Container(
              height: 200.h,
              width: Dimens.screenWidth,
              decoration: BoxDecoration(
                border: Border.all(color: context.colors.blackOpacity, width: .7),
                borderRadius: BorderRadius.circular(10),
                color: context.colors.white,
              ),
              child: HandSignature(
                  control: controller.signatureController,
                  type: SignatureDrawType.shape),
            ),
            IconButton(
                onPressed: () => controller.signatureController.clear(),
                icon: Icon(
                  Icons.cancel,
                  size: 25.r,
                  color: context.colors.blackOpacity,
                )),
          ],
        ),
        Center(child: BuildDeactivateButton(controller: controller, profile: profile, isDeactivate: true,)),
      ],
    );
  }
}
