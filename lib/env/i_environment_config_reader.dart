abstract class IEnvironmentConfigReader {
  /// BASE URL
  String getBaseUrl();

  String getAPIUrl();

  String getAppId();

  String getLogoUrl();
  String getSplashLogo();

  String getAppNameAr();

  String getAppNameEN();

  String getAppEnvName();

  String getClientId();

  String getAnonymousClientId();

  String getAnonymousClientSECRET();

  String getAnonymousGrantType();

  String? getLocalLogoAssetsPath();

  String iosLink();
  String androidLink();
}
