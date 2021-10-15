import 'dart:convert';

import 'package:seaoil_technical_exam/models/login_response/data_model.dart';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.data,
    this.status,
  });


  LoginData data;
  String status;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    data: LoginData.fromJson(json["data"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "status": status,
  };
}