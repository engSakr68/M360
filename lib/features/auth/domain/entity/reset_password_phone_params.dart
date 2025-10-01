class ResetPasswordPhoneParams {
  String? mobilephone;
  bool? mobile;

  ResetPasswordPhoneParams(
      {
      this.mobilephone,
      required this.mobile});

  factory ResetPasswordPhoneParams.copyWith({
    required bool mobile,
    required String mobilephone,
  }) {
    return ResetPasswordPhoneParams(
      mobile: mobile,
      mobilephone: mobilephone,
    );
  }

  Map<String, dynamic> toJson() => {
        "mobilephone": mobilephone,
        "mobile": mobile,
      };

  factory ResetPasswordPhoneParams.fromJson(Map<String, dynamic> json) =>
      ResetPasswordPhoneParams(
        mobile: json['mobile'],
        mobilephone: json['mobilephone'],
      );
}
