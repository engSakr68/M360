part of 'splash_widgets_imports.dart';

class BuildSplashLoadingIndicator extends StatelessWidget {
  const BuildSplashLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimens.screenWidth,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(seconds: 2),
        onEnd: () {},
        builder: (BuildContext context, double value, Widget? child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5).r,
                  child: LinearProgressIndicator(
                    value: value,
                    color: context.colors.secondary,
                    backgroundColor: context.colors.white,
                    minHeight: 6,
                  ),
                ),
                Gaps.vGap8,
                Text(
                  '© 2023 by GymVue',
                  style: AppTextStyle.s12_w400(color: context.colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
