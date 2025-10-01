part of 'dashboard_imports.dart';

class DashboardController{
  final ObsValue<int> navigationBarObs = ObsValue<int>.withInit(0);

  late TabController tabController;

  List<String> tabs = [
    Res.home,
    Res.calendar,
    Res.profile,
  ];

  void initBottomNavigation(TickerProvider ticker, int index) {
    tabController =
        TabController(length: 3, vsync: ticker, initialIndex: index);
    tabController.animateTo(index);
    navigationBarObs.setValue(index);
  }

  void changeSelectPage(int index) {
    tabController.animateTo(index);
    navigationBarObs.setValue(index);
  }
}