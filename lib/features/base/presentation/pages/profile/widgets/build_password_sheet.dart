part of "profile_widgets_imports.dart";

class BuildPasswordSheet extends StatelessWidget {
  final ProfileController controller;
  const BuildPasswordSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: MediaQuery.of(context).size.height * .6,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16).r,
        decoration: BoxDecoration(
          color: context.colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Form(
            key: controller.passKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Gaps.vGap32,
                Text("Old Password",
                    style: AppTextStyle.s14_w800(color: context.colors.black)),
                ObsValueConsumer(
                    observable: controller.oldVisibleObs,
                    builder: (context, state) {
                      return GenericTextField(
                        controller: controller.oldController,
                        fieldTypes:
                            state ? FieldTypes.normal : FieldTypes.password,
                        type: TextInputType.text,
                        action: TextInputAction.next,
                        validate: (value) => value?.validateEmpty(),
                        hint: "Enter old password",
                        margin: const EdgeInsets.only(top: 8).r,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            Res.password,
                            height: 20.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                        suffixIcon: InkWell(
                            onTap: () =>
                                controller.oldVisibleObs.setValue(!state),
                            child: Icon(
                              state
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: state
                                  ? context.colors.primary
                                  : context.colors.disableGray,
                              size: 20.h,
                            )),
                      );
                    }),
                Gaps.vGap8,
                Text("New Password",
                    style: AppTextStyle.s14_w800(color: context.colors.black)),
                ObsValueConsumer(
                    observable: controller.visibleObs,
                    builder: (context, state) {
                      return GenericTextField(
                        controller: controller.passwordController,
                        fieldTypes:
                            state ? FieldTypes.normal : FieldTypes.password,
                        type: TextInputType.text,
                        action: TextInputAction.next,
                        validate: (value) => value?.validatePassword(),
                        hint: "Enter new password",
                        margin: const EdgeInsets.only(top: 8).r,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            Res.password,
                            height: 20.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                        suffixIcon: InkWell(
                            onTap: () => controller.visibleObs.setValue(!state),
                            child: Icon(
                              state
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: state
                                  ? context.colors.primary
                                  : context.colors.disableGray,
                              size: 20.h,
                            )),
                      );
                    }),
                Gaps.vGap8,
                Text("Confirm Password",
                    style: AppTextStyle.s14_w800(color: context.colors.black)),
                ObsValueConsumer(
                    observable: controller.confirmVisibleObs,
                    builder: (context, state) {
                      return GenericTextField(
                        controller: controller.confirmController,
                        fieldTypes:
                            state ? FieldTypes.normal : FieldTypes.password,
                        type: TextInputType.text,
                        action: TextInputAction.done,
                        validate: (value) =>
                            value?.validatePasswordConfirm(pass: controller.passwordController.text),
                        hint: "Confirm new password",
                        margin: const EdgeInsets.only(top: 8).r,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            Res.password,
                            height: 20.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                        suffixIcon: InkWell(
                            onTap: () =>
                                controller.confirmVisibleObs.setValue(!state),
                            child: Icon(
                              state
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: state
                                  ? context.colors.primary
                                  : context.colors.disableGray,
                              size: 20.h,
                            )),
                      );
                    }),
                Gaps.vGap12,
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20).r,
                  child: AppTextButton.maxCustom(
                    text: "Save",
                    onPressed: () => controller.changePassword(context),
                    bgColor: context.colors.secondary,
                    txtColor: context.colors.white,
                    textSize: 14.sp,
                    maxHeight: 50.h,
                  ),
                ),
              ],
            )));
  }
}
