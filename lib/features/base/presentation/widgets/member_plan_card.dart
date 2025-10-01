import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:member360/core/constants/dimens.dart';
import 'package:member360/core/constants/gaps.dart';
import 'package:member360/core/helpers/string_helper.dart';
import 'package:member360/core/theme/colors/colors_extension.dart';
import 'package:member360/core/theme/text/app_text_style.dart';
import 'package:member360/features/base/data/models/active_plan_model/active_plan_model.dart';

class MemberPlanCard extends StatelessWidget {
  final ActivePlanModel plan;
  final VoidCallback onTap;
  final VoidCallback downloadTap;
  final bool isSelected;
  const MemberPlanCard(
      {super.key,
      required this.plan,
      required this.onTap,
      required this.downloadTap,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16).r,
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.primary.withValues(alpha: 0.1)
              : plan.currentBalance != 0
                  ? Colors.red.withValues(alpha: 0.1)
                  : Colors.green.withValues(alpha: 0.1),
          // plan.isSelected
          //     ? context.colors.primary.withValues(alpha: 0.1)
          //     : context.colors.greyWhite,
          border: Border.all(
            color: isSelected
                ? context.colors.primary
                : plan.currentBalance != 0
                    ? Colors.red
                    : Colors.green,
            // plan.isSelected
            //     ? context.colors.primary
            //     : context.colors.greyWhite
          ),
          borderRadius: BorderRadius.circular(10).r,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: Dimens.screenWidth * 0.55,
                    child: Text(
                      plan.planName ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.s14_w800(
                          color: context.colors.blackOpacity),
                    )),
                Gaps.vGap8,
                Text(
                  plan.duration == "entries"
                      ? "\$${plan.price} / ${plan.entryCount} ${plan.duration?.capitalize() ?? ""} used out of ${plan.durationCount}"
                      : plan.duration != null
                          ? "\$${plan.price} / ${plan.duration?.capitalize() ?? ""}"
                          : "\$${plan.price}",
                  style:
                      AppTextStyle.s12_w600(color: context.colors.blackOpacity),
                ),
                // Gaps.vGap8,
                // Text(
                //   plan.duration?.capitalize() ?? "",
                //   style: AppTextStyle.s12_w800(color: context.colors.blackOpacity),
                // ),
                Gaps.vGap8,
                Text(
                  "Start at: ${DateFormat("dd/MM/yyyy").format(DateTime.parse(plan.membershipStart!))}",
                  style:
                      AppTextStyle.s12_w600(color: context.colors.blackOpacity),
                ),
                Gaps.vGap8,
                plan.membershipEnd != null
                    ? Text(
                        "End at: ${DateFormat("dd/MM/yyyy").format(DateTime.parse(plan.membershipEnd!))}",
                        style: AppTextStyle.s12_w600(
                            color: context.colors.blackOpacity),
                      )
                    : Gaps.empty,
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  plan.currentBalance != 0 ? "Dishonoured" : "Active",
                  style: AppTextStyle.s12_w600(
                      color:
                          plan.currentBalance != 0 ? Colors.red : Colors.green),
                ),
                Gaps.vGap32,
                InkWell(
                  onTap: downloadTap,
                  child: Icon(
                    Icons.download,
                    color: context.colors.blackOpacity,
                    size: 24.r,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
