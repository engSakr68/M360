part of "home_widgets_imports.dart";

class BuildHomeTitle extends StatelessWidget {
  final UserInfoModel? profile;
  const BuildHomeTitle({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimens.screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "${profile?.fname ?? ""} ${profile?.sname ?? ""}",
            textAlign: TextAlign.start,
            style: AppTextStyle.s20_w800(color: context.colors.black),
          ),
        ],
      ),
    );
  }
}
