part of "details_widgets_imports.dart";

class BuildClassPrice extends StatelessWidget {
  final ClassModel details;
  const BuildClassPrice({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.vGap16,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.person,
              color: context.colors.black,
              size: 20.r,
            ),
            Text(
              " ${details.trainer}",
              softWrap: true,
              textAlign: TextAlign.start,
              style: AppTextStyle.s14_w400(color: context.colors.black),
            ),
          ],
        ),
        Gaps.vGap8,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "\$${details.price} ",
              softWrap: true,
              textAlign: TextAlign.start,
              style: AppTextStyle.s14_w800(color: context.colors.black),
            ),
            Text(
              "Per Session",
              softWrap: true,
              textAlign: TextAlign.start,
              style: AppTextStyle.s14_w400(color: context.colors.black),
            ),
          ],
        ),
        Gaps.vGap8,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${details.availableSpots ?? (int.parse(details.maxSlots.toString()) - int.parse(details.attendancesCount.toString()))} ",
              softWrap: true,
              textAlign: TextAlign.start,
              style: AppTextStyle.s14_w800(color: context.colors.black),
            ),
            Text(
              "Available Spots",
              softWrap: true,
              textAlign: TextAlign.start,
              style: AppTextStyle.s14_w400(color: context.colors.black),
            ),
          ],
        ),
        Visibility(
            visible: int.parse(details.maxSlots.toString()) -
                        int.parse(details.attendancesCount.toString()) ==
                    0 &&
                details.waitList == true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${details.waitLimit! - details.waitSpots!} ",
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style: AppTextStyle.s14_w800(color: context.colors.black),
                    ),
                    Text(
                      "WaitingList Spots",
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style: AppTextStyle.s14_w400(color: context.colors.black),
                    ),
                  ],
                ),
              ],
            )),
        Gaps.vGap16,
      ],
    );
  }
}
