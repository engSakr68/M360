import 'package:member360/core/constants/app_config.dart';

class ApiNames {
  static String baseUrl = AppConfig.instance.baseAPIUrl;

  static const String login = "member-api/login";
  static const String savePublicKey = "users/";
  static const String updateUser = "users/";
  static const String register = "auth/create_account";
  static const String activeAccount = "otp/verify";
  static const String resendCode = "ResendCode";
  static const String switchNotify = "SwitchNotify";
  static const String resetPassword = "member-api/forgot-password";
  static const String restorePassword = "member-api/reset-password";
  static const String profile = "member-api/profile";
  static const String changePassword = "member-api/profile/password";
  static const String switchUser = "member-api/switch-user";
  
  
  
  static const String classes = "member-api/classes";
  static const String gyms = "member-api/gyms";
  static const String activeGyms = "member-api/active-gyms";
  static const String bookClass = "member-api/book-class";
  static const String bookSession = "member-api/book-session";
  static const String cancelClass =
      "member-api/cancel-class-booking-by-schedule";
  static const String activePlans = "member-api/profile/gym";
  static const String memberInvoices = "member-api/profile/member-plans";
  static String deactivate(int gymId, int memberId) =>
      "member-api/$gymId/deactivate-account/$memberId";
  static String ptSessions(String header) => "member-api/session-calendar$header";
  static String classCalendar(String header) => "member-api/class-calendar$header";
  static String eventsClasses(String header) => "member-api/events-classes-calendar$header";
  static String downloadPayment(String header) => "member-plans/$header";
  static  String generateOP(String gymId) => "api/v2/members/access-control/openpath/$gymId/token";
  // static String changePassword(String header) => "member-api/profile/password$header";

  static String refreshToken = "${baseUrl}RefreshToken";
}
