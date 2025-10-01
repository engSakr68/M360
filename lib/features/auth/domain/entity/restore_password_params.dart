class RestorePasswordParams {
  String? mobilephone;
  String? email;
  String? code;
  String? password;
  bool? mobile;

  RestorePasswordParams(
      {this.email,
      this.mobilephone,
      required this.mobile,
      required this.code,
      required this.password});

  factory RestorePasswordParams.copyWith({
    required String email,
    required String password,
    required bool mobile,
    required String code,
    required String mobilephone,
  }) {
    return RestorePasswordParams(
      email: email,
      password: password,
      mobile: mobile,
      mobilephone: mobilephone,
      code: code
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "mobilephone": mobilephone,
        "mobile": mobile,
        "password": password,
        "code": code,
      };

  factory RestorePasswordParams.fromJson(Map<String, dynamic> json) =>
      RestorePasswordParams(
        email: json['email'],
        password: json['password'],
        mobile: json['mobile'],
        mobilephone: json['mobilephone'],
        code: json['code'],
      );
}
