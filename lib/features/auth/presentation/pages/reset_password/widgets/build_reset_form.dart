part of'reset_password_widgets_imports.dart';

class BuildResetForm extends StatelessWidget {
  final ResetPasswordController controller;
  final bool isEmail;
  const BuildResetForm({super.key,required this.controller, required this.isEmail});

  @override
  Widget build(BuildContext context) {
    return isEmail? Form(
      key: controller.emailKey,
      child: GenericTextField(
              controller: controller.emailController,
              fieldTypes: FieldTypes.normal,
              type: TextInputType.emailAddress,
              action: TextInputAction.next,
              validate: (value) => value?.validateEmail(),
              hint: "Your email",
              margin: const EdgeInsets.symmetric(vertical: 32).r,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(Res.email, height: 20.h, fit: BoxFit.contain,),
              ),
            ),
    ) : Form(
      key: controller.phoneKey,
      child: GenericTextField(
              controller: controller.phoneController,
              fieldTypes: FieldTypes.normal,
              type: TextInputType.phone,
              action: TextInputAction.next,
              validate: (value) => value?.validatePhone(),
              hint: "Your Phone Number",
              margin: const EdgeInsets.symmetric(vertical: 32).r,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(Res.phone, height: 20.h, fit: BoxFit.contain,),
              )),
    );
  }
}
