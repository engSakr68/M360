part of "details_widgets_imports.dart";

class BuildClassHeader extends StatelessWidget {
  final ClassModel details;
  const BuildClassHeader({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedImage(
              url: details.imageUrl ?? "",
              height: 85.r,
              width: 85.r,
              haveRadius: true,
              borderRadius: BorderRadius.circular(50).r,
            ),
            Gaps.hGap12,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  details.title ?? "",
                  softWrap: true,
                  textAlign: TextAlign.start,
                  style: AppTextStyle.s18_w700(color: context.colors.black),
                ),
                Gaps.vGap8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: context.colors.greyWhite,
                      size: 20.r,
                    ),
                    Text(
                      " ${details.gymName}",
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style: AppTextStyle.s14_w400(color: context.colors.black),
                    ),
                  ],
                ),
                Gaps.vGap4,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: context.colors.greyWhite,
                      size: 20.r,
                    ),
                    Text(
                      " ${DateFormat("dd/MM/yyyy hh:mm a").format(DateTime.parse(details.start!))}",
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style: AppTextStyle.s14_w400(color: context.colors.black),
                    ),
                  ],
                ),
                Gaps.vGap4,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: context.colors.greyWhite,
                      size: 20.r,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " ${DateFormat('hh:mm a').format(DateTime.parse(details.start!))} - ${DateFormat('hh:mm a').format(DateTime.parse(details.end!))}",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: AppTextStyle.s14_w400(color: context.colors.black),
                        ),
                        Gaps.vGap4,
                        Text(
                          " ${DateTime.parse(details.end!).difference(DateTime.parse(details.start!)).inMinutes.toString()}",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: AppTextStyle.s14_w400(color: context.colors.black),
                        ),
                      ],
                    )
                  ],
                ),
                
              ],
            ),
          ],
        ),
        Gaps.vGap16,
        Divider(
          color: context.colors.disableGray,
        ),
      ],
    );
  }
}
