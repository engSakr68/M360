part of "session_widgets_imports.dart";

class BuildTrainerInfo extends StatelessWidget {
  final TrainerModel trainer;
  const BuildTrainerInfo({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: context.colors.primary, width: 3.r),
              ),
              child: Center(
                child: CachedImage(
                  url: trainer.photoUrl ?? "",
                  height: 70.r,
                  width: 70.r,
                  haveRadius: true,
                  borderRadius: BorderRadius.circular(50).r,
                ),
              ),
            ),
            Gaps.hGap12,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  trainer.title ?? "",
                  softWrap: true,
                  textAlign: TextAlign.start,
                  style: AppTextStyle.s18_w700(color: context.colors.black),
                ),
                Gaps.vGap8,
                Text(
                  trainer.profile!.intro ?? "",
                  softWrap: true,
                  textAlign: TextAlign.start,
                  style: AppTextStyle.s14_w400(color: context.colors.black),
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
