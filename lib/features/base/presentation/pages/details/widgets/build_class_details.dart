part of "details_widgets_imports.dart";

class BuildClassDetails extends StatelessWidget {
  final ClassModel details;
  const BuildClassDetails({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: details.description == null || details.description == "",
      replacement: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.vGap16,
          Text(
            "Details",
            style: AppTextStyle.s16_w800(color: context.colors.black),
          ),
          Gaps.vGap8,
          Text(
            details.description ?? "",
            softWrap: true,
            textAlign: TextAlign.start,
            style: AppTextStyle.s14_w400(color: context.colors.black),
          ),
          Gaps.vGap16,
          Divider(
            color: context.colors.disableGray,
          ),
        ],
      ),
      child: Gaps.empty,
    );
  }
}
