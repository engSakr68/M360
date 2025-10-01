part of "calendar_widgets_imports.dart";

class Test extends StatelessWidget {
  final CalendarController controller;
  const Test({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ObsValueConsumer(
        observable: controller.chooseTrainerCubit,
        builder: (context, state) {
          return Visibility(
              visible: state,
              replacement: const BuildTrainerWarning(),
              child: BlocBuilder<BaseBloc<DateTime>, BaseState<DateTime>>(
                  bloc: controller.dateCubit,
                  builder: (context, date) {
                    return ObsValueConsumer(
                        observable: controller.trainerCubit,
                        builder: (context, trainer) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16).r,
                            child: LimitedBox(
                              maxHeight: Dimens.screenHeight,
                              maxWidth: Dimens.screenWidth,
                              child: WeekView(
                                inScrollableWidget: false,
                                dates: [
                                  date.data!,
                                ],
                                eventWidgetBuilder: (event, height, width) {
                                  return GestureDetector(
                                    onTap: () {
                                      AutoRouter.of(context).push(SessionRoute(
                                        trainer: trainer!,
                                        openTimesPerDay:
                                            trainer.openTimesPerDay![
                                                controller.getIndex(trainer)],
                                        date: date.data.toString(),
                                      ));
                                    },
                                    child: Container(
                                      width: width,
                                      height: height,
                                      decoration: BoxDecoration(
                                        color: context.colors.primary,
                                      ),
                                      padding: const EdgeInsets.all(4),
                                    ),
                                  );
                                },
                                events: List.generate(
                                    1,
                                    (index) => FlutterWeekViewEvent(
                                          description:
                                              // trainer
                                              //         ?.openTimesPerDay?[controller.getIndex(trainer)]
                                              //         .end ??
                                              "",
                                          // onTap: () {
                                          //   AutoRouter.of(context)
                                          //       .push(SessionRoute(
                                          //     trainer: trainer,
                                          //     openTimesPerDay: trainer
                                          //             .openTimesPerDay![
                                          //         controller.getIndex(trainer)],
                                          //     date: date.data.toString(),
                                          //   ));
                                          // },
                                          // backgroundColor:
                                          //     context.colors.primary,
                                          start: DateTime.parse(intl.DateFormat(
                                                  'yyyy-MM-dd HH:mm')
                                              .format(DateTime.parse(
                                                  ("${intl.DateFormat('yyyy-MM-dd').format(date.data ?? DateTime.now())} ${trainer!.openTimesPerDay![controller.getIndex(trainer)].start}")))),
                                          end: DateTime.parse(intl.DateFormat(
                                                  'yyyy-MM-dd HH:mm')
                                              .format(DateTime.parse(
                                                  "${intl.DateFormat('yyyy-MM-dd').format(date.data ?? DateTime.now())} ${trainer.openTimesPerDay![controller.getIndex(trainer)].end}"))),
                                          title:
                                              // trainer.openTimesPerDay?[index]
                                              // .start ??
                                              "",
                                        )),
                              ),
                            ),
                          );
                        });
                  }));
        });
  }
}
