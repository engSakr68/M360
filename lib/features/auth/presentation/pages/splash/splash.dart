part of 'splash_imports.dart';

@RoutePage(name: "SplashRoute")
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  final SplashController controller = SplashController();

  @override
  void initState() {
    controller.manipulateSaveData(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage(Res.logo), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: context.colors.primary,
      body: Stack(
        alignment: FractionalOffset.center,
        children: [
          BuildBackgroundLogo(),
          Stack(
            alignment: Alignment.center,
            children: [
              BuildSplashLogo(),
              Positioned(
                bottom: 0,
                child: BuildSplashLoadingIndicator(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
