part of "calendar_widgets_imports.dart";

class BuildCalendarFilter extends StatelessWidget {
  final CalendarController controller;
  const BuildCalendarFilter({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ObsValueConsumer<bool>(
                  observable: controller.filterCubit,
                  builder: (context, value) {
                    return Visibility(
            visible: value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).r,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GenericTextField(
                          fontSize: 10,
                          controller: controller.gymController,
                          onTab: () => controller.onChooseGym(context),
                          fieldTypes: FieldTypes.clickable,
                          type: TextInputType.text,
                          action: TextInputAction.next,
                          validate: (value) => value?.noValidate(),
                          hint: "Select a gym",
                          margin: const EdgeInsets.only(top: 10),
                          fillColor: context.colors.white,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              Res.gym,
                              height: 20.r,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Gaps.hGap8,
                      Expanded(
                        child: GenericTextField(
                          fontSize: 10,
                          controller: controller.trainerController,
                          onTab: () => controller.onChooseTrainer(context),
                          fieldTypes: FieldTypes.clickable,
                          type: TextInputType.text,
                          action: TextInputAction.next,
                          validate: (value) => value?.noValidate(),
                          hint: "Select a trainer",
                          margin: const EdgeInsets.only(top: 10),
                          fillColor: context.colors.white,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              Res.trainer,
                              height: 20.r,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GenericTextField(
                    fontSize: 10,
                    controller: controller.tagController,
                    onTab: () => controller.onChooseTag(context),
                    fieldTypes: FieldTypes.clickable,
                    type: TextInputType.text,
                    action: TextInputAction.done,
                    validate: (value) => value?.noValidate(),
                    hint: "Select an activity type",
                    margin: const EdgeInsets.only(top: 10),
                    fillColor: context.colors.white,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
