part of "home_widgets_imports.dart";

class BuildTrainerCard extends StatelessWidget {
  final String image, title, fullName, time, date;
  const BuildTrainerCard(
      {super.key,
      required this.image,
      required this.fullName,
      required this.title,
      required this.time,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CachedImage(
          url: image,
          height: 60.r,
          width: 60.r,
          borderRadius: BorderRadius.circular(60).r,
          haveRadius: true,
        ),
        Gaps.hGap8,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyle.s14_w800(color: context.colors.black),
            ),
            Gaps.vGap8,
            Text(
              fullName,
              style: AppTextStyle.s12_w500(color: context.colors.blackOpacity),
            ),
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
                Text(
                  date,
                  style: AppTextStyle.s10_w500(color: context.colors.black),
                ),
                Text(
                  " . ",
                  style:
                      AppTextStyle.s14_w800(color: context.colors.disableGray),
                ),
                Text(
                  "$time mins.",
                  style: AppTextStyle.s10_w500(color: context.colors.black),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
