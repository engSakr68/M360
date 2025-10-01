part of "deactivate_widgets_imports.dart";

class BuildDeactivateForm extends StatelessWidget {
  final DeactivateController controller;
  const BuildDeactivateForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Reason",
              style: AppTextStyle.s14_w800(color: context.colors.black)),
          GenericTextField(
            onTab: () => controller.onChooseReason(context),
            controller: controller.reasonController,
            fieldTypes: FieldTypes.clickable,
            type: TextInputType.text,
            action: TextInputAction.next,
            validate: (value) => value?.validateEmpty(),
            hint: "Choose reason",
            margin: const EdgeInsets.symmetric(vertical: 8).r,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.arrow_drop_down,
                size: 20.h,
                color: context.colors.blackOpacity,
              ),
            ),
          ),
          Gaps.vGap8,
          BlocBuilder<BaseBloc<String>, BaseState<String>>(
              bloc: controller.reasonCubit,
              builder: (context, state) {
                return Visibility(
                    visible: state.data == "Other",
                    child: Column(
                      children: [
                        GenericTextField(
                          controller: controller.otherReasonController,
                          fieldTypes: FieldTypes.normal,
                          type: TextInputType.text,
                          action: TextInputAction.next,
                          validate: (value) => value?.validateEmpty(),
                          hint: "Write reason",
                          margin: const EdgeInsets.symmetric(vertical: 8).r,
                        ),
                        Gaps.vGap8,
                      ],
                    ));
              }),
          Text("Anything you didn't like?",
              style: AppTextStyle.s14_w800(color: context.colors.black)),
          GenericTextField(
            onTab: () => controller.onChooseDescription(context),
            controller: controller.descriptionController,
            fieldTypes: FieldTypes.clickable,
            type: TextInputType.text,
            action: TextInputAction.next,
            validate: (value) => value?.validateEmpty(),
            hint: "Choose what you didn't like",
            margin: const EdgeInsets.symmetric(vertical: 8).r,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.arrow_drop_down,
                size: 20.h,
                color: context.colors.blackOpacity,
              ),
            ),
          ),
          Gaps.vGap8,
          BlocBuilder<BaseBloc<String>, BaseState<String>>(
              bloc: controller.descriptionCubit,
              builder: (context, state) {
                return Visibility(
                    visible: state.data == "Other",
                    child: Column(
                      children: [
                        GenericTextField(
                          controller: controller.otherDescriptionController,
                          fieldTypes: FieldTypes.normal,
                          type: TextInputType.text,
                          action: TextInputAction.next,
                          validate: (value) => value?.validateEmpty(),
                          hint: "Write what you didn't like",
                          margin: const EdgeInsets.symmetric(vertical: 8).r,
                        ),
                        Gaps.vGap8,
                      ],
                    ));
              }),
          Text("What did you like about our gym?",
              style: AppTextStyle.s14_w800(color: context.colors.black)),
          GenericTextField(
            controller: controller.likeController,
            fieldTypes: FieldTypes.normal,
            type: TextInputType.text,
            action: TextInputAction.next,
            validate: (value) => value?.validateEmpty(),
            hint: "",
            margin: const EdgeInsets.symmetric(vertical: 8).r,
          ),
          Gaps.vGap8,
          Text("Would you recommend it to your friend?",
              style: AppTextStyle.s14_w800(color: context.colors.black)),
          GenericTextField(
            onTab: () => controller.onChooseRecommend(context),
            controller: controller.recommendController,
            fieldTypes: FieldTypes.clickable,
            type: TextInputType.text,
            action: TextInputAction.next,
            validate: (value) => value?.validateEmpty(),
            hint: "Choose option",
            margin: const EdgeInsets.symmetric(vertical: 8).r,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.arrow_drop_down,
                size: 20.h,
                color: context.colors.blackOpacity,
              ),
            ),
          ),
          Gaps.vGap8,
          Text("Other",
              style: AppTextStyle.s14_w800(color: context.colors.black)),
          GenericTextField(
            controller: controller.otherController,
            fieldTypes: FieldTypes.normal,
            type: TextInputType.text,
            action: TextInputAction.next,
            validate: (value) => value?.validateEmpty(),
            hint: "",
            margin: const EdgeInsets.symmetric(vertical: 8).r,
          ),
        ],
      ),
    );
  }
}
