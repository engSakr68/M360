import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member360/core/constants/gaps.dart';
import 'package:member360/core/helpers/di.dart';
import 'package:member360/core/helpers/services/current_version_helper.dart';
import 'package:member360/core/helpers/share_services.dart';
import 'package:member360/core/localization/translate.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';
import 'package:member360/core/widgets/languages_widget/languages_widget.dart';
import 'package:member360/features/auth/presentation/widgets/auth_drawer_item_widget.dart';

class AuthDrawerWidget extends StatelessWidget {
  const AuthDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        width: 260.r,
        backgroundColor: context.colors.white,
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsetsDirectional.only(top: 30.r, end: 20.r, start: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.close,
                      color: context.colors.black,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 20.r, vertical: 25.r),
                children: [
                  const LanguagesWidget(),
                  AuthDrawerItemWidget(
                    text: Translate.of(context).Share_the_app,
                    onTap: () => getIt<ShareServices>().shareApp(),
                  ),
                  AuthDrawerItemWidget(
                    text: Translate.of(context).Privacy_Policy,
                    onTap: () => getTerms(context),
                  ),
                  // AuthDrawerItemWidget(
                  //   text: Translate.of(context).About_Simat_application,
                  //   onTap: () {},
                  // ),
                  AuthDrawerItemWidget(
                    text: Translate.of(context).About_New_version,
                    subtext:
                        'v.${CurrentVersionHelper.instance.currentVersion}',
                  ),
                ],
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              '© 2024 by Member360',
              style: AppTextStyle.s12_w400(color: context.colors.primary),
            ),
            Gaps.vGap32,
          ],
        ),
      ),
    );
  }

  void getTerms(BuildContext context) {
    // AppBottomSheets.showScrollableBody(
    //   context: context,
    //   builder: (context) => const Terms(),
    // );
  }
}
