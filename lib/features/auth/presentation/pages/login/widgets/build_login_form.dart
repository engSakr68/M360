part of 'login_widgets_imports.dart';

class BuildLoginForm extends StatelessWidget {
  final LoginController controller;

  const BuildLoginForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.vGap32,
          Text("Email",
              style: AppTextStyle.s14_w800(color: context.colors.black)),
          GenericTextField(
            controller: controller.emailController,
            fieldTypes: FieldTypes.normal,
            type: TextInputType.emailAddress,
            action: TextInputAction.next,
            validate: (value) => value?.validateEmail(),
            hint: "Your email",
            margin: const EdgeInsets.symmetric(vertical: 8).r,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(Res.email, height: 20.h, fit: BoxFit.contain,),
            ),
          ),
          Gaps.vGap8,
          Text("Password",
              style: AppTextStyle.s14_w800(color: context.colors.black)),
          ObsValueConsumer(
              observable: controller.visibleObs,
              builder: (context, state) {
                return GenericTextField(
                  controller: controller.passwordController,
                  fieldTypes:state? FieldTypes.normal : FieldTypes.password,
                  type: TextInputType.text,
                  action: TextInputAction.done,
                  validate: (value) => value?.validateEmpty(),
                  hint: "Your super secret password",
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
          Gaps.vGap12,
        ],
      ),
    );
  }
}
