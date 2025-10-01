part of "restore_password_widgets_imports.dart";

class BuildRestoreForm extends StatelessWidget {
  final RestorePasswordController controller;
  const BuildRestoreForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.vGap32,
          Text("Reset Code",
              style: AppTextStyle.s14_w800(color: context.colors.black)),
          GenericTextField(
            controller: controller.codeController,
            fieldTypes: FieldTypes.normal,
            type: TextInputType.text,
            action: TextInputAction.next,
            validate: (value) => value?.validateCode(message: "Code must be 6 letters"),
            hint: "Enter your reset code",
            margin: const EdgeInsets.symmetric(vertical: 8).r,
          ),
          Gaps.vGap8,
          Text("New Password",
              style: AppTextStyle.s14_w800(color: context.colors.black)),
          ObsValueConsumer(
              observable: controller.visibleObs,
              builder: (context, state) {
                return GenericTextField(
                  controller: controller.passwordController,
                  fieldTypes:state? FieldTypes.normal : FieldTypes.password,
                  type: TextInputType.text,
                  action: TextInputAction.next,
                  validate: (value) => value?.validatePassword(),
                  hint: "Enter new password",
                  margin: const EdgeInsets.only(top: 8).r,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(Res.password, height: 20.h, fit: BoxFit.contain,),
                  ),
                  suffixIcon: InkWell(
                      onTap: () =>
                          controller.visibleObs.setValue(!state),
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
                  fieldTypes:state? FieldTypes.normal : FieldTypes.password,
                  type: TextInputType.text,
                  action: TextInputAction.done,
                  validate: (value) => value?.validatePasswordConfirm(pass: controller.passwordController.text),
                  hint: "Confirm new password",
                  margin: const EdgeInsets.only(top: 8).r,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(Res.password, height: 20.h, fit: BoxFit.contain,),
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
        ],
      ),
    );
  }
}
