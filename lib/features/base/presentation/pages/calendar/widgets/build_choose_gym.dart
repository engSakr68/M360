part of "calendar_widgets_imports.dart";

class BuildChooseGym extends StatelessWidget {
  final CalendarController controller;
  const BuildChooseGym({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RequesterConsumer(
      requester: controller.gymRequester,
      successBuilder: (context, data) {
        return Container(
            decoration: BoxDecoration(
              color: context.colors.white,
              borderRadius: BorderRadius.only(
                topRight: const Radius.circular(20).r,
                topLeft: const Radius.circular(20).r,
              ),
            ),
            child: Container(
                height: MediaQuery.of(context).size.height * .9,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 15).r,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Select Gym",
                                style: AppTextStyle.s20_w500(
                                    color: context.colors.black),
                              ),
                              InkWell(
                                onTap: () => AutoRouter.of(context).popForced(),
                                child: Icon(
                                  Icons.close,
                                  color: context.colors.black,
                                ),
                              )
                            ],
                          )),
                      Column(
                        children: List.generate(
                            data?.length ?? 0,
                            (index) => BuildCustomSheetItem(
                                  onTap: () {
                                    controller.gymCubit.setValue(data[index]);
                                    controller.gymController.text =
                                        controller.gymCubit.getValue()?.name ??
                                            "";
                                    controller.requestClasses();
                                    controller.requestTrainers();
                                    AutoRouter.of(context).popForced();
                                  },
                                  title: data![index].name ?? "",
                                  isSelected: data[index] ==
                                      controller.gymCubit.getValue(),
                                )),
                      ),
                    ])));
      },
      loadingBuilder: (context) {
        return const CustomIndicator();
      },
      failureBuilder: (context, error, callback) {
        return FailureViewWidget(onTap: callback);
      },
    );
  }
}
