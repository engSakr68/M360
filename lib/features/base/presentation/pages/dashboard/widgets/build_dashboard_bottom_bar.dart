part of "dashboard_widgets_imports.dart";

class BuildDashboardBottomBar extends StatelessWidget {
  final DashboardController controller;

  const BuildDashboardBottomBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ObsValueConsumer(
      observable: controller.navigationBarObs,
      builder: (context, state) {
        return Container(         
          height: 70.h,
          decoration: BoxDecoration(
            color: context.colors.white,
            border: Border(top: BorderSide(color: context.colors.greyWhite)),
          ),
          child: TabBar(
            labelPadding: EdgeInsets.zero,
            indicatorColor: Colors.transparent,
            controller: controller.tabController,
            tabs: List.generate(controller.tabs.length, (index) {
              return BuildTabIcon(
                index: index,
                controller: controller,
                isChoosen: state == index? true :false,
              );
            }),
          ),
        );
      },
    );
  }
}
