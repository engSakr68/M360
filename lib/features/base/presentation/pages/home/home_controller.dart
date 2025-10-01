part of 'home_imports.dart';

class HomeController {
  final GlobalKey<FormState> formKey = GlobalKey();

  final BaseBloc<GymModel?> gymCubit = BaseBloc(null);
  final ObsValue<InvoiceModel?> invoicesCubit = ObsValue.withInit(null);
  final ObsValue<ActivePlanModel?> planCubit = ObsValue.withInit(null);

  final BaseBloc<bool> activeCubit = BaseBloc(false);
  final BaseBloc<bool> loadingCubit = BaseBloc(false);

  ProfileRequester profileRequester = ProfileRequester();
  ActiveGymRequester activeGymRequester = ActiveGymRequester();

  late ActivePlansRequester activePlanRequester;
  late MemberInvoicesRequester invoicesRequester;
  late ClassCalendarRequester classesRequester;
  late PTSessionRequester sessionsRequester;

  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();

  String startDate = "";
  String endDate = "";

  late String _localPath;
  late TargetPlatform? platform;

  Future<void> requestProfile() async {
    await profileRequester.request(fromRemote: false);
    // await profileRequester.request();
  }

  Future<void> requestActiveGym() async {
    await activeGymRequester.request(fromRemote: false);
    // await activeGymRequester.request();
  }

  Future<void> requestMemberInvoices(String param) async {
    invoicesRequester.onChangeParams(param);
    await invoicesRequester.request(fromRemote: false);
    // await invoicesRequester.request();
  }

  Future<void> requestActivePlans(String param) async {
    activePlanRequester.onChangeParams(param);
    await activePlanRequester.request(fromRemote: false);
    // await activePlanRequester.request();
  }

  Future<void> requestClasses() async {
    ClassParams param = classParams();
    classesRequester.onChangeParams(param);
    await classesRequester.request(fromRemote: false);
    // await classesRequester.request();
  }

  Future<void> requestSessions(String memberId) async {
    PTSessionParams param = sessionParams(memberId);
    sessionsRequester.onChangeParams(param);
    await sessionsRequester.request(fromRemote: false);
    // await sessionsRequester.request();
  }

  ClassParams classParams() => ClassParams(
      tags: [],
      bookedOnly: true,
      gymId: gymCubit.data?.id,
      from: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      to: DateFormat('yyyy-MM-dd').format(DateTime.now()
          .add(const Duration(days: 180, hours: 23, minutes: 59))));

  PTSessionParams sessionParams(String memberId) => PTSessionParams(
      memberId: memberId,
      gym: gymCubit.data?.id,
      bookedOnly: true,
      from: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      to: DateFormat('yyyy-MM-dd').format(
          DateTime.now().add(const Duration(days: 6, hours: 23, minutes: 59))));

  TextEditingController gymController = TextEditingController();

  void setPlatform() {
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
  }

