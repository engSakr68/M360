part of "profile_widgets_imports.dart";

class BuildProfileTitle extends StatelessWidget {
  final ProfileController controller;
  final String title;
  const BuildProfileTitle({super.key, required this.controller, required this.title});

  @override
  Widget build(BuildContext context) {
    return ObsValueConsumer(
        observable: controller.editCubit,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        AppTextStyle.s12_w700(color: context.colors.disableGray)),
                state? Icon(
                  Icons.edit,
                  size: 10.r,
                  color: context.colors.blackOpacity,
                ) : Gaps.empty,
              ],
            ),
          );
        });
  }
}
