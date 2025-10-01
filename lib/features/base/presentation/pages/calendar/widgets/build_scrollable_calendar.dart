part of "calendar_widgets_imports.dart";

class BuildScrollableCalendar extends StatelessWidget {
  final CalendarController controller;
  const BuildScrollableCalendar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomCalendarTimeline(
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 10),
      onDateSelected: (date) {
        // controller.loadingCubit.setValue(true);
        controller.dateCubit.successState(date);
        controller.requestClasses();
        controller.requestTrainers();
      },
      leftMargin: 16.r,
      shrink: true,
      monthColor: context.colors.disableGray,
      dayColor: context.colors.disableGray,
      activeDayColor: context.colors.primary,
      dayNameColor: context.colors.primary,
      inactiveDayNameColor: context.colors.disableGray,
      activeBackgroundDayColor: context.colors.primary,
      dotsColor: Colors.transparent,
      locale: 'en_ISO',
    );
    // EasyDateTimeLine(
    //   initialDate: DateTime.now(),
    //   onDateChange: (selectedDate) {
    //     //`selectedDate` the new date selected.
    //   },
    //   headerProps: EasyHeaderProps(
    //     showHeader: true,
    //     showMonthPicker: true,
    //     showSelectedDate: true,
    //     monthPickerType: MonthPickerType.dropDown,
    //     selectedDateFormat: SelectedDateFormat.fullDateDMY,
    //     monthStyle: AppTextStyle.s12_w700(color: context.colors.black),
    //     selectedDateStyle: AppTextStyle.s12_w700(color: context.colors.black),
    //   ),
    //   dayProps: EasyDayProps(
    //     width: 50.w,
    //     height: 50.h,
    //     dayStructure: DayStructure.dayStrDayNum,
    //     activeDayStyle: DayStyle(
    //       decoration: BoxDecoration(
    //         color: context.colors.primary.withValues(alpha: 0.1),
    //         border: Border.all(color: context.colors.primary),
    //         borderRadius: BorderRadius.circular(10).r,
    //       ),
    //       dayStrStyle: AppTextStyle.s12_w700(color: context.colors.primary),
    //       monthStrStyle: AppTextStyle.s12_w700(color: context.colors.primary),
    //       dayNumStyle: AppTextStyle.s12_w700(color: context.colors.primary),
    //     ),
    //     inactiveDayStyle: DayStyle(
    //       decoration: BoxDecoration(
    //         color: context.colors.white,
    //         border: Border.all(color: context.colors.disableGray),
    //         borderRadius: BorderRadius.circular(10).r,
    //       ),
    //       dayStrStyle: AppTextStyle.s12_w700(color: context.colors.disableGray),
    //       monthStrStyle:
    //           AppTextStyle.s12_w700(color: context.colors.disableGray),
    //       dayNumStyle: AppTextStyle.s12_w700(color: context.colors.disableGray),
    //     ),
    //     todayStyle: DayStyle(
    //       decoration: BoxDecoration(
    //         color: context.colors.white,
    //         border: Border.all(color: context.colors.disableGray),
    //         borderRadius: BorderRadius.circular(10).r,
    //       ),
    //       dayStrStyle: AppTextStyle.s12_w700(color: context.colors.disableGray),
    //       monthStrStyle:
    //           AppTextStyle.s12_w700(color: context.colors.disableGray),
    //       dayNumStyle: AppTextStyle.s12_w700(color: context.colors.disableGray),
    //     ),
    //   ),
    //   timeLineProps: EasyTimeLineProps(
    //     hPadding: 16.r, // padding from left and right
    //     separatorPadding: 8.r, // padding between days
    //   ),
    // );
  }
}
