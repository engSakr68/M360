part of "session_widgets_imports.dart";

class BuildSessionPrice extends StatelessWidget {
  final TrainerModel trainer;
  const BuildSessionPrice({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.vGap16,
        Text(
          "Session Prices", style: AppTextStyle.s16_w800(color: context.colors.black),
        ),
        Gaps.vGap8,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: trainer.profile!.prices!.length,
          separatorBuilder: (context, index) => Gaps.vGap8,
          itemBuilder: (context, index) =>Text(
            "${trainer.profile!.prices![index].price} - ${trainer.profile!.prices![index].label}",
            softWrap: true,
            textAlign: TextAlign.start,
            style: AppTextStyle.s14_w400(color: context.colors.black),
          ),
        ),
        Gaps.vGap16,
        Divider(
          color: context.colors.disableGray,
        ),
      ],
    );
  }
}