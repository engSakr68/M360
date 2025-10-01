part of 'splash_imports.dart';

class SplashController {
  void manipulateSaveData(BuildContext context) async {
    advancedStatusCheck(newVersion);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var strUser = preferences.getString(ApplicationConstants.userSavedModel);
    if (strUser != null) {
      context.read<DeviceCubit>().updateUserAuth(true);
      UserModel user = UserModel.fromJson(json.decode(strUser));
      GlobalState.instance.set("token", user.token);
      debugPrint("token: ${user.token}");
      context.read<UserCubit>().onUpdateUserData(user);
      Future.delayed(const Duration(seconds: 4), () {
        
        AutoRouter.of(context).push(Dashboard(index: 0));
      });
    } else {
      await Future.delayed(const Duration(seconds: 4),
          () => AutoRouter.of(context).push(const IntroRoute()));
    }
  }

  final newVersion = NewVersionPlus(
    androidId: "com.PayChoice.Member360",
    iOSId: "com.PayChoice.Member360",
    // "id6471948304",
  );

  void advancedStatusCheck(NewVersionPlus newVersion) async {
    final status = await newVersion.getVersionStatus();
    print(status?.localVersion);
    print(status?.storeVersion);
  }
}
