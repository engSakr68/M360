class PasswordParams {
  String currentPassword;
  String newPassword;
  String confirmPassword;

  PasswordParams({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  factory PasswordParams.copyWith({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    return PasswordParams(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "current_password": currentPassword,
      "new_password": newPassword,
      "new_password_confirmation": confirmPassword,
      "_method": "patch",
    };
    return json;
  }

  factory PasswordParams.fromJson(Map<String, dynamic> json) => PasswordParams(
        currentPassword: json['current_password'],
        newPassword: json['new_password'],
        confirmPassword: json['new_password_confirmation'],
      );
}

// class PasswordParams {
//   String currentPassword;
//   String newPassword;
//   String confirmPassword;

//   PasswordParams({
//     required this.currentPassword,
//     required this.newPassword,
//     required this.confirmPassword,
//   });

//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {
//       "current_password": currentPassword,
//       "new_password": newPassword,
//       "new_password_confirmation": confirmPassword,
//     };
//     return json;
//   }

//   String header() {
//     String header = "";
//     // "?current_password=$currentPassword&new_password=$newPassword&new_password_confirmation=$confirmPassword";
//     return header;
//   }
// }
