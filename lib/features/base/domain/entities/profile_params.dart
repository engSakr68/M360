import 'dart:io';

class ProfileParams {
  String fname;
  String sname;
  String dob;
  String email;
  String phone;
  File? photoUrl;

  ProfileParams({
    required this.fname,
    required this.sname,
    required this.email,
    required this.phone,
    required this.dob,
    this.photoUrl,
  });

  factory ProfileParams.copyWith({
    required String fname,
    required String sname,
    required String email,
    required String phone,
    required String dob,
    File? photoUrl,
  }) {
    return ProfileParams(
      fname: fname,
      sname: sname,
      dob: dob,
      email: email,
      phone: phone,
      photoUrl: photoUrl,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "fname": fname,
      "sname": sname,
      "email": email,
      "mobilephone": phone,
      "dob": dob,
    };
    if (photoUrl != null) {
      json.addAll({"file": photoUrl});
    }
    return json;
  }

  factory ProfileParams.fromJson(Map<String, dynamic> json) => ProfileParams(
        fname: json['fname'],
        sname: json['sname'],
        email: json['email'],
        phone: json['mobilephone'],
        dob: json['dob'],
        photoUrl: json['file'],
      );
}
