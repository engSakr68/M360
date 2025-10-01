// part of "calendar_widgets_imports.dart";

// class CalendarSessionList extends StatelessWidget {
//   final CalendarController controller;
//   const CalendarSessionList({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return ObsValueConsumer(
//         observable: controller.chooseTrainerCubit,
//         builder: (context, state) {
//           return Visibility(
//               visible: state,
//               replacement: const BuildTrainerWarning(),
//               child: BlocBuilder<BaseBloc<DateTime>, BaseState<DateTime>>(
//                   bloc: controller.dateCubit,
//                   builder: (context, date) {
//                     return ObsValueConsumer(
//                         observable: controller.trainerCubit,
//                         builder: (context, trainer) {
//                           return Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 16).r,
//                             child: LimitedBox(
//                               maxHeight: Dimens.screenHeight,
//                               maxWidth: Dimens.screenWidth,
//                               child: WeekView(
//                                 inScrollableWidget: false,
//                                 dates: [
//                                   date.data!,
//                                 ],
//                                 events: List.generate(
//                                     controller
//                                         .getDateTimesBetween(
//                                           trainer: trainer!,
//                                         )
//                                         .length,
//                                     (index) => FlutterWeekViewEvent(
//                                           description:
//                                               // trainer
//                                               //         ?.openTimesPerDay?[index]
//                                               //         .end ??
//                                               "",
//                                           onTap: () {
//                                             AutoRouter.of(context)
//                                                 .push(SessionRoute(
//                                               trainer: trainer,
//                                               openTimesPerDay: trainer
//                                                   .openTimesPerDay![index],
//                                               date: date.data.toString(),
//                                             ));
//                                           },
//                                           backgroundColor:
//                                               context.colors.primary,
//                                           start: controller.getDateTimesBetween(
//                                             trainer: trainer,
//                                           )[index],
//                                           end: controller.getDateTimesBetween(
//                                             trainer: trainer,
//                                           )[index],
//                                           title:
//                                               // trainer.openTimesPerDay?[index]
//                                               // .start ??
//                                               "",
//                                         )),
//                               ),
//                             ),
//                           );
//                         });
//                   }));
//         });
//   }
// }
