part of "calendar_widgets_imports.dart";

class CalendarClassLoading extends StatelessWidget {
  const CalendarClassLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shrinkWrap: true,
        itemCount: 4,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).r,
              child: Row(
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
                          const TextShimmer(
                            lineWidthPercent: 0.3,
                          ),
                          Text(
                            " . ",
                            style: AppTextStyle.s14_w800(
                                color: context.colors.disableGray),
                          ),
                          const TextShimmer(
                            lineWidthPercent: 0.3,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }
}
