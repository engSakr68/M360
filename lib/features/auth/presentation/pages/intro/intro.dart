part of "intro_imports.dart";

@RoutePage(name: "IntroRoute")
class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  IntroController controller = IntroController();
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, v) {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime ?? DateTime.now()) >
                const Duration(seconds: 2)) {
          currentBackPressTime = now;
          AppSnackBar.showSimpleToast(
            color: context.colors.black,
            msg: "Press again to close app",
            type: ToastType.success,
          );
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: Container(
          height: Dimens.screenHeight,
          width: Dimens.screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(Res.background), fit: BoxFit.fill)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const BuildIntroTitle(),
              const BuildIntroButton(),
              Gaps.vGap24,
            ],),
        ),
      ),
    );
  }
}