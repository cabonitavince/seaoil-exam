import 'dart:convert';

LoginData dataFromJson(String str) => LoginData.fromJson(json.decode(str));

String dataToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
  LoginData({
    this.id,
    this.accessToken,
    this.refreshToken,
    this.userId,
    this.expiresAt,
    this.updatedAt,
    this.createdAt,
    this.userUuid,
  });

  int id;
  String accessToken;
  String refreshToken;
  int userId;
  DateTime expiresAt;
  DateTime updatedAt;
  DateTime createdAt;
  String userUuid;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    id: json["id"],
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
    userId: json["userId"],
    expiresAt: DateTime.parse(json["expiresAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    createdAt: DateTime.parse(json["createdAt"]),
    userUuid: json["userUuid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "userId": userId,
    "expiresAt": expiresAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
    "userUuid": userUuid,
  };
}