  Future<void> prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return "/sdcard/download/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return '${directory.path}${Platform.pathSeparator}Download';
    }
  }

  void openDownloadedFile() async {
    final filePath = "$_localPath/$startDate&$endDate.pdf";
    // final extension = path.extension(filePath);
    await OpenFile.open(filePath, type: "application/pdf");
  }

  void downloadPayment(BuildContext context,
      {required String memberPlanId}) async {
    await prepareSaveDir();
    if (_checkFormValidation(context)) {
      try {
        await Dio().download(
            "${AppConfig.instance.baseAPIUrl}api/member-plans/$memberPlanId/download-invoices?from=$startDate&to=$endDate",
            "$_localPath/$startDate&$endDate.pdf");
        AppSnackBar.showSimpleToast(
          color: context.colors.black,
          msg: "Download Completed.",
          type: ToastType.success,
        );
        openDownloadedFile();
        startController.clear();
        endController.clear();
        AutoRouter.of(context).popForced();
      } catch (e) {
        startController.clear();
        endController.clear();
        AppSnackBar.showSimpleToast(
          color: context.colors.black,
          msg: "Download Failed.",
          type: ToastType.error,
        );
        AutoRouter.of(context).popForced();
      }
    }
  }

  bool _checkFormValidation(BuildContext context) {
    return formKey.currentState!.validate();
  }

  void onChooseGym(BuildContext context, List<GymModel>? data) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: _handleRoundedRectangleBorder(),
      context: context,
      builder: (context) {
        return BuildChooseGym(controller: this, data: data);
      },
    );
  }

  void getUserGym(GymModel? model) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var strGym = preferences.getString("active_gym");
    if (strGym != null) {
      GymModel gym = GymModel.fromJson(json.decode(strGym));
      setActiveGym(gym);
    } else {
      if (model != null) {
        setActiveGym(model);
      }
    }
  }

  Future setActiveGym(GymModel model) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    gymCubit.successState(model);
    preferences.setString("active_gym", json.encode(model.toJson()));
    preferences.setString("gym_id", model.id.toString());
    gymController.text = model.name ?? "";
    switchUser(model);
  }

  Future<bool> payInvoice(BuildContext context,
      {required String gymId, required String memberPlanId}) async {
    PayInvoiceParams params = payParams(gymId, memberPlanId);
    var payResponse = await getIt<BaseRepository>().payInvoice(params);
    return _handlePayResponse(payResponse);
  }

  bool _handlePayResponse(MyResult<String> response) {
    final context = getIt<GlobalContext>().context();
    return response.when(isSuccess: (data) {
      AppSnackBar.showSimpleToast(
        color: context.colors.black,
        msg: data ?? "",
        type: ToastType.success,
      );
      activeCubit.successState(false);
      AutoRouter.of(context).popForced();
      return true;
    }, isError: (error) {
      // AppSnackBar.showSimpleToast(
      //   msg: error.message,
      //   type: ToastType.error,
      // );
      return false;
    });
  }

  PayInvoiceParams payParams(String gymId, String memberPlanId) {
    return PayInvoiceParams(
        gymId: gymId,
        date: invoicesCubit.getValue()!.scheduledDate!,
        amount: invoicesCubit.getValue()!.amount!,
        memberPlanId: memberPlanId);
  }

  void showDateBicker(BuildContext context, String type) {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    _dateBicker(context, type);
  }

  void _dateBicker(BuildContext context, String type) async {
    AdaptivePicker.datePicker(
      initial: DateTime.now(),
      minDate: DateTime(DateTime.now().year - 100),
      maxDate: DateTime.now(),
      context: context,
      onConfirm: (v) => type == "start"
          ? onConfirmStart(context, v!)
          : onConfirmEnd(context, v!),
      title: '',
    );
  }

  void onConfirmStart(BuildContext context, DateTime value) {
    var local = context.read<DeviceCubit>().state.model.locale;
    startDate = DateFormat("yyyy-MM-dd", "en").format(value);
    var formatDate =
        DateFormat("dd/MM/yyyy ", local.languageCode).format(value);
    startController.text = formatDate;
  }

  void onConfirmEnd(BuildContext context, DateTime value) {
    var local = context.read<DeviceCubit>().state.model.locale;
    endDate = DateFormat("yyyy-MM-dd", "en").format(value);
    var formatDate =
        DateFormat("dd/MM/yyyy ", local.languageCode).format(value);
    endController.text = formatDate;
  }

  void showPlans(BuildContext context, {required String gymId}) {
    showModalBottomSheet(
      backgroundColor: context.colors.white,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: _handleRoundedRectangleBorder(),
      context: context,
      builder: (context) {
        return BuildMemberPlans(
          controller: this,
          gymId: gymId,
        );
      },
    );
  }

  void showInvoicess(BuildContext context,
      {required String gymId, required String memberPlanId}) {
    showModalBottomSheet(
      backgroundColor: context.colors.white,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: _handleRoundedRectangleBorder(),
      context: context,
      builder: (context) {
        return BuildMemberInvoices(
          controller: this,
          gymId: gymId,
          memberPlanId: memberPlanId,
        );
      },
    );
  }

  void showDownload(BuildContext context, {required String memberPlanId}) {
    showModalBottomSheet(
      backgroundColor: context.colors.white,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: _handleRoundedRectangleBorder(),
      context: context,
      builder: (context) {
        return BuildDownloadForm(
          controller: this,
          memberPlanId: memberPlanId,
        );
      },
    );
  }

  Future<bool> switchUser(GymModel gym) async {
    SwitchUserParams params = SwitchUserParams(
      memberId: gym.memberId!,
      gymId: gym.id!,
    );
    var tokenResponse = await getIt<BaseRepository>().switchUser(params);
    return _handleTokenResponse(tokenResponse, model: gym);
  }

  bool _handleTokenResponse(MyResult<String> response,
      {required GymModel model}) {
    return response.when(isSuccess: (token) {
      GlobalState.instance.set("token", token);
      classesRequester = ClassCalendarRequester(classParams());
      activePlanRequester = ActivePlansRequester(model.id.toString());
      // invoicesRequester = MemberInvoicesRequester(model.id.toString());
      requestProfile();
      // requestMemberInvoices(model.id.toString());
      requestActivePlans(model.id.toString());
      requestClasses();
      return true;
    }, isError: (error) {
      // AppSnackBar.showSimpleToast(
      //   msg: error.message,
      //   type: ToastType.error,
      // );
      return false;
    });
  }

  RoundedRectangleBorder _handleRoundedRectangleBorder() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
    );
  }

  Future<bool> generateOP() async {
    final response = await getIt<BaseRepository>().generateOP(true);
    return _handleOPResponse(response);
  }

  bool _handleOPResponse(MyResult<String> response) => response.when(
        isSuccess: (token) {
          final context = getIt<GlobalContext>().context();
          // UserHelperService.instance.saveOPData(token!);
          AutoRouter.of(context).push(OpenPathDemoRoute(token: token??""));
          // provision(token);
          return true;
        },
        isError: (_) => false,
      );
}
