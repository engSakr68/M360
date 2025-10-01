part of "session_widgets_imports.dart";

class BuildBookSession extends StatelessWidget {
  final SessionController controller;
  final TrainerModel trainer;
  const BuildBookSession(
      {super.key, required this.trainer, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.vGap16,
          Text(
            "When would you like to book for?",
            style: AppTextStyle.s16_w800(color: context.colors.black),
          ),
          Gaps.vGap8,
          Row(
            children: [
              Expanded(
                child: GenericTextField(
                  onTab: () => controller.onStartDate(context),
                  controller: controller.dateController,
                  fieldTypes: FieldTypes.clickable,
                  type: TextInputType.text,
                  action: TextInputAction.next,
                  validate: (value) => value?.validateEmpty(),
                  fillColor: context.colors.secondary.withValues(alpha: 0.1),
                  enableBorderColor:
                      context.colors.secondary.withValues(alpha: 0.1),
                  focusBorderColor:
                      context.colors.secondary.withValues(alpha: 0.1),
                  textColor: context.colors.secondary,
                  hint: "Start Date",
                  margin: EdgeInsets.zero,
                ),
              ),
              Gaps.hGap8,
              Expanded(
                child: GenericTextField(
                  onTab: () => controller.onStartTime(context),
                  controller: controller.timeController,
                  fieldTypes: FieldTypes.clickable,
                  type: TextInputType.text,
                  action: TextInputAction.done,
                  validate: (value) => value?.validateEmpty(),
                  fillColor: context.colors.secondary.withValues(alpha: 0.1),
                  enableBorderColor:
                      context.colors.secondary.withValues(alpha: 0.1),
                  focusBorderColor:
                      context.colors.secondary.withValues(alpha: 0.1),
                  textColor: context.colors.secondary,
                  hint: "Start Time",
                  margin: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          Gaps.vGap8,
          Text(
            "How long should the session go for?",
            style: AppTextStyle.s16_w800(color: context.colors.black),
          ),
          Gaps.vGap8,
          BlocBuilder<BaseBloc<RangeValues?>, BaseState<RangeValues?>>(
              bloc: controller.periodRange,
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (state.data!.end >
                                trainer.profile!.minBookingSlotDuration!) {
                              var value = state.data!.end;
                              value--;
                              controller.periodRange
                                  .successState(RangeValues(0, value));
                            }
                          },
                          child: Icon(
                            CupertinoIcons.minus_circle,
                            color: context.colors.primary,
                            size: 30.r,
                          ),
                        ),
                        Gaps.hGap4,
                        LimitedBox(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                          child: RangeSlider(
                            values: state.data!,
                            divisions: 90,
                            max: 90,
                            min: 0,
                            inactiveColor:
                                context.colors.primary.withValues(alpha: 0.1),
                            activeColor: context.colors.primary,
                            onChanged: (RangeValues values) {
                              if (values.start != state.data!.start) {
                                return;
                              } else if (values.end <
                                  trainer.profile!.minBookingSlotDuration!) {
                                return;
                              } else {
                                controller.periodRange.successState(values);
                              }
                            },
                          ),
                        ),
                        Gaps.hGap4,
                        InkWell(
                          onTap: () {
                            var value = state.data!.end;
                            value++;
                            controller.periodRange
                                .successState(RangeValues(0, value));
                          },
                          child: Icon(
                            Icons.add_circle,
                            color: context.colors.primary,
                            size: 30.r,
                          ),
                        ),
                      ],
                    ),
                    Gaps.vGap4,
                    Text(
                      "${state.data!.end.round()} mins.",
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style: AppTextStyle.s14_w400(color: context.colors.black),
                    ),
                  ],
                );
              }),
          Gaps.vGap16,
          Divider(
            color: context.colors.disableGray,
          ),
        ],
      ),
    );
  }
}
