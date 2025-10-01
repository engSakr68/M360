part of "calendar_widgets_imports.dart";

class BuildChooseTag extends StatelessWidget {
  final CalendarController controller;
  const BuildChooseTag({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RequesterConsumer(
      requester: controller.filterRequester,
      listener: (_, snapShot) {
        // controller.tagController.text = snapShot.data
        //     .where((element) => element.isSelected == true)
        //     .fold(
        //         "", (previousValue, item) => "$previousValue ${item.name!.en},")
        //     .toString();
      },
      successBuilder: (context, data) {
        return ObsValueConsumer(
            observable: controller.tagCubit,
            builder: (context, state) {
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
                      padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 15)
                          .r,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Select Tags",
                                      style: AppTextStyle.s20_w500(
                                          color: context.colors.black),
                                    ),
                                    InkWell(
                                      onTap: () =>
                                          AutoRouter.of(context).popForced(),
                                      child: Icon(
                                        Icons.close,
                                        color: context.colors.black,
                                      ),
                                    )
                                  ],
                                )),
                            Column(
                              children: List.generate(
                                  data?.tags?.length ?? 0,
                                  (index) => BuildCustomSheetItem(
                                        onTap: () {
                                          var tagList = state;
                                          tagList.add(data!.tags![index]);
                                          controller.tagCubit.setValue(tagList);
                                          controller.tagController.text = state
                                              .fold(
                                                  "",
                                                  (previousValue, item) =>
                                                      "$previousValue ${item.name!.en},")
                                              .toString();
                                          controller.requestClasses();
                                          controller.requestTrainers();
                                          AutoRouter.of(context).popForced();
                                        },
                                        title:
                                            data?.tags?[index].name?.en ?? "",
                                        isSelected: controller.tagCubit
                                            .getValue()
                                            .contains(data?.tags?[index]),
                                      )),
                            ),
                          ])));
            });
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
