part of "session_imports.dart";

@RoutePage(name: "SessionRoute")
class Session extends StatefulWidget {
  final TrainerModel trainer;
  final String date;
  final DateModel openTimesPerDay;
  const Session(
      {super.key,
      required this.trainer,
      required this.openTimesPerDay,
      required this.date});

  @override
  State<StatefulWidget> createState() => _SessionState();
}

class _SessionState extends State<Session> with TickerProviderStateMixin {
  SessionController controller = SessionController();

  @override
  void initState() {
    controller.initSession(widget.trainer, widget.date, widget.openTimesPerDay);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: "Schedule a PT Session",
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20).r,
        children: [
          BuildTrainerInfo(trainer: widget.trainer),
          BuildSessionPrice(trainer: widget.trainer),
          BuildBookSession(
            trainer: widget.trainer,
            controller: controller,
          ),
          BuildSessionButton(controller: controller, trainer: widget.trainer),
        ],
      ),
    );
  }
}
