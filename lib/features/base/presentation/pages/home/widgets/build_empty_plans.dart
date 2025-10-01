part of "home_widgets_imports.dart";

class BuildEmptyPlans extends StatelessWidget {
  const BuildEmptyPlans({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).r,
      child: Column(
        children: [
          Text(
            "No Active Plans",
            style: AppTextStyle.s16_w800(color: context.colors.black),
          ),
          Gaps.vGap4,
          Text(
            "We couldn't find any active plans for that gym.",
            softWrap: true,
            textAlign: TextAlign.center,
            style: AppTextStyle.s14_w400(color: context.colors.blackOpacity),
          ),
          Gaps.vGap24,
          Image.asset(
            Res.empty,
            height: 200.h,
            width: 200.h,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
