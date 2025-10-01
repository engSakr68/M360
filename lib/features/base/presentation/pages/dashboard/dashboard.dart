part of 'dashboard_imports.dart';

@RoutePage()
class Dashboard extends StatefulWidget {
  final int index;
  const Dashboard({super.key, required this.index});

  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  DashboardController controller = DashboardController();
  DateTime? currentBackPressTime;

  Future<void> _launchUrl(String url) async {
    final Uri appUrl = Uri.parse(url);

    if (!await launchUrl(appUrl)) {
      throw Exception('Could not launch $appUrl');
    }
  }

  void advancedStatusCheck(NewVersionPlus newVersion) async {
    var context = getIt<GlobalContext>().context();
    final status = await newVersion.getVersionStatus();
    print(status?.localVersion);
    print(status?.storeVersion);
    if (status != null) {
      if (status.canUpdate) {
        showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  backgroundColor: context.colors.white,
                  surfaceTintColor: context.colors.white,
                  title: Text(
                    "New Version",
                    style: AppTextStyle.s16_w500(
                      color: context.colors.black,
                    ),
                  ),
                  content: Text(
                    "New version available, press Update Now to go to store and update the app.",
                    style: AppTextStyle.s14_w400(color: context.colors.black)
                        .copyWith(height: 1.3),
                  ),
                  actions: [
                    AppTextButton.maxCustom(
                      text: 'Update Now',
                      onPressed: () => _launchUrl(status.appStoreLink),
                    )
                  ],
                ));
      }
    }
  }

  @override
  void initState() {
    controller.initBottomNavigation(this, widget.index);
    if (GlobalState.instance.get("initNotification") == false) {
      getIt<GlobalNotification>().setupNotification();
      GlobalState.instance.set("initNotification", true);
    }

    final newVersion = NewVersionPlus(
      androidId: "com.PayChoice.Member360",
      iOSId: "com.PayChoice.Member360",
      // "id6471948304",
    );
    advancedStatusCheck(newVersion);
    super.initState();
  }

  @override
  void dispose() {
    controller.tabController.dispose();
    super.dispose();
  }

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
      child: DefaultTabController(
        initialIndex: widget.index,
        length: controller.tabs.length,
        child: Scaffold(
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.tabController,
            children: const [
              Home(),
              Calendar(),
              Profile(),
            ],
          ),
          bottomNavigationBar: BuildDashboardBottomBar(
            controller: controller,
          ),
        ),
      ),
    );
  }
}
