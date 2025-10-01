part of "intro_widgets_imports.dart";

class BuildIntroTitle extends StatelessWidget {
  const BuildIntroTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).r,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24).r,
            child: Text(
              "Your 24/7 fitness partner",
              softWrap: true,
              textAlign: TextAlign.center,
              style: AppTextStyle.s24_w700(color: context.colors.black).copyWith(height: 1.2.h),
            ),
          ),
          Gaps.vGap24,
          Text(
            "Manage your gym membership, book classes and PT session, all in the one app",
            softWrap: true,
            textAlign: TextAlign.center,
            style: AppTextStyle.s14_w500(color: context.colors.blackOpacity).copyWith(height: 1.2.h),
          ),
        ],
      ),
    );
  }
}
