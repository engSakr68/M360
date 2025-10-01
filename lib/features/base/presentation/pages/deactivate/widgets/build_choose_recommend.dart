part of "deactivate_widgets_imports.dart";

class BuildChooseRecommend extends StatelessWidget {
  final DeactivateController controller;
  const BuildChooseRecommend({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseBloc<String>, BaseState<String>>(
        bloc: controller.recommendCubit,
        builder: (context, state) {
          return Container(
              // height: MediaQuery.of(context).size.height * .6,
              decoration: BoxDecoration(
                color: context.colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () => controller.setRecommend(
                          context,
                          controller.recommendations[index],
                        ),
                        child: Container(
                          width: Dimens.screenWidth,
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 16).r,
                          child: Row(
                            children: [
                              Visibility(
                                visible: state.data ==
                                    controller.recommendations[index],
                                replacement: Icon(
                                  Icons.circle_outlined,
                                  color: context.colors.blackOpacity,
                                  size: 20.r,
                                ),
                                child: Icon(
                                  Icons.check_circle_outline_outlined,
                                  color: context.colors.primary,
                                  size: 20.r,
                                ),
                              ),
                              Gaps.hGap8,
                              Text(controller.recommendations[index],
                                  style: AppTextStyle.s14_w600(
                                      color: context.colors.black)),
                            ],
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => Divider(
                        color: context.colors.blackOpacity,
                        thickness: 1.h,
                      ),
                  itemCount: controller.recommendations.length));
        });
  }
}
