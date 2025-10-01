part of "restore_password_imports.dart";

class RestorePasswordController{
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<CustomButtonState> btnKey = GlobalKey();

  ObsValue<bool> visibleObs = ObsValue.withInit(false);
  ObsValue<bool> confirmVisibleObs = ObsValue.withInit(false);

  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  RestorePasswordParams restorePasswordParams(String credintial, bool isEmail) {
    return isEmail? RestorePasswordParams(
        mobile: true,
        email: credintial,
        password: passwordController.text,
        code: codeController.text,
    ) : RestorePasswordParams(
        mobile: true,
        mobilephone: credintial,
        password: passwordController.text,
        code: codeController.text,
    );
  }

  Future<bool> restorePassword(BuildContext context, {required String credintial, required bool isEmail}) async {
    if (_checkFormValidation(context)) {
      RestorePasswordParams params = restorePasswordParams(credintial, isEmail);
      var restoreResponse = await getIt<AuthRepository>().restorePassword(params);
      return _handleRestoreResponse(restoreResponse);
    } else {
      return false;
    }
  }

  bool _handleRestoreResponse(MyResult<String> response) {
    final context = getIt<GlobalContext>().context();
    return response.when(isSuccess: (data) {
      AppSnackBar.showSimpleToast(
        color: context.colors.black,
        msg: "Your passwored restored successfully",
        type: ToastType.success,
      );
      AutoRouter.of(context).push(const IntroRoute());
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