import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget> actions;
  final double? size;
  final bool? showBack;
  final bool? centerTitle;
  final Color? backgroundColor;

  const DefaultAppBar({
    super.key,
    required this.title,
    this.actions = const [],
    this.leading,
    this.size,
    this.backgroundColor,
    this.showBack = true,
    this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyle.s24_w500(color: context.colors.black),
      ),
      centerTitle: centerTitle ?? true,
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
      backgroundColor: backgroundColor ?? context.colors.background,
      elevation: 0,
      leadingWidth: showBack == true ? 55 : 10,
      leading: leading,
      automaticallyImplyLeading: leading != null,
      actions: [
        ...actions,
        if (showBack == true)
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                color: context.colors.black,
                size: 24,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(size ?? 65);
}
