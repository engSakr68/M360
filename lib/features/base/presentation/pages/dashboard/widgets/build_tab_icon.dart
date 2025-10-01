part of "dashboard_widgets_imports.dart";

class BuildTabIcon extends StatelessWidget {
  final int index;
  final DashboardController controller;
  final bool isChoosen;

  const BuildTabIcon({
    super.key,
    required this.index,
    required this.controller,
    required this.isChoosen,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.changeSelectPage(index),
      child: Container(
        height: 50.r,
        width: 50.r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).r,
          color: isChoosen
              ? context.colors.primary.withValues(alpha: 0.1)
              : context.colors.white,
        ),
        child: Center(
          child: Image.asset(
            controller.tabs[index],
            height: 40.r,
            width: 40.r,
            color:
                isChoosen ? context.colors.primary : context.colors.greyWhite,
          ),
        ),
      ),
    );
  }
}
