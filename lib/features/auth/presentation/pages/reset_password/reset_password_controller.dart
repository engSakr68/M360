part of 'reset_password_imports.dart';

class ResetPasswordController {
  final GlobalKey<FormState> emailKey = GlobalKey();
  final GlobalKey<FormState> phoneKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  ResetPasswordEmailParams resetEmailParams() {
    return ResetPasswordEmailParams(
      mobile: true,
        email: emailController.text,
    );
  }

  ResetPasswordPhoneParams resetPhoneParams() {
    return ResetPasswordPhoneParams(
        mobile: true,
        mobilephone: phoneController.text,
    );
  }

  Future<bool> resetByEmail(BuildContext context) async {
    if (_checkEmailValidation(context)) {
      ResetPasswordEmailParams params = resetEmailParams();
      var resetResponse = await getIt<AuthRepository>().resetPasswordByEmail(params);
      return _handleResetResponse(resetResponse, isEmail: true);
    } else {
      return false;
    }
  }

  Future<bool> resetByPhone(BuildContext context) async {
    if (_checkPhoneValidation(context)) {
      ResetPasswordPhoneParams params = resetPhoneParams();
      var resetResponse = await getIt<AuthRepository>().resetPasswordByPhone(params);
      return _handleResetResponse(resetResponse, isEmail: false);
    } else {
      return false;
    }
  }

  bool _handleResetResponse(MyResult<String> response, {required bool isEmail}) {
    final context = getIt<GlobalContext>().context();
    return response.when(isSuccess: (data) {
      AppSnackBar.showSimpleToast(
        color: context.colors.black,
        msg: "Code sent successfully",
        type: ToastType.success,
      );
      AutoRouter.of(context).push(RestorePassword(credintial: isEmail? emailController.text : phoneController.text, isEmail: isEmail));
      return true;
    }, isError: (error) {
      // AppSnackBar.showSimpleToast(
      //   msg: error.message,
      //   type: ToastType.error,
      // );
      return false;
    });
  }

  bool _checkEmailValidation(BuildContext context) {
    return emailKey.currentState!.validate();
  }

  bool _checkPhoneValidation(BuildContext context) {
    return phoneKey.currentState!.validate();
  }
}
