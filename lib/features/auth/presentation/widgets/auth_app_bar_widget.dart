import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';

class BuildAuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Function()? onBack;
  final bool showBack;
  const BuildAuthAppBar({super.key, this.title, this.onBack, this.showBack = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title:title!=null? Text(title??"",style: AppTextStyle.s20_w500(color: context.colors.black),):null,
      backgroundColor: Colors.transparent,
      leading: Offstage(
        offstage: !showBack,
        child: InkWell(
          onTap:onBack?? AutoRouter.of(context).popForced,
          child: Icon(Icons.arrow_back_ios, size: 25, color: context.colors.black,),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
