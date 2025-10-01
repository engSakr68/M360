part of 'splash_widgets_imports.dart';

class BuildSplashLogo extends StatefulWidget {
  const BuildSplashLogo({super.key});

  @override
  State<BuildSplashLogo> createState() =>
      _BuildSplashLogoState();
}

class _BuildSplashLogoState extends State<BuildSplashLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;
  late Animation<double> transform;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    )..addListener(() {
        setState(() {});
      });

    transform = Tween<double>(begin: 2, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: opacity.value,
        child: Transform.scale(scale: transform.value, child: Center(
          child: Hero(
          tag: Res.logo,
          child: Image.asset(
            Res.logo,
            fit: BoxFit.fill,
            color: context.colors.white,
          ),
              ),
        ),));
  }
}

