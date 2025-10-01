part of 'splash_widgets_imports.dart';

class BuildBackgroundLogo extends StatelessWidget {
  const BuildBackgroundLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          Res.background,
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          fit: BoxFit.fill,
        ),
        Container(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          color: context.colors.primary.withValues(alpha: 0.8),
        ),
      ],
    );
  }
}
