import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';
import 'package:member360/core/widgets/shimmers/build_shimmer_view.dart';

class CustomIndicator extends StatelessWidget {
  final String name;
  const CustomIndicator({super.key, this.name = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.white,
        borderRadius: BorderRadius.only(
          topRight: const Radius.circular(20).r,
          topLeft: const Radius.circular(20).r,
        ),
      ),
      height: MediaQuery.of(context).size.height * .9,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15).r,
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: AppTextStyle.s20_w500(color: context.colors.blackDark),
                  ),
                  InkWell(
                    onTap: () => AutoRouter.of(context).pop(),
                    child: Icon(
                      Icons.close,
                      color: context.colors.black,
                    ),
                  )
                ],
              )),
          Expanded(
            child: Column(
              children: List.generate(8, (index) {
                return BuildShimmerView(
                  height: 50,
                  margin: const EdgeInsets.only(top: 10).r,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
