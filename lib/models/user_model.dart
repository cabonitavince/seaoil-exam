import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.mobile,
    this.password,
  });

  String mobile;
  String password;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    mobile: json["mobile"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile,
    "password": password,
  };
}
