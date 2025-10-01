part of "home_widgets_imports.dart";

class BuildMemberInvoices extends StatelessWidget {
  final HomeController controller;
  final String gymId, memberPlanId;
  const BuildMemberInvoices(
      {super.key,
      required this.controller,
      required this.gymId,
      required this.memberPlanId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseBloc<bool>, BaseState<bool>>(
        bloc: controller.loadingCubit,
        builder: (context, loadingState) {
          return RequesterConsumer(
            requester: controller.invoicesRequester,
            successBuilder: (context, data) {
              return ObsValueConsumer<InvoiceModel?>(
                  observable: controller.invoicesCubit,
                  builder: (context, value) {
                    return Container(
                      decoration: BoxDecoration(
                        color: context.colors.white,
                        borderRadius: BorderRadius.circular(20).r,
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16).r,
                          child: Stack(
                            alignment: FractionalOffset.bottomCenter,
                            children: [
                              LimitedBox(
                                maxHeight: Dimens.screenHeight * 0.85,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      loadingState.data!
                                          ? ListView.separated(
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) =>
                                                  BuildShimmerView(
                                                    height: 200.h,
                                                    width: Dimens.screenWidth,
                                                  ),
                                              separatorBuilder:
                                                  (context, index) =>
                                                      Gaps.vGap8,
                                              itemCount: 2)
                                          : ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, index) =>
                                                  MemberInvoiceCard(
                                                      isSelected:
                                                          value == data![index],
                                                      onTap: () {
                                                        controller.invoicesCubit
                                                            .setValue(
                                                                data[index]);
                                                        controller.activeCubit
                                                            .successState(data[
                                                                            index]
                                                                        .oinvoiceState ==
                                                                    "successful"
                                                                ? false
                                                                : true);
                                                      },
                                                      invoice: data[index]),
                                              separatorBuilder:
                                                  (context, index) =>
                                                      Gaps.vGap8,
                                              itemCount: data?.length ?? 0),
                                      Gaps.vGap64,
                                    ],
                                  ),
                                ),
                              ),
                              BlocBuilder<BaseBloc<bool>, BaseState<bool>>(
                                  bloc: controller.activeCubit,
                                  builder: (context, activeState) {
                                    return AppTextButton.maxCustom(
                                      onPressed: activeState.data!
                                          ? () => controller.payInvoice(context,
                                              gymId: gymId,
                                              memberPlanId: memberPlanId)
                                          : () {},
                                      text: "Pay now",
                                      bgColor: activeState.data!
                                          ? context.colors.secondary
                                          : context.colors.disableGray,
                                      borderColor: activeState.data!
                                          ? context.colors.secondary
                                          : context.colors.disableGray,
                                      txtColor: activeState.data!
                                          ? context.colors.white
                                          : context.colors.black,
                                      textSize: 14.sp,
                                      maxHeight: 50.h,
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            loadingBuilder: (context) {
              return Container(
                decoration: BoxDecoration(
                  color: context.colors.white,
                  borderRadius: BorderRadius.circular(20).r,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16).r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => BuildShimmerView(
                                  height: 200.h,
                                  width: Dimens.screenWidth,
                                ),
                            separatorBuilder: (context, index) => Gaps.vGap8,
                            itemCount: 2),
                        Gaps.vGap20,
                        AppTextButton.maxCustom(
                          onPressed: () {},
                          text: "Pay now",
                          bgColor: context.colors.disableGray,
                          borderColor: context.colors.disableGray,
                          txtColor: context.colors.black,
                          textSize: 14.sp,
                          maxHeight: 50.h,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            failureBuilder: (context, error, callback) {
              return FailureViewWidget(onTap: callback);
            },
          );
        });
  }
}
