part of 'profile_imports.dart';

class ProfileController {
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<FormState> passKey = GlobalKey();

  ObsValue<bool> oldVisibleObs = ObsValue.withInit(false);
  ObsValue<bool> visibleObs = ObsValue.withInit(false);
  ObsValue<bool> confirmVisibleObs = ObsValue.withInit(false);
  final ObsValue<bool> editCubit = ObsValue.withInit(false);

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController oldController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  String? dateEn;

  ProfileRequester profileRequester = ProfileRequester();

  Future<void> requestProfile() async {
    await profileRequester.request(fromRemote: false);
    // await profileRequester.request();
  }

  final ObsValue<File?> imageCubit = ObsValue.withInit(null);

  void initProfileData(UserInfoModel user) {
    emailController = TextEditingController(text: user.email);
    phoneController = TextEditingController(text: user.phone);
    fnameController = TextEditingController(text: user.fname);
    lnameController = TextEditingController(text: user.sname);
    dateController = TextEditingController(text: user.dob);
  }

  void passwordSheet(BuildContext context){
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return BuildPasswordSheet(controller: this);
      },
    );
  }

  void showDateBicker(BuildContext context) {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    _dateBicker(context);
  }

  void _dateBicker(BuildContext context) async {
    AdaptivePicker.datePicker(
      initial: DateTime.now(),
      minDate: DateTime(1920),
      maxDate: DateTime.now(),
      context: context,
      onConfirm: (v) => _onConfirmDateBicker(context, v!),
      title: '',
    );
  }

  void _onConfirmDateBicker(BuildContext context, DateTime value) {
    var local = context.read<DeviceCubit>().state.model.locale;
    dateEn = DateFormat("yyyy-MM-dd", "en").format(value);
    var formatDate =
        DateFormat("yyyy-MMM-dd ", local.languageCode).format(value);
    dateController.text = formatDate;
  }

  Future<bool> editProfile(BuildContext context) async {
    if (_checkFormValidation(context)) {
      ProfileParams params = profileParams();
      var profileResponse = await getIt<BaseRepository>().editProfile(params);
      return _handleProfileResponse(profileResponse);
    } else {
      return false;
    }
  }

  Future<bool> changePassword(BuildContext context) async {
    if (_checkPasswordValidation(context)) {
      PasswordParams params = passwordParams();
      var passwordResponse = await getIt<BaseRepository>().changePassword(params);
      return _handlePasswordResponse(passwordResponse);
    } else {
      return false;
    }
  }

  void logout() {
    var context = getIt<GlobalContext>().context();
    SharedPreferences.getInstance().then((prefs) {
      context.read<DeviceCubit>().updateUserAuth(false);
      prefs.remove("user");
      prefs.remove("active_gym");
      prefs.remove("gym_id");
      GlobalState.instance.set("token", null);
      AppSnackBar.showSimpleToast(
        color: context.colors.black,
        msg: "See you later ${fnameController.text}",
        type: ToastType.success,
      );
      AutoRouter.of(context).push(const IntroRoute());
    });
  }

  Future<void> getImage(BuildContext context) async {
    var image =
        await AppFileService().pickImagesFiles(context, allowMulti: false);
    if (image != null) {
      imageCubit.setValue(image.first);
    }
  }

  bool _handleProfileResponse(MyResult<UserInfoModel> response) {
    final context = getIt<GlobalContext>().context();
    return response.when(isSuccess: (userModel) {
      AppSnackBar.showSimpleToast(
        color: context.colors.black,
        msg: "Your profile updated successfully",
        type: ToastType.success,
      );
      editCubit.setValue(false);
      return true;
    }, isError: (error) {
      // AppSnackBar.showSimpleToast(
      //   msg: error.message,
      //   type: ToastType.error,
      // );
      return false;
    });
  }

  bool _handlePasswordResponse(MyResult<String> response) {
    final context = getIt<GlobalContext>().context();
    return response.when(isSuccess: (message) {
      AutoRouter.of(context).pop();
      oldController.clear();
      passwordController.clear();
      confirmController.clear();
      AppSnackBar.showSimpleToast(
        color: context.colors.black,
        msg: message ?? "Your password updated successfully",
        type: ToastType.success,
      );
      editCubit.setValue(false);
      return true;
    }, isError: (error) {
      // AppSnackBar.showSimpleToast(
      //   msg: error.message,
      //   type: ToastType.error,
      // );
      return false;
    });
  }

  ProfileParams profileParams() {
    return ProfileParams(
      email: emailController.text,
      fname: fnameController.text,
      sname: lnameController.text,
      phone: phoneController.text,
      dob: dateController.text,
      // photoUrl: imageCubit.getValue(),
    );
  }

  PasswordParams passwordParams() {
    return PasswordParams(
      currentPassword: oldController.text,
      newPassword: passwordController.text,
      confirmPassword: confirmController.text,
    );
  }

  bool _checkFormValidation(BuildContext context) {
    return formKey.currentState!.validate();
  }

  bool _checkPasswordValidation(BuildContext context) {
    return passKey.currentState!.validate();
  }
}
