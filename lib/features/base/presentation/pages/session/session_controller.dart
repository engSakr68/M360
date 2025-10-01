part of "session_imports.dart";

class SessionController {
  final GlobalKey<FormState> formKey = GlobalKey();

  BaseBloc<RangeValues?> periodRange = BaseBloc(null);

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  String? startDate;
  String? startTime;

  void initSession(TrainerModel trainer, String date, DateModel openTimesPerDay) {
    periodRange.successState(RangeValues(
        0, double.parse(trainer.profile!.minBookingSlotDuration.toString())));
    dateController = TextEditingController(
        text:
            DateFormat('yyyy-MM-dd').format(DateTime.parse(date)));
    startDate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
    timeController = TextEditingController(
        text: DateFormat('hh:mm').format(DateTime.parse("$startDate ${openTimesPerDay.start}")));
    startTime = DateFormat('hh:mm').format(DateTime.parse("$startDate ${openTimesPerDay.start}"));
  }

  void onStartDate(BuildContext context) async {
    AdaptivePicker.datePicker(
      initial: DateTime.now(),
      maxDate: DateTime(DateTime.now().year + 2),
      context: context,
      onConfirm: (v) => onConfirmDateBicker(context, v!),
      title: '',
    );
  }

  void onConfirmDateBicker(BuildContext context, DateTime value) {
    var local = context.read<DeviceCubit>().state.model.locale;
    startDate = DateFormat("yyyy-MM-dd", "en").format(value);
    var formatDate =
        DateFormat("yyyy-MMM-dd ", local.languageCode).format(value);
    dateController.text = formatDate;
  }

  void onStartTime(BuildContext context) {
    var local = context.read<DeviceCubit>().state.model.locale;
    AdaptivePicker.timePicker(
      context: context,
      onConfirm: (v) {
        timeController.text =
            DateFormat("hh:mm a", local.languageCode).format(v!);
        startTime = DateFormat("HH:mm").format(v);
      },
      title: "",
    );
  }

  Future<bool> bookPTSession(BuildContext context,
      {required TrainerModel trainer}) async {
    if (_checkFormValidation(context)) {
      SessionParams params = sessionParams(trainer);
      var bookResponse = await getIt<BaseRepository>().bookPTSession(params);
      return _handleBookResponse(bookResponse);
    } else {
      return false;
    }
  }

  SessionParams sessionParams(TrainerModel trainer) {
    var sTime = DateTime.parse("${startDate!} ${startTime!}");
    var endTime = TimeOfDay.fromDateTime(
        sTime.add(Duration(minutes: periodRange.state.data!.end.round())));
    return SessionParams(
      title: trainer.title,
      date: startDate,
      start: startTime,
      end:
          '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}',
      gymId: trainer.profile!.gymId,
      trainerId: trainer.id,
    );
  }

  bool _handleBookResponse(MyResult<BookSessionModel> response) {
    final context = getIt<GlobalContext>().context();
    return response.when(isSuccess: (bookModel) {
      AppSnackBar.showSimpleToast(
        color: context.colors.black,
        msg: "Session booked successfully",
        type: ToastType.success,
      );
      AutoRouter.of(context).push(Dashboard(index: 0));
      return true;
    }, isError: (error) {
      // AppSnackBar.showSimpleToast(
      //   msg: error.message,
      //   type: ToastType.error,
      // );
      return false;
    });
  }

  bool _checkFormValidation(BuildContext context) {
    return formKey.currentState!.validate();
  }
}
