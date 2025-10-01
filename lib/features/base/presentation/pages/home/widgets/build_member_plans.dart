part of "home_widgets_imports.dart";

class BuildMemberPlans extends StatelessWidget {
  final HomeController controller;
  final String gymId;
  const BuildMemberPlans({
    super.key,
    required this.controller,
    required this.gymId,
  });

  @override
  Widget build(BuildContext context) {
    return RequesterConsumer(
      requester: controller.activePlanRequester,
      successBuilder: (context, data) {
        return data!.isEmpty
            ? const BuildEmptyPlans()
            : ObsValueConsumer<ActivePlanModel?>(
                observable: controller.planCubit,
                builder: (context, value) {
                  return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => MemberPlanCard(
                        downloadTap: () => controller.showDownload(context, memberPlanId:
                                      data[index].memberPlanId.toString()),
                            onTap: () {
                              controller.invoicesRequester = MemberInvoicesRequester(data[index].memberPlanId.toString());
                              controller.requestMemberInvoices(
                                  data[index].memberPlanId.toString());
                              controller.showInvoicess(context,
                                  gymId: gymId,
                                  memberPlanId:
                                      data[index].memberPlanId.toString());
                            },
                            plan: data[index],
                            isSelected: value == data[index],
                          ),
                      separatorBuilder: (context, index) => Gaps.vGap8,
                      itemCount: data.length);
                });
      },
      loadingBuilder: (context) {
        return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => Container(
                  height: 200.h,
                  width: Dimens.screenWidth,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration:
                      BoxDecoration(
                        borderRadius: BorderRadius.circular(20).r),
                  child: BuildShimmerView(
                    height: 200.h,
                    width: Dimens.screenWidth,
                  ),
                ),
            separatorBuilder: (context, index) => Gaps.vGap8,
            itemCount: 2);
      },
      failureBuilder: (context, error, callback) {
        return FailureViewWidget(onTap: callback);
      },
    );
  }
}
