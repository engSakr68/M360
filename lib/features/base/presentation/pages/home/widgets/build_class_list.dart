part of "home_widgets_imports.dart";

class BuildClassList extends StatelessWidget {
  final HomeController controller;
  const BuildClassList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RequesterConsumer(
      requester: controller.classesRequester,
      successBuilder: (context, data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booked Classes",
              textAlign: TextAlign.start,
              style: AppTextStyle.s14_w800(color: context.colors.black),
            ),
            Gaps.vGap10,
            Visibility(
              visible: data!.isNotEmpty,
              replacement: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gaps.vGap16,
                    Image.asset(
                      Res.empty,
                      height: 200.h,
                      width: 200.h,
                      fit: BoxFit.fill,
                    ),
                    Gaps.vGap24,
                    Text(
                      "No classes booked yet!",
                      style: AppTextStyle.s16_w800(color: context.colors.black),
                    ),
                    Gaps.vGap4,
                    Text(
                      "Book classes through calendar.",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.s14_w400(
                          color: context.colors.blackOpacity),
                    ),
                  ],
                ),
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () => AutoRouter.of(context)
                      .push(DetailsRoute(details: data[index])),
                  child: BuildTrainerCard(
                    image: data[index].imageUrl ?? "",
                    title: data[index].title ?? "",
                    fullName: data[index].trainer ?? "",
                    time: DateTime.parse(data[index].end!)
                        .difference(DateTime.parse(data[index].start!))
                        .inMinutes
                        .toString(),
                    date: DateFormat("yyyy/MM/dd")
                        .format(DateTime.parse(data[index].start!)),
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    Gaps.vGap10,
              ),
            ),
          ],
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
