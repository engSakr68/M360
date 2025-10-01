// ignore_for_file: use_build_context_synchronously

part of 'login_imports.dart';

class LoginController {
  ObsValue<bool> visibleObs = ObsValue.withInit(false);

  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// to submit the login form
  Future<bool> onSubmitLoginBtn(BuildContext context) async {
    if (_checkFormValidation(context)) {
      LoginParams params = loginParams();
      var loginResponse = await getIt<AuthRepository>().login(params);
      return _handleLoginResponse(loginResponse);
    } else {
      return false;
    }
  }

  // Future<String?> _getFirebaseToken() async {
  //   var deviceId = await FirebaseMessaging.instance.getToken();
  //   try {
  //     deviceId = await FirebaseMessaging.instance.getAPNSToken();
  //   } catch (e) {
  //     deviceId = "";
  //   }
  //   return deviceId;
  // }

  bool _handleLoginResponse(MyResult<UserModel> response) {
    final context = getIt<GlobalContext>().context();
    return response.when(isSuccess: (userModel) {
      context.read<UserCubit>().onUpdateUserData(userModel!);
      GlobalState.instance.set("token", response.data?.token);
      UserHelperService.instance.saveUserData(userModel);
      AppSnackBar.showSimpleToast(
        color: context.colors.black,
        msg: "Welcome to Member360 ${userModel.info.fname}",
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

  /// handle login params
  LoginParams loginParams() {
    return LoginParams(
      password:
          getIt<Utilities>().convertDigitsToLatin(passwordController.text),
      email: emailController.text,
    );
  }

  bool _checkFormValidation(BuildContext context) {
    return formKey.currentState!.validate();
  }
}
