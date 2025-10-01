part of "home_widgets_imports.dart";

class BuildGymCard extends StatelessWidget {
  final HomeController controller;
  final UserInfoModel? profile;
  const BuildGymCard(
      {super.key, required this.controller, required this.profile});

  @override
  Widget build(BuildContext context) {
    return profile!.activeGyms!.isEmpty
        ? Gaps.empty
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150.h,
                width: Dimens.screenWidth,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: context.colors.white,
                  borderRadius: BorderRadius.circular(15).r,
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.greyWhite.withValues(alpha: 0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 40.h,
                      width: Dimens.screenWidth,
                      padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14)
                          .r,
                      decoration: BoxDecoration(
                        color: context.colors.primary,
                      ),
                      child: Text(
                        profile!.activeGyms![0].name ?? "",
                        style:
                            AppTextStyle.s16_w800(color: context.colors.white),
                      ),
                    ),
                    CachedImage(
                      url: profile!.activeGyms![0].logo ?? "",
                      height: 110.h,
                      width: Dimens.screenWidth,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
              Gaps.vGap24,
              Text(
                "Active Plans:",
                style: AppTextStyle.s14_w800(color: context.colors.black),
              ),
              Gaps.vGap16,
              BuildMemberPlans(
                controller: controller,
                gymId: profile!.activeGyms![0].id.toString(),
              ),
            ],
          );
  }
}
