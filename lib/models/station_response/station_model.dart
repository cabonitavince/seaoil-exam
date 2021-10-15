import 'dart:convert';

import 'package:seaoil_technical_exam/models/station_response/data.dart';

StationResponseModel stationResponseModelFromJson(String str) => StationResponseModel.fromJson(json.decode(str));

String stationResponseModelToJson(StationResponseModel data) => json.encode(data.toJson());

class StationResponseModel {
  StationResponseModel({
    this.data,
    this.status,
  });

  List<StationData> data;
  String status;

  factory StationResponseModel.fromJson(Map<String, dynamic> json) => StationResponseModel(
    data: List<StationData>.from(json["data"].map((x) => StationData.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}