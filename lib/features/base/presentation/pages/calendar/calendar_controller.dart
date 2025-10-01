part of "calendar_imports.dart";

class CalendarController {
  CalendarController() {
    initActiveGym();
    requestTrainers();
    dateCubit.successState(DateTime.now());
  }
  final ObsValue<bool> filterCubit = ObsValue.withInit(false);
  final ObsValue<bool> classPtCubit = ObsValue.withInit(true);
  final ObsValue<bool> chooseTrainerCubit = ObsValue.withInit(false);

  final BaseBloc<DateTime> dateCubit = BaseBloc(DateTime.now());

  final ObsValue<GymModel?> gymCubit = ObsValue.withInit(null);
  final ObsValue<TrainerModel?> trainerCubit = ObsValue.withInit(null);
  final ObsValue<List<TagModel>> tagCubit = ObsValue.withInit([]);
  final BaseBloc<GymModel?> mainGymCubit = BaseBloc(null);
  // final ObsValue<bool> loadingCubit = ObsValue.withInit(true);

  TextEditingController gymController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController trainerController = TextEditingController();

  GymRequester gymRequester = GymRequester();
  FilterRequester filterRequester = FilterRequester();

  late ClassesRequester classesRequester = ClassesRequester(_classParams());
  // late PTSessionRequester sessionsRequester = PTSessionRequester(_sessionParams());
  late TrainersRequester trainerRequester = TrainersRequester(_trainerParams());

  int getIndex(TrainerModel trainer) {
    var index = 0;
    
    switch (DateFormat('EEEE').format(dateCubit.data!)) {
      case "Sunday":
        index = 0;
        break;
      case "Monday":
        index = 1;
        break;
      case "Tuesday":
        index = 2;
        break;
      case "Wednesday":
        index = 3;
        break;
      case "Thursday":
        index = 4;
        break;
      case "Friday":
        index = 5;
        break;
      case "Saturday":
        index = 6;
        break;
    }
    print(DateFormat('EEEE').format(dateCubit.data!));
    print(index);
    print(trainer.openTimesPerDay?[index]);
    return index;
  }

  List<DateTime> getDateTimesBetween({
    required TrainerModel trainer,
  }) {
    var dateTimes = <DateTime>[];
    var current = DateTime.parse(DateFormat('yyyy-MM-dd hh:mm').format(
            DateTime.parse(
                ("${DateFormat('yyyy-MM-dd').format(dateCubit.data ?? DateTime.now())} ${trainer.openTimesPerDay![getIndex(trainer)].start}"))))
        .add(Duration(minutes: trainer.minSlotDuration ?? 5));
    var end = DateTime.parse(DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(
        ("${DateFormat('yyyy-MM-dd').format(dateCubit.data ?? DateTime.now())} ${trainer.openTimesPerDay![getIndex(trainer)].end}"))));
    while (current.isBefore(end)) {
      dateTimes.add(current);
      current = current.add(Duration(minutes: trainer.minSlotDuration ?? 5));
    }
    return dateTimes;
  }

  Future<void> requestGyms() async {
    await gymRequester.request(fromRemote: false);
    // await gymRequester.request();
  }

  Future<void> requestFilter() async {
    await filterRequester.request(fromRemote: false);
    // await filterRequester.request();
  }

  Future<void> requestClasses() async {
    ClassParams param = _classParams();
    classesRequester.onChangeParams(param);
    await classesRequester.request(fromRemote: false);
    // await classesRequester.request();
  }

  // Future<void> requestSessions() async {
  //   PTSessionParams param = _sessionParams();
  //   sessionsRequester.onChangeParams(param);
  //   await sessionsRequester.request(fromRemote: false);
  //   // await sessionsRequester.request();
  // }

  Future<void> requestTrainers() async {
    PTSessionParams param = _trainerParams();
    trainerRequester.onChangeParams(param);
    await trainerRequester.request(fromRemote: false);
    // await sessionsRequester.request();
  }

  void onChooseGym(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: _handleRoundedRectangleBorder(),
      context: context,
      builder: (context) {
        return BuildChooseGym(controller: this);
      },
    );
  }

  void onChooseTag(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: _handleRoundedRectangleBorder(),
      context: context,
      builder: (context) {
        return BuildChooseTag(controller: this);
      },
    );
  }

  void onChooseTrainer(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: _handleRoundedRectangleBorder(),
      context: context,
      builder: (context) {
        return BuildChooseTrainer(controller: this);
      },
    );
  }

  Future initActiveGym() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var activeGym = preferences.getString("active_gym");
    GymModel? gym = activeGym == null? null : GymModel.fromJson(json.decode(activeGym));
    mainGymCubit.successState(gym);
    requestClasses();
  }

  ClassParams _classParams() {
    return ClassParams(
        gymId: gymCubit.getValue()?.id,
        trainerId:
            trainerController.text.isEmpty ? null : trainerCubit.getValue()!.id,
        tags: tagController.text.isEmpty
            ? null
            : tagCubit.getValue().map((e) => e.id!).toList(),
        from: DateFormat('yyyy-MM-dd').format(dateCubit.data ?? DateTime.now()),
        to: DateFormat('yyyy-MM-dd').format(dateCubit.data ?? DateTime.now()));
  }

  // PTSessionParams _sessionParams() => PTSessionParams(
  //     gym: mainGymCubit.data!.id!,
  //     gymId: gymController.text.isEmpty ? null : gymCubit.getValue()!.id,
  //     trainerId:
  //         trainerController.text.isEmpty ? null : trainerCubit.getValue()!.id,
  //     tags: tagController.text.isEmpty
  //         ? null
  //         : tagCubit.getValue().map((e) => e.id!).toList(),
  //     from: DateFormat('yyyy-MM-dd').format(dateCubit.data ?? DateTime.now()),
  //     to: DateFormat('yyyy-MM-dd').format(
  //         dateCubit.data?.add(const Duration(days: 1)) ??
  //             DateTime.now().add(const Duration(days: 1))));

  PTSessionParams _trainerParams() => PTSessionParams(
      gym: mainGymCubit.data?.id,
      gymId: gymController.text.isEmpty ? null : gymCubit.getValue()!.id,
      tags: tagController.text.isEmpty
          ? null
          : tagCubit.getValue().map((e) => e.id!).toList(),
      from: DateFormat('yyyy-MM-dd').format(dateCubit.data ?? DateTime.now()),
      to: DateFormat('yyyy-MM-dd').format(
          dateCubit.data?.add(const Duration(days: 1)) ??
              DateTime.now().add(const Duration(days: 1))));

  RoundedRectangleBorder _handleRoundedRectangleBorder() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
    );
  }
}
