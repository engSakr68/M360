part of "profile_widgets_imports.dart";

class BuildProfileLoading extends StatelessWidget {
  final ProfileController controller;
  const BuildProfileLoading({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildProfileTitle(controller: controller, title: "First Name"),
        BuildShimmerView(
          height: 35.h,
          width: Dimens.screenWidth,
        ),
        BuildProfileTitle(controller: controller, title: "Last Name"),
        BuildShimmerView(
          height: 35.h,
          width: Dimens.screenWidth,
        ),
        BuildProfileTitle(controller: controller, title: "Email"),
        BuildShimmerView(
          height: 35.h,
          width: Dimens.screenWidth,
        ),
        BuildProfileTitle(controller: controller, title: "Phone"),
        BuildShimmerView(
          height: 35.h,
          width: Dimens.screenWidth,
        ),
        BuildProfileTitle(controller: controller, title: "Date of Birth"),
        BuildShimmerView(
          height: 35.h,
          width: Dimens.screenWidth,
        ),
      ],
    );
  }
}
