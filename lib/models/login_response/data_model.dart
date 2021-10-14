import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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