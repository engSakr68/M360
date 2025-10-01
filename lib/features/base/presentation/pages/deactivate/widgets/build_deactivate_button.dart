part of "deactivate_widgets_imports.dart";

class BuildDeactivateButton extends StatelessWidget {
  final DeactivateController controller;
  final UserInfoModel profile;
  final bool isDeactivate;
  const BuildDeactivateButton(
      {super.key,
      required this.controller,
      required this.profile,
      required this.isDeactivate});

  @override
  Widget build(BuildContext context) {
    return isDeactivate
        ? Padding(
          padding: const EdgeInsets.symmetric(vertical: 20).r,
          child: AppTextButton.maxCustom(
              text: "Deactivate Account",
              onPressed: () => controller.drawSignature(context, profile: profile),
              bgColor: context.colors.primary,
              txtColor: context.colors.white,
              textSize: 14.sp,
              maxHeight: 50.h,
            ),
        )
        : Padding(
          padding: const EdgeInsets.symmetric(vertical: 20).r,
          child: AppTextButton.maxCustom(
              text: "Deactivate Account",
              onPressed: () => controller.signatureAlert(context, profile),
              bgColor: context.colors.primary,
              txtColor: context.colors.white,
              textSize: 14.sp,
              maxHeight: 50.h,
            ),
        );
  }
}
