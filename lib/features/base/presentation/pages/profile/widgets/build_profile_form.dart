part of "profile_widgets_imports.dart";

class BuildProfileForm extends StatelessWidget {
  final ProfileController controller;
  const BuildProfileForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ObsValueConsumer(
            observable: controller.editCubit,
            builder: (context, state) {
              return Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    BuildProfileTitle(
                        controller: controller, title: "First Name"),
                    GenericTextField(
                      profileStyle: true,
                      controller: controller.fnameController,
                      fieldTypes:
                          state ? FieldTypes.normal : FieldTypes.readonly,
                      type: TextInputType.text,
                      action: TextInputAction.next,
                      validate: (value) => value?.validateEmpty(),
                      hint: "Your First Name",
                      margin: EdgeInsets.zero,
                      contentPadding: EdgeInsets.zero,
                    ),
                    BuildProfileTitle(
                        controller: controller, title: "Last Name"),
                    GenericTextField(
                      profileStyle: true,
                      controller: controller.lnameController,
                      fieldTypes:
                          state ? FieldTypes.normal : FieldTypes.readonly,
                      type: TextInputType.text,
                      action: TextInputAction.next,
                      validate: (value) => value?.validateEmpty(),
                      hint: "Your Last Name",
                      margin: EdgeInsets.zero,
                      contentPadding: EdgeInsets.zero,
                    ),
                    BuildProfileTitle(controller: controller, title: "Email"),
                    GenericTextField(
                      profileStyle: true,
                      controller: controller.emailController,
                      fieldTypes:
                          state ? FieldTypes.normal : FieldTypes.readonly,
                      type: TextInputType.emailAddress,
                      action: TextInputAction.next,
                      validate: (value) => value?.validateEmail(),
                      hint: "Your Email",
                      margin: EdgeInsets.zero,
                      contentPadding: EdgeInsets.zero,
                    ),
                    BuildProfileTitle(controller: controller, title: "Phone"),
                    GenericTextField(
                      profileStyle: true,
                      controller: controller.phoneController,
                      fieldTypes:
                          state ? FieldTypes.normal : FieldTypes.readonly,
                      type: TextInputType.phone,
                      action: TextInputAction.next,
                      validate: (value) => value?.validatePhone(),
                      hint: "Your Phone",
                      margin: EdgeInsets.zero,
                      contentPadding: EdgeInsets.zero,
                    ),
                    BuildProfileTitle(
                        controller: controller, title: "Date of Birth"),
                    GenericTextField(
                      onTab: () => controller.showDateBicker(context),
                      profileStyle: true,
                      controller: controller.dateController,
                      fieldTypes:
                          state ? FieldTypes.clickable : FieldTypes.readonly,
                      type: TextInputType.text,
                      action: TextInputAction.done,
                      validate: (value) => value?.validateEmpty(),
                      hint: "Your Date of Birth",
                      margin: EdgeInsets.zero,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              );
            });
  }
}
