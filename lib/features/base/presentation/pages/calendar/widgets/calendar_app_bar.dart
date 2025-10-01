part of "calendar_widgets_imports.dart";

class CalendarAppBar extends StatelessWidget implements PreferredSizeWidget {
  final CalendarController controller;
  const CalendarAppBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Calendar",
        style: AppTextStyle.s18_w500(color: context.colors.black),
      ),
      centerTitle: true,
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      backgroundColor: context.colors.white,
      elevation: 1,
      leadingWidth: 55.w,
      leading: ObsValueConsumer<bool>(
          observable: controller.filterCubit,
          builder: (context, value) {
            return IconButton(
              icon: Icon(
                Icons.display_settings,
                color: value
                    ? context.colors.primary
                    : context.colors.blackOpacity,
                size: 25.r,
              ),
              onPressed: () => controller.filterCubit.setValue(!value),
            );
          }),
      // actions: [
      //   IconButton(
      //   icon: Icon(Icons.calendar_month, color: context.colors.blackOpacity, size: 25.r,),
      //   onPressed: () => Navigator.of(context).pop(),
      // ),
      // ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}
