class ResetPasswordEmailParams {
  String? email;
  bool? mobile;

  ResetPasswordEmailParams({
    this.email,
    required this.mobile,
  });

  factory ResetPasswordEmailParams.copyWith({
    required String email,
    required bool mobile,
  }) {
    return ResetPasswordEmailParams(
      email: email,
      mobile: mobile,
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "mobile": mobile,
      };

  factory ResetPasswordEmailParams.fromJson(Map<String, dynamic> json) =>
      ResetPasswordEmailParams(
        email: json['email'],
        mobile: json['mobile'],
      );
}
