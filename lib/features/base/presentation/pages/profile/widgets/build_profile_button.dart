part of "profile_widgets_imports.dart";

class BuildProfileButton extends StatelessWidget {
  final ProfileController controller;
  final UserInfoModel profile;
  const BuildProfileButton({super.key, required this.controller, required this.profile});

  @override
  Widget build(BuildContext context) {
    return ObsValueConsumer(
        observable: controller.editCubit,
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20).r,
                child: AppTextButton.maxCustom(
                  text: state ? "Save Changes" : "Logout",
                  onPressed: state
                      ? () => controller.editProfile(context)
                      : () => controller.logout(),
                  bgColor: context.colors.secondary,
                  txtColor: context.colors.white,
                  textSize: 14.sp,
                  maxHeight: 50.h,
                ),
              ),
              state
                  ? Gaps.empty
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 20).r,
                      child: AppTextButton.maxCustom(
                        text: "Change Password",
                        onPressed: () => controller.passwordSheet(context),
                        // AutoRouter.of(context)
                            // .push(DeactivateRoute(profile: profile)),
                        bgColor: context.colors.primary,
                        txtColor: context.colors.white,
                        textSize: 14.sp,
                        maxHeight: 50.h,
                      ),
                    ),
            ],
          );
        });
  }
}
