part of "calendar_imports.dart";

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<StatefulWidget> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final CalendarController controller = CalendarController();

  @override
  void initState() {
    // controller.requestGyms();
    // controller.requestFilter();
    // controller.initActiveGym();
    // controller.requestClasses();
    // controller.requestSessions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CalendarAppBar(
        controller: controller,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50).r,
          child: Column(
            // padding: const EdgeInsets.only(bottom: 50).r,
            children: [
              BuildCalendarFilter(
                controller: controller,
              ),
              BuildScrollableCalendar(
                controller: controller,
              ),
              // Gaps.vGap32,
              BuildClassPT(
                controller: controller,
              ),
              ObsValueConsumer(
                  observable: controller.classPtCubit,
                  builder: (context, state) {
                    return Visibility(
                        visible: state,
                        replacement: 
                        // CalendarSessionList(controller: controller),
                        Test(controller: controller),
                        child: CalendarClassList(
                          controller: controller,
                        ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
