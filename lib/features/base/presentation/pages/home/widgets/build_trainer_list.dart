part of "home_widgets_imports.dart";

class BuildTrainerList extends StatelessWidget {
  final HomeController controller;
  const BuildTrainerList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RequesterConsumer(
      requester: controller.sessionsRequester,
      successBuilder: (context, data) {
        return data == null
            ? Gaps.empty
            : Visibility(
                visible: data.events!.isNotEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "PT Sessions",
                      textAlign: TextAlign.start,
                      style: AppTextStyle.s14_w800(color: context.colors.black),
                    ),
                    Gaps.vGap10,
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shrinkWrap: true,
                      itemCount: data.events!.length,
                      itemBuilder: (context, index) => InkWell(
                        // onTap: () => AutoRouter.of(context).push(SessionRoute(
                        //     trainer: data.trainers![index],
                        //     openTimesPerDay:
                        //         data.trainers![index].openTimesPerDay![0],
                        //     date: data.events![index].date ?? "")),
                        child: BuildTrainerCard(
                          image: data.events![index].trainer!.photoUrl ?? "",
                          title: data.events![index].title ?? "",
                          fullName: data.events![index].trainer!.fullName ?? "",
                          time: DateTime.parse(data.events![index].end!)
                              .difference(
                                  DateTime.parse(data.events![index].start!))
                              .inMinutes
                              .toString(),
                          date: data.events![index].date ?? "",
                        ),
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          Gaps.vGap10,
                    ),
                  ],
                ),
              );
      },
      loadingBuilder: (context) {
        return ListView.builder(
            scrollDirection: Axis.vertical,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleShimmer(radius: 60.r),
                    Gaps.hGap8,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextShimmer.random(),
                        Gaps.vGap8,
                        TextShimmer.random(),
                        Gaps.vGap8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              color: context.colors.disableGray,
                              size: 15.r,
                            ),
                            Gaps.hGap5,
                            TextShimmer.random(),
                            Text(
                              " . ",
                              style: AppTextStyle.s14_w800(
                                  color: context.colors.disableGray),
                            ),
                            TextShimmer.random(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ));
      },
      failureBuilder: (context, error, callback) {
        return FailureViewWidget(onTap: callback);
      },
    );
  }
}
