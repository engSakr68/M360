part of "calendar_widgets_imports.dart";

class BuildTrainerWarning extends StatelessWidget {
  const BuildTrainerWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).r,
      child: Column(
        children: [
          Text(
            "No Trainer Selected",
            style: AppTextStyle.s16_w800(color: context.colors.black),
          ),
          Gaps.vGap4,
          Text(
            "Select a trainer from the filters view first to see their schedule.",
            textAlign: TextAlign.center,
            softWrap: true,
            style: AppTextStyle.s14_w400(color: context.colors.blackOpacity),
          ),
          Gaps.vGap24,
          Image.asset(
            Res.noTrainer,
            height: 200.h,
            width: 200.h,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
