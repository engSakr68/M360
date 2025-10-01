part of "profile_widgets_imports.dart";

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ProfileController controller;
  const ProfileAppBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Profile",
        style: AppTextStyle.s16_w800(color: context.colors.black),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
      backgroundColor: context.colors.white,
      elevation: 0,
      leadingWidth: 55,
      actions: [
        ObsValueConsumer(
            observable: controller.editCubit,
            builder: (context, state) {
              return IconButton(
                icon: Text(
                  state ? "Cancel" : "Edit",
                  style: AppTextStyle.s12_w600(color: context.colors.primary),
                ),
                onPressed: () => controller.editCubit.setValue(!state),
              );
            })
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55.h);
}
