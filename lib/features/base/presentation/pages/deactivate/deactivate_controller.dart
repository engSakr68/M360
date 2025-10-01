part of "deactivate_imports.dart";

class DeactivateController {
  final GlobalKey<FormState> formKey = GlobalKey();

  HandSignatureControl signatureController = HandSignatureControl(
    threshold: 0.01,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

  final BaseBloc<String> reasonCubit = BaseBloc("");
  final BaseBloc<String> descriptionCubit = BaseBloc("");
  final BaseBloc<String> recommendCubit = BaseBloc("");

  TextEditingController reasonController = TextEditingController();
  TextEditingController otherReasonController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController otherDescriptionController = TextEditingController();
  TextEditingController likeController = TextEditingController();
  TextEditingController recommendController = TextEditingController();
  TextEditingController otherController = TextEditingController();

  File? signature;

  List<String> reasons = [
    "Financial",
    "Relocating",
    "Not using",
    "Changing gym",
    "Other"
  ];
  List<String> descriptions = [
    "Facilities",
    "Policies",
    "Overcrowded",
    "Other"
  ];
  List<String> recommendations = ["Yes", "No"];

  void setReason(BuildContext context, String reason) {
    reasonCubit.successState(reason);
    reasonController.text = reason;
    AutoRouter.of(context).popForced();
  }

  void setDescription(BuildContext context, String reason) {
    descriptionCubit.successState(reason);
    descriptionController.text = reason;
    AutoRouter.of(context).popForced();
  }

  void setRecommend(BuildContext context, String reason) {
    recommendCubit.successState(reason);
    recommendController.text = reason;
    AutoRouter.of(context).popForced();
  }

  void onChooseReason(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: _handleRoundedRectangleBorder(),
      context: context,
      builder: (context) {
        return BuildChooseReason(controller: this);
      },
    );
  }

  void onChooseDescription(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: _handleRoundedRectangleBorder(),
      context: context,
      builder: (context) {
        return BuildChooseDescription(controller: this);
      },
    );
  }

  void onChooseRecommend(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: _handleRoundedRectangleBorder(),
      context: context,
      builder: (context) {
        return BuildChooseRecommend(controller: this);
      },
    );
  }

  void signatureAlert(BuildContext context, UserInfoModel profile) {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: context.colors.white,
              shadowColor: context.colors.white,
              surfaceTintColor: context.colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20).r,
              ),
              title: Text(
                "Sign here",
                style: AppTextStyle.s20_w500(color: context.colors.black),
              ),
              content: BuildDeactiveSignature(
                controller: this,
                profile: profile,
              ));
        },
      );
    }
  }

  Future<bool> setDeactivate(BuildContext context, {required UserInfoModel profile}) async {
    // if (_checkFormValidation(context)) {
      DeactivateParams params = deactivateParams(profile);
      var deactivateResponse = await getIt<BaseRepository>().deactivate(params);
      return _handleDeactivateResponse(deactivateResponse);
    // } else {
    //   return false;
    // }
  }

  bool _handleDeactivateResponse(MyResult<String> response) {
    final context = getIt<GlobalContext>().context();
    return response.when(isSuccess: (data) {
      AppSnackBar.showSimpleToast(
        color: context.colors.black,
        msg: data ?? "",
        type: ToastType.success,
      );
      SharedPreferences.getInstance().then((prefs) {
        context.read<DeviceCubit>().updateUserAuth(false);
        prefs.remove("user");
        GlobalState.instance.set("token", null);
        AutoRouter.of(context).push(const IntroRoute());
      });
      return true;
    }, isError: (error) {
      // AppSnackBar.showSimpleToast(
      //   msg: error.message,
      //   type: ToastType.error,
      // );
      return false;
    });
  }

  Future drawSignature(BuildContext context, {required UserInfoModel profile}) async {
    if (signatureController.isFilled) {
      ByteData? data = await signatureController.toImage();
      final buffer = data?.buffer;
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      var filePath =
          '$tempPath/file_01.tmp'; // file_01.tmp is dump file, can be anything
      signature = await File(filePath).writeAsBytes(
          buffer!.asUint8List(data!.offsetInBytes, data.lengthInBytes));
      setDeactivate(context, profile: profile);
    } else {
      AppSnackBar.showSimpleToast(
        msg: "You must draw your signature to proceed",
        type: ToastType.error,
      );
    }
  }

  DeactivateParams deactivateParams(UserInfoModel profile) {
    return DeactivateParams(
      reason: reasonCubit.data == "Other"
          ? otherReasonController.text
          : reasonController.text,
      negative: descriptionCubit.data == "Other"
          ? otherDescriptionController.text
          : descriptionController.text,
      positive: likeController.text,
      recommend: recommendController.text,
      general: otherController.text,
      signature: signature!,
      gymId: profile.activeGyms![0].id!,
      memberId: profile.id!,
    );
  }

  bool _checkFormValidation(BuildContext context) {
    return formKey.currentState!.validate();
  }

  RoundedRectangleBorder _handleRoundedRectangleBorder() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
    );
  }
}
