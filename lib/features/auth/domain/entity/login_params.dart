class LoginParams {
  String password;
  String email;
  bool? mobile;

  LoginParams({
    required this.password,
    required this.email,
    this.mobile,
  });

  factory LoginParams.copyWith({
    required String email,
    required String password,
    required bool mobile,
  }) {
    return LoginParams(
      email: email,
      password: password,
      mobile: mobile,
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "mobile": true,
      };

  factory LoginParams.fromJson(Map<String, dynamic> json) => LoginParams(
        email: json['email'],
        password: json['password'],
        mobile: json['mobile'],
      );
}
