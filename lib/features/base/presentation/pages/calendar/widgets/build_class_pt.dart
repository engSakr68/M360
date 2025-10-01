part of "calendar_widgets_imports.dart";

class BuildClassPT extends StatelessWidget {
  final CalendarController controller;
  const BuildClassPT({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ObsValueConsumer<bool>(
                  observable: controller.classPtCubit,
                  builder: (context, value) {
                    return Container(
            height: 40.h,
            width: Dimens.screenWidth,
            margin: const EdgeInsets.all(16).r,
            decoration: BoxDecoration(
              color: context.colors.white,
              borderRadius: BorderRadius.circular(10).r,
              border: Border.all(color: context.colors.blackOpacity),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: ()=> controller.classPtCubit.setValue(true),
                  child: Container(
                    height: 30.h,
                    width: Dimens.screenWidth * 0.43,
                    decoration: BoxDecoration(
                      color: value
                          ? context.colors.secondary
                          : context.colors.white,
                      borderRadius: BorderRadius.circular(10).r,
                    ),
                    child: Center(
                        child: Text(
                      "Class",
                      style: AppTextStyle.s14_w400(color: value
                          ? context.colors.white : context.colors.black),
                    )),
                  ),
                ),
                InkWell(
                  onTap: ()=> controller.classPtCubit.setValue(false),
                  child: Container(
                    height: 30.h,
                    width: Dimens.screenWidth * 0.43,
                    decoration: BoxDecoration(
                      color: value
                          ? context.colors.white
                          : context.colors.secondary,
                      borderRadius: BorderRadius.circular(10).r,
                    ),
                    child: Center(
                        child: Text(
                      "PT",
                      style: AppTextStyle.s14_w400(color: value
                          ? context.colors.black : context.colors.white),
                    )),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
