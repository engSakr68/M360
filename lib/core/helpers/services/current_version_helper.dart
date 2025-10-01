import 'package:package_info_plus/package_info_plus.dart';

class CurrentVersionHelper {

  CurrentVersionHelper._();

  static CurrentVersionHelper instance = CurrentVersionHelper._();
  late PackageInfo packageInfo;

  Future<void> init() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  String get currentVersion => packageInfo.version;
}
